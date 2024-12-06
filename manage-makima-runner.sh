#!/bin/bash

SERVICE_NAME="makima-runner.service"
SERVICE_DESTINATION="/etc/systemd/system/$SERVICE_NAME"
SCRIPT_NAME="makima-runner.sh"
SCRIPT_DESTINATION="/usr/bin/$SCRIPT_NAME"

install_script() {
	SOURCE_FILE="./$SCRIPT_NAME"
	echo "Installing $SCRIPT_NAME..."
	if [ ! -f "$SOURCE_FILE" ]; then
		echo "Error: $SOURCE_FILE not found in the current directory."
		exit 1
	fi
	echo "Copying $SCRIPT_NAME to $SCRIPT_DESTINATION..."
	sudo cp "$SOURCE_FILE" "$SCRIPT_DESTINATION"
	echo "Installation complete. The script is now active for system-sleep"
}

uninstall_service() {
	echo "Uninstalling $SCRIPT_NAME..."
	if [ -f "$DESTINATION" ]; then
		echo "Removing $SCRIPT_NAME from $SCRIPT_DESTINATION..."
		sudo rm -f "$SCRIPT_DESTINATION"
	else
		echo "Service file not found in $SCRIPT_DESTINATION. Skipping removal."
	fi
	echo "Uninstallation complete. The script has been removed."
}

install_service() {
	SOURCE_FILE="./$SERVICE_NAME"
	echo "Installing $SERVICE_NAME..."
	if [ ! -f "$SOURCE_FILE" ]; then
		echo "Error: $SOURCE_FILE not found in the current directory."
		exit 1
	fi
	echo "Copying $SERVICE_NAME to $SERVICE_DESTINATION..."
	sudo cp "$SOURCE_FILE" "$SERVICE_DESTINATION"
	echo "Reloading systemd daemon..."
	sudo systemctl daemon-reload
	echo "Enabling $SERVICE_NAME..."
	sudo systemctl enable "$SERVICE_NAME"
	echo "Installation complete. The service is now active."
}

uninstall_service() {
	echo "Uninstalling $SERVICE_NAME..."
	sudo systemctl stop "$SERVICE_NAME"
	echo "Disabling $SERVICE_NAME..."
	sudo systemctl disable "$SERVICE_NAME"
	if [ -f "$SERVICE_DESTINATION" ]; then
		echo "Removing $SERVICE_NAME from $SERVICE_DESTINATION..."
		sudo rm -f "$SERVICE_DESTINATION"
	else
		echo "Service file not found in $SERVICE_DESTINATION. Skipping removal."
	fi
	echo "Reloading systemd daemon..."
	sudo systemctl daemon-reload
	echo "Uninstallation complete. The service has been removed."
}

if [ "$1" == "install" ]; then
	install_script
	install_service
elif [ "$1" == "uninstall" ]; then
	uninstall_script
	uninstall_service
else
	echo "Usage: $0 [install|uninstall]"
	exit 1
fi
