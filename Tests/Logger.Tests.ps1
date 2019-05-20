Using module ..\Logger.psm1
Using module ..\Src\Entry\LoggerEntryTrimmed.psm1
Using module ..\Src\Appender\ColoredConsoleAppender.psm1
Using module ..\Src\Appender\AppVeyorAppender.psm1

Using namespace Logger

Set-Variable consoleOutput -Scope Global

Describe 'Logger Tests' {
    
    Mock -ModuleName ColoredConsoleAppender -CommandName Write-Host -MockWith {
        param ([String]$object)
        $global:consoleOutput = $object
    }
    
    [ILogger]$logger = New-Object Logger
    
    It 'Should be of type Logger' {
        $logger | Should BeOfType ([ILogger])
    }
    
    Context 'ColoredConsoleAppender' {
        
        $logger.appenders.add([ColoredConsoleAppender]@{ })
        
        [Enum]::GetValues([LoggingEventType]) | ForEach-Object {
            [String]$LoggingType = $_
            It "Log $LoggingType" {
                
                $logger.$LoggingType($LoggingType + [Environment]::NewLine)
                
                $consoleOutput | Should Be ($LoggingType + ([Environment]::NewLine))
            }
        }
        
        $logger.appenders.clear()
    }
    
    Context 'ColoredConsoleAppender LoggerEntryTrimmed' {
        
        $logger.appenders.add([ColoredConsoleAppender]@{ })
        
        $logger.logEntryType = [LoggerEntryTrimmed]
        
        [Enum]::GetValues([LoggingEventType]) | ForEach-Object {
            [String]$LoggingType = $_
            It "Log $LoggingType" {
                
                $logger.$LoggingType($LoggingType + [Environment]::NewLine)
                
                $consoleOutput | Should Be $LoggingType
            }
        }
        
        $logger.appenders.clear()
    }
    
    Context 'AppVeyorAppender' {
        
        Function Add-AppveyorMessage { }
        Mock -ModuleName AppVeyorAppender Add-AppveyorMessage -MockWith { }
        
        $logger.appenders.add([AppVeyorAppender]@{ })
        
        [Enum]::GetValues([LoggingEventType]) | ForEach-Object {
            [String]$LoggingType = $_
            It "Log $LoggingType" {
                
                $logger.$LoggingType($LoggingType)
                
                Assert-MockCalled -ModuleName AppVeyorAppender Add-AppveyorMessage -Scope Context
            }
        }
        
        $logger.appenders.clear()
    }
}