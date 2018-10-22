#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash" \
&& rosrun turtlesim turtlesim_node

echo "$@"