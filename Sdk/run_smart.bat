@REM ----------------------------------------------------------------------------
@REM
@REM Copyright(c) 2020 Value CMD Co., Ltd.
@REM
@REM ----------------------------------------------------------------------------

@echo off

setlocal

set SDK_HOME=%~dp0

if NOT EXIST "%SDK_HOME%/../Debug/Smart.exe" (
	copy "%SDK_HOME%/Smart.exe" "%SDK_HOME%/../Debug"
)

if NOT EXIST "%SDK_HOME%/../Debug/libcurl.dll" (
	copy "%SDK_HOME%/libcurl.dll" "%SDK_HOME%/../Debug"
)

if NOT EXIST "%SDK_HOME%/../Debug/libeay32.dll" (
	copy "%SDK_HOME%/libeay32.dll" "%SDK_HOME%/../Debug"
)

if NOT EXIST "%SDK_HOME%/../Debug/ssleay32.dll" (
	copy "%SDK_HOME%/ssleay32.dll" "%SDK_HOME%/../Debug"
)

if NOT EXIST "%SDK_HOME%/../Debug/emul.ini" (
	copy "%SDK_HOME%/emul.ini" "%SDK_HOME%/../Debug"
)

cd %1/Debug
Smart.exe

endlocal