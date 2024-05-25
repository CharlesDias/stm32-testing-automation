#!/bin/bash

# Check if Dockerfile name, image name and version were provided
if [ -z "$1" ]; then
    echo "Error: No Dockerfile name provided. Type one of the following:"
    echo "  Dockerfile.dev"
    exit 1
fi

if [ -z "$2" ]; then
    echo "Error: No image name provided. Type one of the following:"
    echo "  charlesdias/stm32_dev_env"
    exit 1
fi

if [ -z "$3" ]; then
    echo "Error: No image version provided. Type one of the following:"
    echo "  1.0"
    exit 1
fi

# Get current path folder
CURRENT_PATH=$(pwd)

# Dockerfile location and name
DOCKERFILE_PATH="$CURRENT_PATH/docker"
DOCKERFILE_NAME=$1

# Docker image name and version
IMAGE_NAME=$2
IMAGE_VERSION=$3

# Full image name
FULL_IMAGE_NAME="$IMAGE_NAME:$IMAGE_VERSION"

# Change to Dockerfile directory
echo $DOCKERFILE_PATH
cd $DOCKERFILE_PATH

# Docker build command
docker build -f $DOCKERFILE_NAME --build-arg host_uid=$(id -u) --build-arg host_gid=$(id -g) -t $FULL_IMAGE_NAME .