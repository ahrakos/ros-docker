#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash" \
&& rosrun $PACKAGE_NAME $NODE_NAME

echo "$@"