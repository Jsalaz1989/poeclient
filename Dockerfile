# pull official base image
FROM node:13.12.0-alpine

# set working directory
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# install app dependencies
COPY package.json ./
COPY package-lock.json ./
RUN npm install && npm audit fix --force

# add app with non root owner
COPY . ./

# switch to non-root user 'node' (uid: 1000), which comes with alpine image
# switch now instead of earlier to allow for other commands to be run as root
# for react hot reloading needs to be 1000 because host user is also 1000
USER 1000

ENV CI true 
RUN npm run test

# start app
CMD ["npm", "start"]