#!/bin/bash
source /init.sh
source /palworld/Scripts/config.sh

# Declare directories
serverExe="$serverDir/Pal/Binaries/Win64/PalServer-Win64-Test.exe"


function startServer() {
    cd $serverDir

    setupEngine
    setupServerSettings

    startSettings=""
    if [[ -n $COMMUNITY_SERVER ]] && [[ $COMMUNITY_SERVER == "true" ]]; then
        echo "Setting Community-Mode to enabled"
        startSettings="$startSettings EpicApp=PalServer"
    fi
    if [[ -n $MULTITHREAD_ENABLED ]] && [[ $MULTITHREAD_ENABLED == "true" ]]; then
        echo "Setting Multi-Core-Enchancements to enabled"
        startSettings="$startSettings -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS"
    fi
    if [[ -n $WEBHOOK_ENABLED ]] && [[ $WEBHOOK_ENABLED == "true" ]]; then
        send_start_notification
    fi
    echo -e "\033[32;1m>>> Starting Palworld Server <<<\033[0m"
    /home/steam/.steam/steam/compatibilitytools.d/GE-Proton8-28/proton run $serverExe EpicApp=PalServer
}

function bootManager() {
    checkSettings
    setupCron
    if [ ! -f ${serverExe} ]; then
        installServer
    fi
    if [ $ALWAYS_UPDATE_ON_START == "true" ]; then
        updateServer
    fi

    startServer
}

bootManager