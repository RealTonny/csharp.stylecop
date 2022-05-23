var target = Argument("target", "Pack");
var project = "csharp.stylecop";
var release = ParseReleaseNotes("RELEASE_NOTES.md");
var paket = ".paket/paket";

//////////////////////////////////////////////////////////////////////
// TASKS
//////////////////////////////////////////////////////////////////////

Task("Pack")
    .Does(() =>
{
    var exitCode = StartProcess(paket, $"pack --version {release.SemVersion.ToString()} artifacts");
    if (exitCode != 0)
    {
        throw new Exception($"Paket pack exit code: {exitCode}");
    }
});

//////////////////////////////////////////////////////////////////////
// EXECUTION
//////////////////////////////////////////////////////////////////////

RunTarget(target);