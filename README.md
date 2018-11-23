# ros-docker / Uriah Ahrak
A docker-compose project structure for ROS system

This project should allow you to install ROS dependancies on your machine without 
walking through the difficult part.

# Walkthrough
1. Download and install Docker (https://www.docker.com) (I will not cover more than basic commands in docker in this tutorial,
so make sure you know some intermediate commands)

2. Clone this project as is to a folder on your computer via
    ```
    $ git clone https://github.com/ahrakos/ros-docker.git
    ```
    
3. If you are not running MacOS, please skip to the next step. Only for mac users: Download and install Quartz,
install the software, open it, go to Preferences -> Security -> Tick the 'V' where it is said 'Allow connections...'.
After that, restart your computer, and open Quartz again. This time open a terminal and execute the command:
    ```
    $ ifconfig | grep inet
    ```
    
    and grab your local IP Address. Then, run the command:
    ```
    $ xhost
    $ xhost <Your IP Address> (e.g xhost 172.15.8.52)
    ```
    
    Now, update the .env_turtlesim file under the envs folder, with your IP Address as the DISPLAY property.
    ```
    e.g DISPLAY=172.80.5.10:0
    ```
    
4. Open a terminal in the project's folder, and run this command:
    ```
    $ docker-compose up -d
    ```
    
5. Now docker will download and build the images to start the Turtlesim program, it might take some time,
after all you will be downloading about 1.2GB of files

6. Docker will start the program automatically. you don't need to do anything else.

# Core of concepts
Docker is an OS virtualization software. It means, you can build images from ubuntu or any OS you would like to,
and docker will use the host's kernel to simulate the kernel of the image's OS. An image is usually built into a container,
which in some terms is very similar to a VM.

In this project, docker will create 3 containers. One for roscore (The ROS Master), which should be running anytime you would
like to run your nodes, and there will only be one roscore process (According to Mika).
The other nodes is up to you. I configured 2 more containers - one for the GUI of turtlesim and one for the turtlesim_teleop,
which allows you to take control of the robot and move it with your arrow keys.

# Features

- Create a new package: After the containers are running, please write down the command:
    ```
    $ docker container ls
    ```
    
    to find out the container ids. You will find out there are 3 containers.
    Now copy one id (It doesn't matter which ID you are copying, since all of them are connected to the same volume on your
    file system - which is the folder 'workspace' on the project).
    Now get into the container via this command:
    ```
    $ docker container exec -it <CONTAINER_ID> bash
    ```
    
    You will now get access to the container, and all you have to do is actually run this command:
    ```
    $ catkin_create_pkg <PACKAGE_NAME> <DEP_1> <DEP_2> <DEP_3> ... <DEP_N>
    ```
    
    while DEP_1 ... DEP_N are dependencies of your package.

    Now after you created your package, you can go back to the project's folder (Outside the container, yes, in YOUR    
    computer), and find out that the files were created inside 'workspace' folder.

- Compile a package: Get into one of the containers, as explained in the last paragraph, and write down:
    ```
    $ cd /root/catkin_ws
    $ catkin_make
    ```
    
- Add a container for running your package: Create a file inside 'envs' folder in this project. Write down this params:
    ```
    PACKAGE_NAME=<YOUR_EXACT_PACKAGE_NAME>
    NODE_NAME=<YOUR_EXECUTABLE>
    ```
    
    e.g Take a look at .env_hello file if you would like to see an appropriate one.
    Now all you need to do is make sure you have a service under services in the docker-compose.yaml file,
    with a unique name, and make sure that the .env_file property is set to the file you've just created.
    Also, make sure you have your IPs configured well in the .env file.


Created by Uriah Ahrak
