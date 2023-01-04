FROM node:18

# Create app directory
WORKDIR /usr/src/app

# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package*.json ./

# Install app dependencies
RUN npm install
# If you are building your code for production
#RUN npm ci --only=production

# Bundle app source
COPY . .

# Container port
EXPOSE 3000

# Start application
CMD [ "node", "app.js" ]
