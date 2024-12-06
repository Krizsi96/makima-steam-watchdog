#!/bin/bash

STEAM_IS_RUNNING=false
MAKIMA="makima.service"

sudo systemctl start "$MAKIMA"

while true; do
	PREV_STEAM_STATE=$STEAM_IS_RUNNING
	
	if pgrep -x steam > /dev/null; then
		echo "Steam is running"
		STEAM_IS_RUNNING=true
	else
		echo "Steam is not running"
		STEAM_IS_RUNNING=false
	fi
	
	if [ "$PREV_STEAM_STATE" != "$STEAM_IS_RUNNING" ]; then
		if [ "$STEAM_IS_RUNNING" = true ]; then
			echo "Steam started, stopping $MAKIMA"
			sudo systemctl stop "$MAKIMA"
		else
			echo "Steam stopped, starting $MAKIMA"
			sudo systemctl start "$MAKIMA"
		fi
	fi
	
	sleep 1
done

sudo systemctl stop "$MAKIMA"
