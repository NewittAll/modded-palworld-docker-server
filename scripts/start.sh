#!/bin/bash
source /init.sh
source /"$serverDir/Scripts/config.sh"

source /palworld/Scripts/config.sh

# Declare directories
serverExe="$serverDir/Pal/Binaries/Win64/PalServer-Win64-Test.exe"


function startServer() {

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
    $PROTON run $serverExe $startSettings
}

function bootManager() {
    checkSettings
    setupCron
    if [ ! -f ${serverExe} ]; then
        installServer
    fi

    ls -lta /palworld/Pal

    startServer
}

bootManager