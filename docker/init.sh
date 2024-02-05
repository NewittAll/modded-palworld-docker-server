#!/bin/bash
service cron start
exec gosu steam /palworld/Scripts/start.sh
