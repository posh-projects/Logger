using module ..\ILogger.psm1

class ColoredConsoleAppender: ILoggerAppender
{
    static $debugColor = [ConsoleColor]::DarkYellow
    static $informationColor = [ConsoleColor]::DarkGreen
    static $warningColor = [ConsoleColor]::Yellow
    static $errorColor = [ConsoleColor]::Red
    static $fatalColor = [ConsoleColor]::Red

    [void]log([ILoggerEntry]$entry)
    {
        $member = '{0}Color' -f $entry.severity
        $color = [ColoredConsoleAppender]::$member

        $message = '{0}:{1}' -f $entry.severity.toString().toUpper(), $entry.message

        Format-Color cr lpad rpad black on darkyellow (Get-Date) print `
                     $color on black $message print cr

    }
}
