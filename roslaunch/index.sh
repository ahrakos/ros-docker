#!/bin/bash
set -e

# Put two source lines here from bashrc
# Write down the tutorial

# setup ros environment
sleep 2 \
&& source /opt/ros/$ROS_DISTRO/setup.bash \
&& source /root/catkin_ws/devel/setup.bash \
&& roslaunch $PACKAGE_NAME $LAUNCH_FILE

exec "$@"