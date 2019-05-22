# <img src="/Docs/Logo/icon.png" alt="Logo" width="48" align="left"/> Logger

[![Powershellgallery Badge][psgallery-badge]][psgallery-status]

## Install

```powershell
PS> Install-Module Logger
```

```powershell
using module Logger

$logger = New-Object Logger
$logger.appenders.add([Logger.ColoredConsoleAppender]@{ })
$logger.appenders.add([Logger.FileAppender]@{ logPath = ('{0}\Logs\miner.log' -f $PSScriptRoot) })

$logger.error('ColoredConsole Appender')
```

```powershell
using module Logger

class CustomEntry: Logger.ILoggerEntry
{
    static [Logger.ILoggerEntry]yield([String]$text)
    {
        return [Logger.ILoggerEntry]@{
            severity = [Logger.LoggingEventType]::((Get-PSCallStack)[$true].functionName)
            message = '{1}xxx {0} xxx{1}' -f $text, [Environment]::NewLine
        }
    }
}

$logger = New-Object Logger
$logger.logEntryType = [CustomEntry]
$logger.appenders.add([Logger.ColoredConsoleAppender]@{ })

$logger.error('Custom Entry')
```

```powershell
using module Logger

class CustomAppender: Logger.ILoggerAppender
{
    [void]log([Logger.ILoggerEntry]$entry)
    {
        Write-Host $entry.message -ForegroundColor Blue
    }
}

$logger = New-Object Logger
$logger.appenders.add([CustomAppender]@{ })

$logger.error('Custom Appender')
```

[psgallery-badge]: https://img.shields.io/badge/PowerShell_Gallery-1.0.7-green.svg
[psgallery-status]: https://www.powershellgallery.com/packages/Logger/1.0.7
