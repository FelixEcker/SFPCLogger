# SFPCLogger
A simple OBJFPC Logger

## Usage
Simply add the `uLogger.pas` Unit from the `src` directory to your project's source files. Below are two examples of how
to use this Logger.

### Without saving to file
```pascal
program logtest;

uses uLogger;

var
  logger: TLogger;
begin
  logger := TLogger.Create;
  logger.Log(<LOG_LEVEL_CONSTANT>, 'Log Message');
  logger.LogF(<LOG_LEVEL_COSTANT>, '%s Log Message', ['Formatted']);
end.
```

### With saving to file

```pascal
program logtest;

uses uLogger;

var
  logger: TLogger;
begin
  logger := TLogger.Create('LogFile.log');
  logger.Log(<LOG_LEVEL_CONSTANT>, 'Log Message');
  logger.LogF(<LOG_LEVEL_COSTANT>, '%s Log Message', ['Formatted']);
  logger.Free; // The log is written to file when free is called
end.
```

## Log Level Constants
```
Debug Message: LOG_LVL_DBG
Notification: LOG_LVL_NOTICE
Information Message: LOG_LVL_INF
Warning Message: LOG_LVL_WARN
Error Message: LOG_LVL_ERR
Fatality Message: LOGL_LVL_FATAL
```

## Logger Settings
### Date Time Format
On creation, the default Format-Settings are copied to be used by the logger. The Format Settings of the Logger are stored in the `FLoggerFormatSettings` variable an can be modified.

### "Silent" mode
Silent mode can be toggled by modifying the `FSilent` field. If the logger is in silent mode, it will only write to its Log file (if set up).
