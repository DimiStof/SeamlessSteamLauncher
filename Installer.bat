@echo off

:: Script to force run as Admin
set "params=%*"
cd /d "%~dp0" && (
    if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs"
) && fsutil dirty query %systemdrive% 1>nul 2>nul || (
    echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && ""%~s0"" %params%", "", "runas", 0 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B
)

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" ^
/v Shell /t REG_SZ ^
/d "wscript.exe \"%~dp0Steam\LauncherStartup.vbs\"" /f

:: Success popup for 1 second
echo Set WshShell = CreateObject("WScript.Shell") > "%temp%\success.vbs"
echo WshShell.Popup "Operation Successful", 1, "Done", 64 >> "%temp%\success.vbs"
wscript.exe "%temp%\success.vbs"

del "%temp%\success.vbs"

exit
