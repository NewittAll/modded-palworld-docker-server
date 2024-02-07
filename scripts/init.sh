#!/bin/bash
if [[ ! "${PUID}" -eq 0 ]] && [[ ! "${PGID}" -eq 0 ]]; then
    printf "\e[0;32m*****EXECUTING USERMOD*****\e[0m\n"
    usermod -o -u "${PUID}" steam
    groupmod -o -g "${PGID}" steam
else
    printf "\033[31mRunning as root is not supported, please fix your PUID and PGID!\n"
    exit 1
fi

# Declare directories
gamePath=/palworld

function installServer() {
	echo ">>> Doing a fresh PalWorld Server install <<<"
	if [[ -n $WEBHOOK_ENABLED ]] && [[ $WEBHOOK_ENABLED == "true" ]]; then
	    send_webhook_notification "Installing server" "Server is being installed" "$WEBHOOK_INFO_COLOR"
	fi
	${STEAM_HOME}/steamcmd/steamcmd.sh +@sSteamCmdForcePlatformType windows +force_install_dir /palworld +login anonymous +app_update 2394010 validate +quit

	wget -P "$gamePath"/Pal/Binaries/Win64 https://github.com/UE4SS-RE/RE-UE4SS/releases/download/v2.5.2/UE4SS_Xinput_v2.5.2.zip \
	    && unzip -q "$gamePath"/Pal/Binaries/Win64/UE4SS_Xinput_v2.5.2.zip -d "$gamePath"/Pal/Binaries/Win64 \
	    && rm "$gamePath"/Pal/Binaries/Win64/UE4SS_Xinput_v2.5.2.zip \
	    && rm "$gamePath"/Pal/Binaries/Win64/Readme.md \
	    && rm "$gamePath"/Pal/Binaries/Win64/Changelog.md

	# Turn off GuiConsole
	sed -i 's/GuiConsoleEnabled = 1/GuiConsoleEnabled = 0/' "$gamePath"/Pal/Binaries/Win64/UE4SS-settings.ini
	sed -i 's/GuiConsoleVisible = 1/GuiConsoleVisible = 0/' "$gamePath"/Pal/Binaries/Win64/UE4SS-settings.ini

	mv /palworld/Downloads/UE4SS_Signatures "$gamePath"/Pal/Binaries/Win64/Mods
}
# Function to start supercronic and load crons from cronlist
function setupCron() {
	echo "" > crontab
	f [[ -n "$BACKUP_ENABLED" ]] && [[ $BACKUP_ENABLED == "true" ]]; then
        echo "$BACKUP_CRON_EXPRESSION /backup.sh" >> crontab
    fi
    /usr/local/bin/supercronic crontab &
}

./palworld/Scripts/start.sh