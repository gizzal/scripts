#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="Forge"
WINEVERSION="2.20-staging"
TITLE="Firely Forge Tool"
EDITOR="Firely."
FORGE_URL="https://fire.ly/forge/"
AUTHOR="Los Amigos"

#Initialization
POL_SetupWindow_Init
POL_SetupWindow_SetID 3251

POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$FORGE_URL" "$AUTHOR" "$PREFIX"

# Create prefix and temporary download folder
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "win7"

# Use winetricks, this will make the proper changes for all netframework configuration needed
POL_Download_Resource  "https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks"
POL_SetupWindow_wait "Please wait while winetricks is installed... (this might take a few minutes)" "$TITLE"
chmod +x winetricks 
./winetricks -q dotnet46

# Get the installer
INSTALLER_PATH="${HOME}/forge"
mkdir "$INSTALLER_PATH"
cd "$INSTALLER_PATH"

POL_SetupWindow_menu "Which Fhir version should support?" "Fhir versions" "DSTU2|STU3" "|"
if [ "$APP_ANSWER" == "DSTU2" ]
 then
  DOWNLOAD_URL="http://downloads.simplifier.net/forge/dstu2/setup.exe"
elif [ "$APP_ANSWER" == "STU3" ]
 then
  DOWNLOAD_URL="http://downloads.simplifier.net/forge/stu3/setup.exe"
fi

#Download installer
POL_SetupWindow_wait "Downloading installer for Forge $APP_ANSWER..." "$TITLE"
POL_Download "$DOWNLOAD_URL"
INSTALLER="${HOME}/forge/setup.exe"

# Run the installer
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$INSTALLER"
cp "${HOME}/forge/setup.exe" "${HOME}/.PlayOnLinux/wineprefix/Forge/drive_c/forge_launcher.exe"
POL_SetupWindow_message "Please follow the instructions of Forge installer and then press Next"
POL_Shortcut "forge_launcher.exe" "Forge $APP_ANSWER"
              
# All done
POL_SetupWindow_message "You can use Forge $APP_ANSWER now, thanks for using the tool, $AUTHOR"
 
POL_SetupWindow_Close
exit 0