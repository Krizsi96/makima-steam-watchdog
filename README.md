# Makima Steam-watchdog

This project contains a `systemd` service to monitor the status of Steam, and start/stop [Makima](https://github.com/cyber-sushi/makima) accordingly.

## Features

- Start Makima at system boot up
- Stop Makima when Steam is started
- Restart Makima when Steam is stopped

## Installation

> Note: Makima should be available on your system as a [systemd service](https://github.com/cyber-sushi/makima?tab=readme-ov-file#running-makima).

You can install the service with `manage-makima-runner.sh` by running the following command.

```bash
./manage-makima-runner.sh install
```

This script will copy the files to the appropriate location and enable the `systemd` service.

## Check service

You can check the service via `systemctl`

```bash
systemctl status makima-runner.service
```

## Uninstallation

You can uninstall the service and remove the related files via this command.

```bash
./manage-makima-runner.sh uninstall
```

