#!/  -- avoid `gem build` warning of no shebang
@echo off
rem Author: Mark D. Blackwell (google me)
rem April 20, 2016 - created

rem Description:
rem  This Windows batch file:
rem    1. Sets things up, after someone installs QPlaylist via `git clone`.

rem ==============
rem References:
rem   http://stackoverflow.com/a/3022193/1136063
rem   http://steve-jansen.github.io/guides/windows-batch-scripting/

rem --------------
rem %cd% is the current drive and working directory, without trailing
rem  backslash:
set OriginalWorkingLocation=%cd%

rem %~dp0 is the drive and path to the directory containing this
rem   Windows batch script. It includes a trailing backslash:
set ScriptDirectoryLocation=%~dp0

rem %~nx0 is the basename with extension of this Windows batch script:
set ScriptName=%~nx0

set BundlerVersionRequired=1.12.1
set GemVersionRequired=2.0.15

rem The drive and path to the flag indicating whether setup has
rem   been done:
set SetupDoneFlagPath=%OriginalWorkingLocation%\.setup-done

rem --------------
rem echo "%ScriptName%: got here" && goto :eof

if exist %SetupDoneFlagPath% (
  echo "%ScriptName%: Setup has already been done."
) else (
  ruby   --version                                         || echo "%ScriptName%: You must first install Ruby."                            && echo "See README" && goto :eof
  gem    --version | find "%GemVersionRequired%"     > nul || echo "%ScriptName%: You must first install the correct version of Rubygems." && echo "See README" && goto :eof
  bundle --version | find "%BundlerVersionRequired%" > nul || echo "%ScriptName%: You must first install the correct version of Bundler."  && echo "See README" && goto :eof
  echo "%ScriptName%: got here"

bundle install --without development test

rem Remember setup has been done:
  if not exist %SetupDoneFlagPath% (
    type nul >> %SetupDoneFlagPath%
  ) || echo "%ScriptName%: Error: unable to create %SetupDoneFlagPath% && goto :eof
)
