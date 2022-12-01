{$ifndef dcc}
  {$mode delphi}
{$endif}
unit uLogger;

{        uLogger - Simple Logger for Object FPC.          }
{                                                         }
{ Usage:                                                  }
{    // NO SAVING                                         }
{    myLogger := TLogger.Create;                          }
{    myLogger.Log(LOG_LEVEL_CONSTANT, 'Log Message');     }
{                                                         }
{    // WITH SAVING TO FILE                               }
{    myLogger := TLogger.Create('LogFile.log');           }
{    myLogger.Log(LOG_LEVEL_CONSTANT, 'Log Message');     }
{    myLogger.Free; // This is required to save the file  }
{                                                         }
{                                                         }
{ Author: Felix Eckert                                    }
{ LICENSED UNDER THE ISC LICENSE, SEE BELOW.              }


(* Copyright (c) 2022, Felix Eckert                                         *)
(*                                                                          *)
(* Permission to use, copy, modify, and/or distribute this software for any *)
(* purpose with or without fee is hereby granted, provided that the above   *)
(* copyright notice and this permission notice appear in all copies.        *)
(*                                                                          *)
(* THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES *)
(* WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF         *)
(* MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR  *)
(* ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES   *)
(* WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN    *)
(* ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF  *)
(* OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.           *)

interface
  uses SysUtils, DateUtils;

  type
    TLogger = class
      private
        FLogFile: TextFile;
        FSaveToFile: Boolean;
      public
        FLoggerFormatSettings: TFormatSettings;
        FLoggerName: String;
        FSilent: Boolean;
        constructor Create; overload;
        constructor Create(const ALogFile: String); overload;
        destructor Free;
        procedure LogF(const ALogLevel: Integer; const AMsg: String; const AArgs: array of const);
        procedure Log(const ALogLevel: Integer; const AMsg: String);
    end;

  const
    {   LOG LEVELS   }
    { Debug Message }
    LOG_LVL_DBG = 0;

    { Noification Message }
    LOG_LVL_NOTICE = 1;

    { Information Message }
    LOG_LVL_INF = 2;

    { Warning Message } 
    LOG_LVL_WARN = 3;

    { Error Message }
    LOG_LVL_ERR = 4;

    { Fatal Error Message }
    LOG_LVL_FATAL = 5;

    LOG_LVL_NAMES : array of String = ['DEBUG', 'NOTICE', 'INFO', 'WARN', 'ERROR', 'FATAL'];
implementation
  constructor TLogger.Create;
  begin
    {$ifdef dcc}
      FLoggerFormatSettings := FormatSettings;
    {$else}
      FLoggerFormatSettings := DefaultFormatSettings;
    {$endif}

    FSaveToFile := False;
    FSilent := False;
    FLoggerName := '';
  end;

  constructor TLogger.Create(const ALogFile: String);
  begin
    Create;

    FSaveToFile := True;
    AssignFile(FLogFile, ALogFile);
    Rewrite(FLogFile);
  end;

  destructor TLogger.Free;
  begin
    Close(FLogFile);
  end;

  procedure TLogger.LogF(const ALogLevel: Integer; const AMsg: String; const AArgs: array of const);
  begin
    Log(ALogLevel, Format(AMsg, AArgs));
  end;

  procedure TLogger.Log(const ALogLevel: Integer; const AMsg: String);
  var
    msg: String;
  begin
    msg := DateTimeToStr(Now(), FLoggerFormatSettings)+' ';

    if (FLoggerName <> '') then msg := msg + FLoggerName + ' ';

    msg := msg + '[' + LOG_LVL_NAMES[ALogLevel] + '] ' + AMsg;
    if not FSilent then writeln(msg);
    if (FSaveToFile) then writeln(FLogFile, msg+AMsg);
  end;
end.
