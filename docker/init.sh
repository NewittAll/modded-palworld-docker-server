#!/bin/bash
if [[ ! "${PUID}" -eq 0 ]] && [[ ! "${PGID}" -eq 0 ]]; then
    printf "\e[0;32m*****EXECUTING USERMOD*****\e[0m\n"
    usermod -o -u "${PUID}" steam
    groupmod -o -g "${PGID}" steam
else
    printf "\033[31mRunning as root is not supported, please fix your PUID and PGID!\n"
    exit 1
fi


echo ">>> Doing a fresh PalWorld Server install <<<"
if [[ -n $WEBHOOK_ENABLED ]] && [[ $WEBHOOK_ENABLED == "true" ]]; then
    send_webhook_notification "Installing server" "Server is being installed" "$WEBHOOK_INFO_COLOR"
fi
${STEAM_HOME}/steamcmd/steamcmd.sh +@sSteamCmdForcePlatformType windows +force_install_dir /palworld +login anonymous +app_update 2394010 validate +quit


./palworld/Scripts/start.sh