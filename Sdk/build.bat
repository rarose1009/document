@REM ----------------------------------------------------------------------------
@REM
@REM Copyright(c) 2020 Value CMD Co., Ltd.
@REM
@REM ----------------------------------------------------------------------------

@echo off

rem ---------------------------------------------
rem build *.mc
rem ---------------------------------------------

setlocal

rem ------------------------------
rem set sdk path (change if need)
rem ------------------------------
rem set SDK_BUILD=Smart/build/Smart_scgas
rem set SDK_HOME=C:/Smart/build/Smart_scgas
set SDK_HOME=%~dp0
rem ------------------------------

set CURRENT_DIR=%cd%
set /a file_size = 0

rem echo SDK_BUILD=%SDK_BUILD%
rem echo SDK_HOME=%SDK_HOME%
rem echo %CURRENT_DIR%

if NOT EXIST "./Package" (
   mkdir Package
)

if NOT EXIST "./Error" (
   mkdir Error
)

rem ------------------------------
rem 1. preprocess => merged c source
rem ------------------------------
%SDK_HOME%/bin/cpp %1.mc -I%SDK_HOME%/include > ./Debug/%1.c

if EXIST "./Error/%1.err" (
   cd Error
   del /q %1.err
   cd ..
)

rem ------------------------------
rem 2. compile => make asm source
rem ------------------------------
%SDK_HOME%/bin/rcc -S -g ./Debug/%1.c -DDebug -oDebug -errout=./Error/%1.err

rem err result file size check
if EXIST "./Error/%1.err" (
    FOR %%? IN ("./Error/%1.err") DO (
       set /a file_size = %%~z?
       goto :compile_end
    )   
 )

:compile_end

for /f "delims=" %%x in (./Error/%1.err) do set filecontent=%%x
rem set /p filecontent=< ./Error/%1.err

echo compiler result : %filecontent%

rem echo file size is %file_size%
if %file_size% gtr 17 goto err_exit

echo build '%1.mc' success, no error(s).

:build_ok

rem ------------------------------
rem 3. assemble => make crd
rem ------------------------------
move ./%1.asm ./Debug/%1.asm
%SDK_HOME%/bin/vmasm.exe ./Debug/%1.asm

rem ------------------------------
rem delete temp file if no problem
rem ------------------------------
cd Debug
copy "%1.crd" "../Package"
del /q %1.c
cd ..

rem ------------------------------
rem delete err file if no problem also
rem ------------------------------
if %file_size% gtr 17 goto build_exit

cd Error
del /q %1.err
cd ..

goto build_exit

:err_exit

if "%filecontent%" == "Compile Success" (

    echo "***************<<WARNING>>******************"
    echo *
    echo * build '%1.mc', but warning occurs.
    echo * please check './Error/%1.err'
    echo *
    echo "********************************************"
    goto build_ok
 )

echo "***************<<ERROR>>********************"
echo *
echo * build '%1.mc', but error occurs.
echo * please check './Error/%1.err'
echo *
echo "********************************************"

:build_exit

endlocal