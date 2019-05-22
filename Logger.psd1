@{
    RootModule = 'Logger.psm1'
    ModuleVersion = '1.0.7'
    GUID = '5a14484f-b3bb-40c6-822d-e6f783000cf2'
    Author = 'n8tb1t'
    CompanyName = 'n8tb1t'
    Copyright = '(c) 2019 n8tb1t, licensed under MIT License.'
    Description = 'A log4net compatible PowerShell logger with custom appenders support!'
    PowerShellVersion = '5.0'
    HelpInfoURI       = 'https://github.com/n8tb1t/Logger/blob/master/README.md'
    
    RequiredModules   = @('ColoredText')
    
    FunctionsToExport = ''
    NestedModules = @(
        'Src\Entry\LoggerEntry.psm1'
        'Src\Entry\LoggerEntryTrimmed.psm1'
        'Src\Appender\ColoredConsoleAppender.psm1'
        'Src\Appender\FileAppender.psm1'
        'Src\Appender\AppVeyorAppender.psm1'
        'Src\ILogger.psm1'
    )


    PrivateData = @{
        PSData = @{
            Tags = @('logger', 'console', 'color', 'log', 'log4net', 'appender', 'logging')
            LicenseUri = 'https://github.com/n8tb1t/Logger/blob/master/LICENSE'
            ProjectUri = 'https://github.com/n8tb1t/Logger'
            IconUri = 'https://raw.githubusercontent.com/n8tb1t/Logger/master/Docs/Logo/icon.png'
            ReleaseNotes = '
Check out the project site for more information:
https://github.com/n8tb1t/Logger'
        }
    }

}
