@echo off
rem Usage: sex.bat "Your error message"

rem read message from first argument or use default
set "MSG=%~1"
if "%MSG%"=="" set "MSG=Your computer has been hacked! Say goodbye to your files."

rem print to stderr
>&2 echo ERROR: %MSG%

rem try to show a MessageBox via PowerShell (silently ignore if it fails)
powershell -NoProfile -Command "Add-Type -AssemblyName PresentationFramework > $null 2>&1; [System.Windows.MessageBox]::Show(\"%MSG%\",\"Error\",\"OK\",\"Error\")" 2>nul || rem fallback: do nothing

rem exit with non-zero status to indicate an error
exit /b 1