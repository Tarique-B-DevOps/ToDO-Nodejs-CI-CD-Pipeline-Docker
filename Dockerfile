FROM node:18

# Install PM2
RUN npm install pm2 -g

# Create app directory
WORKDIR /usr/src/app

# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package*.json ./

# Install app dependencies
RUN npm install

# Bundle app source
COPY . .


#Start Application Process
EXPOSE 3000
CMD [ "pm2-runtime","start","app.js" ]
