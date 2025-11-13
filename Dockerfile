
FROM ubuntu

# these lines are fix as if i change in code this remain common
RUN apt-get update
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get upgrade -y
RUN apt-get install -y nodejs

WORKDIR /app

# if code changes docker will rebuild these files 
COPY package.json package.json
COPY package-lock.json package-lock.json

# finall npm install will occur.

RUN npm install

# change in code 
COPY main.js main.js

# put it inside a specific app


# # finall npm install will occur.
# RUN npm install

# COPY .. 
# to copy every file in big projects 

ENTRYPOINT [ "node", "main.js" ]