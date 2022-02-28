#!/bin/bash
#

# Stop in case of any error.
set -e

source /opt/ros/melodic/setup.bash

# Create catkin workspace.
mkdir -p ${CATKIN_WS}/src
cd ${CATKIN_WS}/src
catkin_init_workspace
cd ..
catkin_make
