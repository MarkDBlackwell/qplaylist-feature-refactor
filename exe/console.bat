#!/  -- avoid `gem build` warning of no shebang
@echo off
rem Author: Mark D. Blackwell (google me)
rem May 18, 2016 - created

rem ==============
rem References:
rem   http://steve-jansen.github.io/guides/windows-batch-scripting/
rem   http://cplusplus.bordoon.com/cmd_exe_variables.html

rem --------------
rem %~n0 is the basename (without extension) of this Windows batch script:
set ScriptBasename=%~n0

rem %~dp0 is the drive and path to the directory containing this
rem   Windows batch script. It includes a trailing backslash:
set ScriptDirectoryLocation=%~dp0

rem --------------
ruby.exe "%ScriptDirectoryLocation%%ScriptBasename%" %*
