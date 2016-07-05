@echo off
rem Author: Mark D. Blackwell (google me)
rem May 16, 2016 - created

rem Description:
rem  This Windows batch file:
rem    1. Provides an additional layer of protection from hangs in the
rem       QPlaylist task.

rem ==============
rem %cd:~0,2% is the current drive:
set OriginalWorkingDrive=%cd:~0,2%

rem %cd% is the current drive and working directory, without trailing
rem  backslash:
set OriginalWorkingLocation=%cd%

rem %~d0 is the drive containing this Windows batch script:
set ScriptDrive=%~d0

rem %~p0 is the path to the directory containing this Windows batch
rem script. It includes a trailing backslash:
set ScriptDirectoryPath=%~p0

rem --------------
rem Navigate to the directory containing the QPlaylist batch file:
%ScriptDrive%
cd %ScriptDirectoryPath%

rem To make Windows Task Scheduler think the task is completed,
rem don't say "/wait" here:
start %COMSPEC% /c playlist.bat

rem --------------
rem In the parent console, restore the original working drive and directory:
%OriginalWorkingDrive%
cd %OriginalWorkingLocation%\
