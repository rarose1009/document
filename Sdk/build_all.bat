@REM ----------------------------------------------------------------------------
@REM
@REM Copyright(c) 2020 Value CMD Co., Ltd.
@REM
@REM ----------------------------------------------------------------------------

@echo off
rem ---------------------------------------------
rem 전체 빌드를 한다.
rem ---------------------------------------------
for %%f in (*.mc) do (
   echo Compiling %%~nf.mc...
   call ./sdk/build.bat %%~nf
)
