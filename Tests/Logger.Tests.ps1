using module ..\Logger.psm1
using module ..\Src\Entry\LoggerEntryTrimmed.psm1
using module ..\Src\Appender\ColoredConsoleAppender.psm1
using module ..\Src\Appender\AppVeyorAppender.psm1
using module ..\Src\Appender\FileAppender.psm1

using namespace Logger

Set-Variable consoleOutput -Scope Global

Describe 'Logger Tests' {
    
    Mock -ModuleName FileAppender -CommandName Add-Content -MockWith {
        param ([String]$path)
        
        $global:consoleOutput = $path
    }
    
    Mock -ModuleName ColoredConsoleAppender -CommandName Format-Color -MockWith {
        param ([String]$object)
        
        $global:consoleOutput = $args
    }
    
    [ILogger]$logger = New-Object Logger
    
    It 'Should be of type Logger' {
        $logger | Should BeOfType ([ILogger])
    }
    
    
    Context 'FileAppender' {
        
        $logger.appenders.add([FileAppender]@{ logPath = ('{0}\Logs\miner.log' -f $PSScriptRoot) })
        
        [Enum]::GetValues([LoggingEventType]) | ForEach-Object {
            [String]$LoggingType = $_
            
            It "Log $LoggingType" {
                
                $logger.$LoggingType($LoggingType)

                [String]$consoleOutput | Should BeLike ('*miner.log*')
            }
        }
        
        $logger.appenders.clear()
    }
    
    Context 'ColoredConsoleAppender' {
        
        $logger.appenders.add([ColoredConsoleAppender]@{ })
        
        [Enum]::GetValues([LoggingEventType]) | ForEach-Object {
            [String]$LoggingType = $_
            
            It "Log $LoggingType" {
                
                $logger.$LoggingType($LoggingType)
                
                #$logger.$LoggingType($LoggingType + [Environment]::NewLine)
                
                [String]$consoleOutput | Should BeLike ('*' + $LoggingType + '*')
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
                
                $logger.$LoggingType($LoggingType)
                
                [String]$consoleOutput | Should BeLike ('*' + $LoggingType + '*')
            }
        }
        
        $logger.appenders.clear()
    }
    
    Context 'AppVeyorAppender' {
        
        function Add-AppveyorMessage { }
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