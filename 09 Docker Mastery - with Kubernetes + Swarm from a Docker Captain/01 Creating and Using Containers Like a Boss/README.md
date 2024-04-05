# Creating and Using Containers Like a Boss

## Check Our Docker Install and Config

```bash
docker version

docker info

docker

docker container run

docker run
```

## Starting a Nginx Web Server

```bash
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

docker container run -d -p 3306:3306 --name db -e MYSQL_RANDOM_ROOT_PASSWORD=yes MYSQL_RANDOM_ROOT_PASSWORD

docker container logs db

docker container run -d --name webserver -p 8080:80 httpd

docker ps

docker container run -d --name proxy -p 80:80 nginx

docker ps

docker container ls

docker container stop TAB COMPLETION

docker ps -a

docker container ls -a

docker container rm

docker ps -a

docker image ls
```

## What's Going On In Containers: CLI Process Monitoring

```bash
docker container run -d --name nginx nginx

docker container run -d --name mysql -e MYSQL_RANDOM_ROOT_PASSWORD=true mysql

docker container ls

# process list in one container
docker container top mysql

docker container top nginx

# Get back a json array of all the data about how this container was started
# details of one container config
docker container inspect mysql

docker container stats --help

# get back a streaming view of live performance data about our containers
# performance stats for all containers
docker container stats

docker container ls
```

## Getting a Shell Inside Containers: No Need for SSH

```bash
# docker container run -it (start new container interactively)
# docker container exec -it (run additional command in existing container)

docker container run -help

# you can send optional command argument
docker container run -it --name proxy nginx bash

docker container ls

docker container ls -a

docker container run -it --name ubuntu ubuntu

docker container ls

docker container ls -a

docker container start --help

docker container start -ai ubuntu

docker container exec --help

docker container exec -it mysql bash

docker container ls

docker pull alpine

docker image ls

docker container run -it alpine bash

docker container run -it alpine sh
```

## Docker Networks: Concepts for Private and Public Comms in Containers

```bash
docker container run -p 80:80 --name webhost -d nginx

docker container port webhost

# for windows use double quotes
docker container inspect --format '{{ .NetworkSettings.IPAddress }}' webhost
```
