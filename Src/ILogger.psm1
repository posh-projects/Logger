using namespace System.Collections.Generic

enum LoggingEventType
{
    Debug
    Information
    Warning
    Error
    Fatal
}

class ILogger
{
    [List[ILoggerAppender]]$appenders
    [Type]$logEntryType

    [void]debug([String]$message) { }
    [void]information([String]$message) { }
    [void]warning([String]$message) { }
    [void]error([String]$message) { }
    [void]fatal([String]$message) { }
}

class ILoggerEntry
{
    [ValidatePattern('\w')]
    [LoggingEventType]$severity

    [ValidateNotNullOrEmpty()]
    [String]$message
    [Exception]$exception = $null

    static [ILoggerEntry]yield([String]$text) { throw }
}

class ILoggerAppender
{
    [void]log([ILoggerEntry]$entry) { }
}