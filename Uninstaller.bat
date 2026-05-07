@echo off

::Script to force run as Admin
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

:: Reset Shell
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Shell /t REG_SZ /d "explorer.exe" /f && echo "Reset Shell"

:: Reset Userinit
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Userinit /t REG_SZ /d "C:\WINDOWS\system32\userinit.exe," /f && echo "Reset Userinit"

:: Remove Previous Task Scheduler
schtasks /query /TN "Game Launcher Shell" >NUL 2>&1 && schtasks /delete /tn "Game Launcher Shell" /f

echo "Uninstall Successfully"

:: Enable auto-login
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" ^
/v AutoAdminLogon /t REG_SZ /d 1 /f

REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" ^
/v DefaultUserName /t REG_SZ /d "%USERNAME%" /f

REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" ^
/v DefaultPassword /t REG_SZ /d "" /f

:: Disable lock screen
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" ^
/v NoLockScreen /t REG_DWORD /d 1 /f

:: Disable requirement for Ctrl+Alt+Del
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" ^
/v DisableCAD /t REG_DWORD /d 1 /f

timeout /t 1 >nul

shutdown /l