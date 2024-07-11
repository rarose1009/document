@REM ----------------------------------------------------------------------------
@REM
@REM Copyright(c) 2020 Value CMD Co., Ltd.
@REM
@REM ----------------------------------------------------------------------------

@echo off
setlocal

set PUSH_URL=smartver-test.seoulgas.co.kr
set PUSH_PORT=1883
set PUSH_USER=010-3479-2951
set PUSH_MSG=hi, there! ho ho......
set SCH_CNT=8

set PUSH_HOME="C:/Program Files/mosquitto"
cd %PUSH_HOME%
mosquitto_pub.exe -h %PUSH_URL% -p %PUSH_PORT% -t %PUSH_USER% -m "{\"push_msg\":\"%PUSH_MSG%\", \"sch_cnt\":\"%SCH_CNT%\"}"

endlocal