#!/bin/bash

# Copyright (c) 2020, NVIDIA CORPORATION. All rights reserved.
# Full license terms provided in LICENSE.md file.

CONTAINER_NAME=$1
if [[ -z "${CONTAINER_NAME}" ]]; then
    CONTAINER_NAME=nao-PD
fi

# This specifies a mapping between a host directory and a directory in the
# docker container. This mapping should be changed if you wish to have access to
# a different directory
HOST_DIR=$2
if [[ -z "${HOST_DIR}" ]]; then
    HOST_DIR=`realpath ${PWD}/..`
fi

CONTAINER_DIR=$3
if [[ -z "${CONTAINER_DIR}" ]]; then
    CONTAINER_DIR=/root/catkin_ws/src/nao
fi

echo "Container name     : ${CONTAINER_NAME}"
echo "Host directory     : ${HOST_DIR}"
echo "Container directory: ${CONTAINER_DIR}"
nao_ID=`docker ps -aqf "name=^/${CONTAINER_NAME}$"`
if [ -z "${nao_ID}" ]; then
    echo "Creating new nao docker container."
    xhost +local:root
    docker run -it --privileged --network=host -v ${HOST_DIR}:${CONTAINER_DIR}:rw -v /tmp/.X11-unix:/tmp/.X11-unix:rw --env="DISPLAY" --name=${CONTAINER_NAME} nao:melodic bash
else
    echo "Found nao docker container: ${nao_ID}."
    # Check if the container is already running and start if necessary.
    if [ -z `docker ps -qf "name=^/${CONTAINER_NAME}$"` ]; then
        xhost +local:${nao_ID}
        echo "Starting and attaching to ${CONTAINER_NAME} container..."
        docker start ${nao_ID}
        docker attach ${nao_ID}
    else
        echo "Found running ${CONTAINER_NAME} container, attaching bash..."
        docker exec -it ${nao_ID} bash
    fi
fi
