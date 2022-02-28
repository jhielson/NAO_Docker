(This README file and docker procedure has been largely inspired by the DOPE repository: https://github.com/NVlabs/Deep_Object_Pose/tree/master/docker)

## NAO in a Docker Container

### Steps

1. **Download the NAO code**
   ```
   $ git clone https://github.com/jhielson/NAO_Docker.git
   ```

2. **Build the docker image**
   ```
   $ cd NAO_Docker/docker
   $ docker build -t nao:melodic -f Dockerfile.melodic ..
   ```
   This will take several minutes and requires an internet connection.

3. **Run the container**
   ```
   $ ./run_nao_docker.sh [name] [host dir] [container dir]
   ```
   ```
   $ ./run_nao_docker.sh naoImage /home/yoda/Documents/NAO_Docker/src
   ```
   Parameters:
   - `name` is an optional field that specifies the name of this image. By default, it is `nao:melodic`.  By using different names, you can create multiple containers from the same image.
   - `host dir` and `container dir` are a pair of optional fields that allow you to specify a mapping between a directory on your host machine and a location inside the container.  This is useful for sharing code and data between the two systems.  By default, it maps the directory containing dope to `/root/catkin_ws/src/NAO_Docker` in the container.

      Only the first invocation of this script with a given name will create a container. Subsequent executions will attach to the running container allowing you -- in effect -- to have multiple terminal sessions into a single container.

5. **Build NAO**
5.1 Connect the robot to your computer using an ethernet cable. 
5.2 Access the network setting and change the IPV4 method to 'Link-Local Only'.

Now, you can turn the robot on. 

5.3 Press the button located on the robot's chest and wait. He will say:
"Hello! I am NAO. My IP adress is ..."
You can use the IP address in your browser to access the robot's configuration. 

---

6. Ros
6.1 Open a new terminal in the same container (if it's the first time you built the image, then you don't have to open a new terminal here)
```
$docker exec -it <image_name> bash
```

6.2 Run the following command and make note of your IP address:
```
$ifconfig
```
6.3 Open a new terminal in the same container (step 6.1). Run roscore:
```
$roscore 
```
6.4 Open a new terminal in the same container (step 6.1). Run roslaunch:
```
$roslaunch naoqi_driver naoqi_driver.launch nao_ip:=X roscore_ip:=X network_interface:=<eth0|wlan0|tethering...>
```
(if launch crashes due to audio, change the flag by running "roscd naoqi_driver", then edit file /share/boot_config.json)

6.5 To check rostopics, open a new terminal in the same container and then:
```
$rostopic list
$rostopic echo <name_of_topic>
$rostopic pub <name_of_topic> <type_of_package> <message>
```

NOTE: if bumbers and tactile sensors fail, a possible solution is:
- clone the following repository inside you catkin_ws/src folder: https://github.com/ros-naoqi/nao_robot/tree/master/nao_bringup
- go to catkin_ws folder, type "catkin_make", then "source devel/setup.bash"
