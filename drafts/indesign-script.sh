#!/usr/bin/env bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="Indesign2018"
WINEVERSION="2.20-staging"
TITLE="Adobe Indesign"
EDITOR="Adobe Systems Inc."
GAME_URL="http://www.adobe.com"
AUTHOR="Corbin Davenport"

#Initialization
POL_SetupWindow_Init
POL_SetupWindow_SetID 3251

POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Create prefix and temporary download folder
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
POL_System_TmpCreate "Indesign"
Set_OS "win7"

# Install dependencies
POL_SetupWindow_wait "Please wait while msxml3 is installed..." "$TITLE"
POL_Call POL_Install_msxml3
cd "$POL_System_TmpDir"
# Use winetricks, since the POL_corefonts version does not work with the installer
POL_Download_Resource  "https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks"
POL_SetupWindow_wait "Please wait while winetricks is installed... (this might take a few minutes)" "$TITLE"
chmod +x winetricks 
./winetricks atmlib corefonts fontsmooth=rgb gdiplus vcrun2008 vcrun2010 vcrun2012 vcrun2013 vcrun2015 atmlib msxml3 msxml6 gdiplus
Set_OS "win7"

# Get the installer
cd "$POL_System_TmpDir"
POL_Download "/home/carlos/Downloads/InDesign_13_LS20_Win32.zip"
POL_SetupWindow_wait "Please wait while the installer is extracted..." "$TITLE"
unzip *.zip
INSTALLER="$POL_System_TmpDir/$POL_System_TmpDir/Set-up.exe"
  
# All done
POL_SetupWindow_message "Done"
POL_SetupWindow_Close
exit 0