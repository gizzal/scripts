#!/bin/bash
# Date : 2014-02-08 14:54
# Last revision : 2016-08-07 13:41
# Wine version used : 1.9.16
# Distribution used to test : Ubuntu 13.10 x64, Debian Jessie, Arch Linux
# Author : kweepeer2, m1kc (+ contributions by many others, thanks!)
# Depend : 
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Hearthstone"
PREFIX="hearthstone"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 1950
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Blizzard" "http://us.battle.net/hearthstone/en/" "kweepeer2" "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "1.9.18"
 
# Fix "Battle.net Helper.exe" crash on startup.
POL_Call POL_Install_corefonts
POL_Call POL_Install_RegisterFonts
POL_Wine_OverrideDLL "native,builtin" "msvcp140"
 
# Download & Install the game.
# Multiple Language support. See https://eu.battle.net/account/download/?show=hearthstone&style=hearthstone
POL_SetupWindow_menu "$(eval_gettext 'What language do you want to install?')" "Language Selection" \
    "English (US)|Español (AL)|Português (BR)|English (EU)|Deutsch|Español (EU)|Português (EU)|Français|Russian|Italiano|Polski|Korean|Chinese (Taiwan)|Chinese (China)" "|"
case "$APP_ANSWER" in
    "English (US)")
        EXE_FILE="Hearthstone-Setup-enUS.exe";;
    "Español (AL)")
        EXE_FILE="Hearthstone-Setup-esMX.exe";;
    "Português (BR)")
        EXE_FILE="Hearthstone-Setup-ptBR.exe";;
    "English (EU)")
        EXE_FILE="Hearthstone-Setup-enGB.exe";;
    "Deutsch")
        EXE_FILE="Hearthstone-Setup-deDE.exe";;
    "Español (EU)")
        EXE_FILE="Hearthstone-Setup-esES.exe";;
    "Português (EU)")
        EXE_FILE="Hearthstone-Setup-ptPT.exe";;
    "Français")
        EXE_FILE="Hearthstone-Setup-frFR.exe";;
    "Russian")
        EXE_FILE="Hearthstone-Setup-ruRU.exe";;
    "Italiano")
        EXE_FILE="Hearthstone-Setup-itIT.exe";;
    "Polski")
        EXE_FILE="Hearthstone-Setup-plPL.exe";;
    "Korean")
        EXE_FILE="Hearthstone-Setup-koKR.exe";;
    "Chinese (Taiwan)")
        EXE_FILE="Hearthstone-Setup-zhTW.exe";;
    "Chinese (China)")
        EXE_FILE="Hearthstone-Setup-zhCN.exe";;
    *)
        exit 1;;
esac
 
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"
POL_Download "http://dist.blizzard.com/downloads/hs-installers/a6029a1d625c79252defff3914fb6e67/retail.1/${EXE_FILE}"
POL_Wine "$POL_System_TmpDir/${EXE_FILE}"
POL_Wine_WaitExit "$TITLE" --allow-kill
POL_System_TmpDelete
 
POL_SetupWindow_VMS "64"
POL_Wine_reboot
 
POL_Shortcut "Battle.net Launcher.exe" "$TITLE" "$TITLE.png" ""
POL_SetupWindow_Close
 
exit 0