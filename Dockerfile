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

# add app
COPY . ./

# Imitate Heroku prod env, which is not run as root
# RUN addgroup -g 2000 -S myuser
# RUN adduser -S -G myuser -s /bin/bash -h /app myuser
# USER myuser

# start app
CMD ["npm", "start"]