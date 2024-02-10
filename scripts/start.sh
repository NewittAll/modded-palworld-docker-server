#!/bin/bash
source /init.sh
source /palworld/Scripts/config.sh

# Declare directories
serverExe="$serverDir/Pal/Binaries/Win64/PalServer-Win64-Test.exe"

function startServer() {
    setupServerSettings
    installMods

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
    echo ">>> Palworld server stopping"
}

function stop_server() {
    echo -e "\x1b[31;1m>>> Stopping server \x1b[0m\n"
    if [[ -n $RCON_ENABLED ]] && [[ $RCON_ENABLED == "true" ]]; then
        save_and_shutdown_server
    fi
	kill -SIGTERM "$(pidof PalServer-Linux-Test)"
	tail --pid="$(pidof PalServer-Linux-Test)" -f 2>/dev/null
    if [[ -n $WEBHOOK_ENABLED ]] && [[ $WEBHOOK_ENABLED == "true" ]]; then
        send_stop_notification
    fi
    ew ">>> Server stopped gracefully.\n\n"
    exit 143;
}

function save_and_shutdown_server() {
    rcon 'broadcast Server-shutdown-was-requested-init-saving'
    rcon 'save'
    rcon 'broadcast Done-saving-server-shuts-down-now'
}

function bootManager() {
    checkSettings
    setupCron
    if [ ! -f ${serverExe} ]; then
        installServer
    fi
    startServer
}

bootManager