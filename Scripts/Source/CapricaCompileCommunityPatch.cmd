@echo off

rem skk.50@outlook.com November 2023
rem CapricaCompileCommunityPatch.cmd

rem Extract Caprica.exe alongside this file 
rem Ensure the import (where the vanilla source files are) and output (the end result destination) are correct. 

set IMPORT=C:\Games\Steam\steamapps\common\Starfield\Data\Scripts\Source\Base
set OUTPUT=C:\Games\Steam\steamapps\common\Starfield\Data\Scripts
set BASEPATH=%cd%

:START
 cls
 echo ****************************************************************
 echo Caprica Starfield DEBUG compile for Community Patch 
 echo.
 echo IMPORT:     "%IMPORT%"
 echo OUTPUT:     "%OUTPUT%"
 echo BASEPATH:     "%BASEPATH%"
 echo.
 
 echo ****************************************************************
 echo Checking for Caprica Installation
:CAPRICA-CHECK
 IF NOT EXIST "%BASEPATH%\Caprica.exe" ( 
	echo ****************************************************************
	echo == ERROR ==
	echo Caprica is not installed at "%BASEPATH%\Caprica.exe".
	echo Caprica 0.3.0 will be downloaded from GitHub.
	echo If Caprica has not been downloaded, you will need to fetch the latest version from https://github.com/Orvid/Caprica/releases and install to the path above.
	pause.
	exit
 ) ELSE ( echo Caprica loaded! )
 echo.
 echo ****************************************************************
 echo Checking for Vanilla script sources
:VANILLA-SOURCES-CHECK
IF NOT EXIST "%IMPORT%\Game.psc" (
	echo ****************************************************************
	echo == ERROR ==
	echo The IMPORT folder "%IMPORT%" doesn't appear to contain the decompiled scripts.
	echo Use BAE - https://www.nexusmods.com/starfield/mods/165 - to extract the scripts from Starfield - Misc.ba2.
	echo Then, use Champollion - https://www.nexusmods.com/starfield/mods/4528 - to decompile the PEX files into their PSC source files.
	echo Finally, edit this script to ensure the IMPORT and OUTPUT point to the correct location.
	echo ****************************************************************
	echo.
	pause
	exit
 ) ELSE ( echo Vanilla scripts located! )


:ROOT
 echo ****************************************************************
 echo Compiling all scripts in "%BASEPATH%" and subdirectories
 caprica.exe --game starfield --import "%IMPORT%" --output "%OUTPUT%" %BASEPATH% -R -q

:END
 echo ****************************************************************
 echo Compilation Completed!
 echo.
 pause
