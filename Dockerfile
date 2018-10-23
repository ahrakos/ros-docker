# This is an auto generated Dockerfile for ros:ros-core
# generated from docker_images/create_ros_core_image.Dockerfile.em
FROM ubuntu:xenial

ARG ROS_DISTRO
ARG ROS_MASTER_URI
ARG SCRIPT_FOLDER

# setup environment
ENV ROS_DISTRO ${ROS_DISTRO}
ENV ROS_MASTER_URI ${ROS_MASTER_URI}
ENV SCRIPT_FOLDER ${SCRIPT_FOLDER}
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# install packages
RUN apt-get update && apt-get install -q -y \
    dirmngr \
    gnupg2 \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    && rm -rf /var/lib/apt/lists/*


# bootstrap rosdep
RUN rosdep init \
    && rosdep update

# install ros packages
RUN apt-get update && apt-get install -y \
    ros-${ROS_DISTRO}-ros-core=1.3.2-0* \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update -y \ 
    && apt-get install -y ros-${ROS_DISTRO}-turtlesim \
    && export ROS_IP=`hostname -I`

RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc

# setup entrypoint
COPY ./${SCRIPT_FOLDER}/index.sh /

ENTRYPOINT [ "/index.sh" ]
CMD ["bash"]
