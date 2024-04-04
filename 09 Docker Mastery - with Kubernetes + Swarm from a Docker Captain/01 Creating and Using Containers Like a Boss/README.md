# Creating and Using Containers Like a Boss

## Check Our Docker Install and Config

```docker
docker version

docker info

docker

docker container run

docker run
```

## 02 Starting a Nginx Web Server

```docker
# 0. docker looked for a image 'nginx
# 1. Download image 'nginx' from docker hub
# 2. Started a new container from that image
# 3. Opened port 80 on the host IP
# 4. Routes that traffic on the container IP, port 80
docker container run --publish 80:80 nginx

# --detach = Tell's docker to run it in the background
# every time we run a new container, we get a new unique ID
docker container run --publish 80:80 --detach nginx

# List our containers
docker container ls

# Stop the container with container_ID
docker container stop 690

# ls command only shows by default running containers
docker container ls

# List all container
docker container ls -a

# webhost = Name of our new container
docker container run --publish 80:80 --detach --name webhost nginx

docker container ls -a

# See the container host
docker container logs webhost

# See the process running inside the container
docker container top webhost

docker container --help

docker container ls -a

# Remove container with Container_ID
docker container rm 63f 690 ode

docker container ls

docker container rm -f 63f

docker container ls -a

## *** Assignment ***

docker container run --publish 80:80 --detach --name webhost nginx

docker container run --publish 8080:80 --detach --name apache httpd

docker container run --publish 3306:3306 --detach --name mysql mysql
```

