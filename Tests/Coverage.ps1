Invoke-ScriptAnalyzer Logger.psm1
Invoke-ScriptAnalyzer Src\*

$sourceFiles = (
    @{ Path = ".\Logger.psm1" },
    @{ Path = ".\Src\*" },
    @{ Path = ".\Src\*\*" }
)

$pesterConfig = @{
    path = '.\Tests\Logger.Tests.ps1'
    CodeCoverage = $sourceFiles
}

Invoke-Pester @pesterConfig