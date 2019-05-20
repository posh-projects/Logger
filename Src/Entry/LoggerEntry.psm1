using module ..\ILogger.psm1

class LoggerEntry: ILoggerEntry
{
    static [ILoggerEntry]yield([String]$text)
    {
        return [ILoggerEntry]@{
            severity = [LoggingEventType]::((Get-PSCallStack)[$true].functionName)
            message = $text
        }
    }
}