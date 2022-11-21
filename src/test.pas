program test;

uses uDelphiLogger;

var
	logger: TLogger;
begin
	logger := TLogger.Create('LogTest.log');
	logger.FLoggerName := 'test';
	logger.FSilent := True;
	logger.Log(LOG_LVL_DBG, 'Debug Message');
	logger.Log(LOG_LVL_INF, 'Information Message');
	logger.Log(LOG_LVL_WARN, 'Warning Message');
	logger.Log(LOG_LVL_ERR, 'Error Message');
	logger.Free;
end.
