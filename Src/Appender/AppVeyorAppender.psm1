using module ..\ILogger.psm1

class AppVeyorAppender: iloggerappender
{
    [void]log([ILoggerEntry]$entry)
    {
        $entry.severity = switch ($entry.severity)
        {
            ([LoggingEventType]::Debug) { [LoggingEventType]::Information }
            ([LoggingEventType]::Fatal) { [LoggingEventType]::Error }
            default { $entry.severity }
        }

        Add-AppveyorMessage $entry.message -Category ([String]$entry.severity)
    }
}