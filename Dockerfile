# pull official base image
FROM node:13.12.0-alpine

# add non root user, don't switch until chown /app
RUN addgroup -g 1001 -S appuser && \ 
    adduser -u 1001 -S appuser -G appuser

# set working directory, use root to chown and then switch to non root user
WORKDIR /app
RUN chown -R 1001:1001 /app
USER 1001

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# install app dependencies
COPY package.json ./
COPY package-lock.json ./
RUN npm install && npm audit fix --force

# add app with non root owner
COPY --chown=1001:1001 . ./

# start app
CMD ["npm", "start"]