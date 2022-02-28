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

