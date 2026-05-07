Based on https://github.com/quangmach/GameLauncherShell, I wanted to make the process as seamless as possible to where you never see Windows stuff at all during startup.
Only Test on WIndows 11!

Installation
1. Extract the folder anywhere.
2. You will need the Uninstaller.exe added to steam before you do anything just to make sure you dont have to do an annoying process to get your explorer back as the ui doesnt return when using actively this unfortunately.
3. Enable Login without Password https://www.minitool.com/data-recovery/windows-11-auto-login.html
4. Right Click on "\GameLauncherShell\Steam\Launcher.bat" and edit
5. Change

:: Start Steam underneath

START "" "C:\Program Files (x86)\Steam\steam.exe" -gamepadui -nochatui -nofriendsui -skipinitialbootstrap -noreactlogin

To whereever your steam is. 

6. Next, I'd remove the steam big picture startup video so go to your steam folder and then config\uioverrides\movies (create these folders if you dont have them) and paste bigpictures_startup.webm
7. You may have to open Steam big picure and select this as your startup video or it might do it automatically I dont remember lmao.
8. I had to make a Black Screen program to hide the ugly Windows grey underneath its ui, and I have two options. One has a short beep as some home recievers need a sound input for their sound mode to change, where when the startup video occurs it means there will be sound from the start of it, and the other is silent. To switch them just rename BlackCoverSilent.exe to BlackCover.exe or change it in the Launcher.bat
10. That's it!, Use Installer.bat to turn the mode 'on' and use Uninstaller.exe in Steam to turn it off use the Steam/Videos folder to place any videos you want (I used some steam deck bootup ones from https://steamdeckrepo.com/) and theyll shuffle at random. Enjoy!

Important Notes: 

In Launcher.bat, I've bolded where a timer ticks down where for shorter startup videos, the black cover is still there before steam loads. For my system 11 seconds was perfect but you may need to change it to work better with yours. Experiment and see how you go.

Ensure AutoHideMouseCursor is set to Always Start Hidden and Start with Windows is enabled so it doesnt pop up.

Nircmd is used to simulate button presses like Enter as soon as the system starts which seems to compoletely avoid the sign in screen (weird I know)

On occassion, Steam can load over the top of the video so sorry about that idk why or how to fix it rlly but its rare.


    
