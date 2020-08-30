# Latest Node.js image
FROM node:latest

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package*.json ./

RUN npm install

# Copy app source
COPY . .
RUN chmod +x wait-for-it.sh

EXPOSE 8080