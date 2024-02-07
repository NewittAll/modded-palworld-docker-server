#!/bin/bash
whoami
ls -lta /
ls -lta /palworld/Downloads

# Declare directories
gamePath=/palworld

function installServer() {
	echo ">>> Doing a fresh PalWorld Server install <<<"
	if [[ -n $WEBHOOK_ENABLED ]] && [[ $WEBHOOK_ENABLED == "true" ]]; then
	    send_webhook_notification "Installing server" "Server is being installed" "$WEBHOOK_INFO_COLOR"
	fi
	${STEAMCMD} +@sSteamCmdForcePlatformType windows +force_install_dir /palworld +login anonymous +app_update 2394010 validate +quit

	wget -P "$gamePath"/Pal/Binaries/Win64 https://github.com/UE4SS-RE/RE-UE4SS/releases/download/v2.5.2/UE4SS_Xinput_v2.5.2.zip \
	    && unzip -q "$gamePath"/Pal/Binaries/Win64/UE4SS_Xinput_v2.5.2.zip -d "$gamePath"/Pal/Binaries/Win64 \
	    && rm "$gamePath"/Pal/Binaries/Win64/UE4SS_Xinput_v2.5.2.zip \
	    && rm "$gamePath"/Pal/Binaries/Win64/Readme.md \
	    && rm "$gamePath"/Pal/Binaries/Win64/Changelog.md

	# Turn off GuiConsole
	sed -i 's/GuiConsoleEnabled = 1/GuiConsoleEnabled = 0/' "$gamePath"/Pal/Binaries/Win64/UE4SS-settings.ini
	sed -i 's/GuiConsoleVisible = 1/GuiConsoleVisible = 0/' "$gamePath"/Pal/Binaries/Win64/UE4SS-settings.ini

	mv /palworld/Downloads/UE4SS_Signatures "$gamePath"/Pal/Binaries/Win64
}
# Function to start supercronic and load crons from cronlist
function setupCron() {
	echo ">>> Creating crontab <<<"
	echo "" > crontab
	if [[ -n "$BACKUP_ENABLED" ]] && [[ $BACKUP_ENABLED == "true" ]]; then
        echo "$BACKUP_CRON_EXPRESSION /backup.sh" >> crontab
    fi
    /usr/local/bin/supercronic crontab &
}

if [ ! -f "$gamePath/Pal/Binaries/Win64/PalServer-Win64-Test.exe" ]; then
	installServer
fi

setupCron

sh /palworld/Scripts/start.sh