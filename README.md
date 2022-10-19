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
Information Message: LOG_LVL_INF
Warning Message: LOG_LVL_WARN
Error Message: LOG_LVL_ERR
```
