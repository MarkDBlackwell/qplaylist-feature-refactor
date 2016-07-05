@echo off
rem Author: Mark D. Blackwell (google me)
rem October 9, 2013 - created
rem November 8, 2013 - Set variable for server drive
rem April 20, 2016 - Allow Git updating

rem Description:
rem  This Windows batch file:
rem    1. Obtains the input files for a certain program;
rem    2. Runs that program; and
rem    3. Runs an FTP command file to upload the program's output files.

rem This batch file, along with the associated program and its input
rem  and output files, should not reside on a WideOrbit server
rem  computer. The purpose of this recommendation is in order to
rem  minimize this software's drag on WideOrbit's resources.

rem ==============
rem %cd:~0,2% is the current drive:
set OriginalWorkingDrive=%cd:~0,2%

rem %cd% is the current drive and working directory, without trailing
rem  backslash:
set OriginalWorkingLocation=%cd%

rem %~dp0 is the drive and path to the directory containing this
rem   Windows batch script. It includes a trailing backslash:
set ScriptDirectoryLocation=%~dp0

rem %~d0 is the drive containing this Windows batch script:
set ScriptDrive=%~d0

rem To access WideOrbit's XML file, which describes the currently
rem  playing song, customize this network drive letter, if necessary:
set WideOrbitDrive=z:

rem --------------
rem WideOrbit file location, without trailing backslash:
set WideOrbitFileLocation=%WideOrbitDrive%

rem Configuration files location, with trailing backslash:
set ConfigFilesLocation=%ScriptDirectoryLocation%

rem --------------
rem FTP command file location, with trailing backslash:
set FTPLocation=%ConfigFilesLocation%

rem Mustache files location:
set MustacheLocation=%WideOrbitDrive%\Qplaylist

rem Volatile files location:
set VolatilesLocation=%ConfigFilesLocation%\..\var

rem Program files location:
set ProgramLocation=%VolatilesLocation%

rem --------------
rem Process the song stream:

rem Navigate in order to copy files:
%ScriptDrive%
cd %VolatilesLocation%\

rem Copy input files:
start /wait %COMSPEC% /C copy /Y  %MustacheLocation%\NowPlaying.mustache   now_playing.mustache
start /wait %COMSPEC% /C copy /Y  %MustacheLocation%\LatestFive.mustache   latest_five.mustache
start /wait %COMSPEC% /C copy /Y  %MustacheLocation%\RecentSongs.mustache  recent_songs.mustache

rem Copy WideOrbit's file last:
start /wait %COMSPEC% /C copy /Y  %WideOrbitFileLocation%\NowPlaying.XML   now_playing.xml

rem Navigate in order to run the Ruby program:
%ScriptDrive%
cd %ProgramLocation%\

rem Run the Ruby program:
start /wait %COMSPEC% /C ruby quick_radio_playlist.rb

rem --------------
rem FTP the output to a webserver computer:
start /wait %COMSPEC% /C ftp -s:%FTPLocation%quick_radio_playlist.ftp

rem --------------
rem In the parent console, restore the original working location:
%OriginalWorkingDrive%
cd %OriginalWorkingLocation%\

rem --------------
rem Close the window (and return):
exit
