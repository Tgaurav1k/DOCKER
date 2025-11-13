docker is used make a image container that save the version also with so that no need to change the code .

Multistage in docker -> multistage in docker build allows you to use multiple FROM statements inside a single Dockerfile 

Reduce the size of image 

separate build environment from production environment 
avoid unnessary files like node modules cache etc 

Multistage lets you:-
1. build the app in stage 1 (full environment, big image)
2. copy only final build output into stage 2 . it helps to reduce the size of the image

#. final image size will become small, secure and faster to deploy.


As the Docker contain the container so that it save the entire version as well.

#Without multistage final image contains

eg=>
FROM node:18 AS builder
 WORKDIR /app
copy package.json ./
RUN npm install

COPY ..
RUN npm run build  #creates dist/folder

# ........ STAGE 2 Production  .........

FROM node:18-slim

WORKDIR /app

# COPY only the build output and required files
COPY --from=builder /app/dist ./dist
COPY package.json ./

RUN npm install --only=production

CMD ["node", "dist/server.js"]





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



##### MailHog -> Port:1025





Docker push =>  docker push gaurav1k/youtube-nodejs

like GitHub make a GitHub repo where you can push your docker image



Docker compose =>

docker compose up -> install and run the images you write in docker compose.yml file.



docker compose down -> remove all the install images and stopped them.



docker compose up -d -> run the container in the background.



docker ps -> check the command run in the background.

#### 

#### \#2nd video

#### Docker Network



docker network inspect bridge  =>

                      to connect docker container with the internet



Build your own network using docker =>

                docker network create -d bridge youtube

Tony Stark and my dr\_strange container can run continuously and connect with each other.



create file in this => touch abc.js



COPY..  => copy every file of the project to optimise it better.



## donot use ubuntu as it is too much big for small applications.



use alpine its for small

