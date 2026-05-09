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

:: Start mpv
START "" "%~dp0..\mpv.exe" --script-opts=osc-visibility=never --ontop=yes --panscan=1.0 --ontop-level=system --no-terminal --fullscreen=yes --force-window=yes "%RandomVideo%"

:: Start Steam
START "" "W:\Program Files (x86)\Steam\steam.exe" -gamepadui -nochatui -nofriendsui -skipinitialbootstrap -noreactlogin


:: Background timer for minimum black screen duration
start "" /b cmd /c "
timeout /t 10 >nul
taskkill /f /im BlackCover.exe >nul 2>&1
"

:: Wait until mpv closes
:waitformpv
tasklist /FI "IMAGENAME eq mpv.exe" 2>NUL | find /I "mpv.exe" >nul
if not errorlevel 1 (
    timeout /t 1 >nul
    goto waitformpv
)

:: Wait 1 second after video closes, only use if needed
::timeout /t 1 >nul

:: Mouse click
"%~dp0nircmd.exe" setcursor 1920 1080
"%~dp0nircmd.exe" sendmouse left click

START "" "%~dp0AutoHideMouseCursor_x64.exe"

EXIT
