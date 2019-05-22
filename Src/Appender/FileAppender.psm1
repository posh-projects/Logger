using module ..\ILogger.psm1

class FileAppender: ILoggerAppender
{

    [String]$logPath

    [void]log([ILoggerEntry]$entry)
    {
        $message = ('{0}:{1}:{2}' -f (Get-Date), $entry.severity.toString().toUpper(), $entry.message)
        Add-Content -Path $this.logPath -Value $message
    }
}
