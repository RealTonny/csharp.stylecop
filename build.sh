#!/usr/bin/env bash

set -eu
set -o pipefail

PAKET_TOOL_PATH=.paket
CAKE_TOOL_PATH=.cake
PAKET="$PAKET_TOOL_PATH"/paket
CAKE = "$CAKE_TOOL_PATH"/dotnet-cake

if ! [ -e "$PAKET" ]
then
  dotnet tool install Paket --version 7.1.5 --tool-path "$PAKET_TOOL_PATH"
fi

if ! [ -e "$CAKE" ]
then
  dotnet tool install Cake.Tool --version 2.2.0 --tool-path "$CAKE_TOOL_PATH"
fi
ls "$CAKE_TOOL_PATH"
"$PAKET" install
dotnet restore
export MSBUILDSINGLELOADCONTEXT=1
export MSBUILDDISABLENODEREUSE=1

"$CAKE" -- "$@"