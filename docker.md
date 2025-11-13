docker is used save the version also with so that no need to change the code .



As the Docker contain the container so that it save the entire version as well.



Create a container no need to step up the operating system one by one.



#### https://hub.docker.com/



#### Daemon -> this is the actual docker which made the container , create images '



#### docker desktop => is the gui

#### 

container download => docker run -it ubuntu

## custom image

-> ubuntu

-> node

-> mongodb

-> Redis



##### Docker image => A blueprint or template for creating containers.

#### contain in container



###### Docker Container => A running instance of an image.

##### 

##### commands ->

1. ######  docker container ls -a => show all the container made in docker even they are open or close , does not matter that.
2. Docker start (container name) => to start the close container by using its name.
3. docker stop (container name) => to stop the start container by using its name
4.  docker exec magical\_goldstine ls => execute the command.
5. docker run it <image name>
6. docker exec <container\_name> <command>


create a Dockerfile and add these 


FROM ubuntu

RUN apt-get update
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get upgrade -y
RUN apt-get install -y nodejs

COPY package.json package.json
COPY package-lock.json package-lock.json
COPY main.js main.js

RUN npm install

ENTRYPOINT [ "node", "main.js" ]

next point 

build a docker by using the commands
 docker build -it youtube-nodejs .

docker run -it youtube-nodejs
run it local terminal

giving a local host terminal to this 
docker run -it -p 8000:8000 youtube-nodejs
Server started on PORT : 8000


to see whats going on in docker container 

PS C:\Users\Gaurav Kumar> docker exec -it 150e69c8bb bash
root@150e69c8bb67:/# ls
bin   etc   lib64    mnt           package-lock.json  root  srv  usr
boot  home  main.js  node_modules  package.json       run   sys  var
dev   lib   media    opt           proc               sbin  tmp
root@150e69c8bb67:/#

see what is in the file.
root@150e69c8bb67:/# cat main.js