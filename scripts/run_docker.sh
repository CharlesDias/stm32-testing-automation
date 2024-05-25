#!/bin/bash

# Check if Dockerfile name, image name and version were provided
if [ -z "$1" ]; then
    echo "Error: No Docker image name provided. Type one of the following:"
    echo "  charlesdias/stm32_dev_env:1.0"
    echo "  charlesdias/stm32_dev_env:1.1"
    exit 1
fi

# Docker image
IMAGE=$1

# ST-Link Probe
STLINK_PROBE_FOLDER="/dev/bus/usb"

# Docker command
DOCKER_COMMAND="docker run -it --rm -v $(pwd):/project -w /project -v $STLINK_PROBE_FOLDER:$STLINK_PROBE_FOLDER"

# Check if /dev/ttyACM0 exists
if [ -c /dev/ttyACM0 ]; then
    DOCKER_COMMAND+=" --device=/dev/stlinkv2-1_3 --device=/dev/ttyACM0"
else
    printf "                      !!!!! Warning !!!!!\n"
    printf "ST-Link was not found. Check if the STM32 board is connected.\n"
fi

# Run Docker command
$DOCKER_COMMAND $IMAGE