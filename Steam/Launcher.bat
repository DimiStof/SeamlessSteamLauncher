@ECHO OFF
setlocal

START "" "%~dp0BlackCover.exe"

:: Send Enter presses early
powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -Command "$wshell = New-Object -ComObject WScript.Shell; Start-Sleep -Milliseconds 100; 1..4 | ForEach-Object { $wshell.SendKeys('{ENTER}'); Start-Sleep -Milliseconds 50 }"

:: Pick random video
for /f "usebackq delims=" %%i in (`powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ChildItem -LiteralPath '%~dp0Videos' -File | Where-Object { $_.Extension -match '^\.(mp4|mkv|avi|webm|mov|flv)$' } | Get-Random | Select-Object -ExpandProperty FullName"`) do (
    set "RandomVideo=%%i"
)

if not defined RandomVideo (
    echo No video found in "%~dp0Videos"
    timeout /t 3 >nul
    exit /b
)

:: Start mpv on top
START "" "%~dp0..\mpv.exe" --script-opts=osc-visibility=never --ontop=yes --panscan=1.0 --ontop-level=system --no-terminal --fullscreen=yes --force-window=yes "%RandomVideo%"


:: Give mpv time to fully appear
timeout /t 1 >nul

:: Start Steam underneath
START "" "C:\Program Files (x86)\Steam\steam.exe" -gamepadui -nochatui -nofriendsui -skipinitialbootstrap -noreactlogin

::CHANGE THE TIME IF LOADING TOO SLOWLY OR QUICKLY FOR YOUR SYSTEM
timeout /t 11 >nul
taskkill /f /im BlackCover.exe >nul 2>&1


::mouse click
timeout /t 1 >nul
"%~dp0nircmd.exe" setcursor 1920 1080
"%~dp0nircmd.exe" sendmouse left click

START "" "%~dp0AutoHideMouseCursor_x64.exe"
EXIT