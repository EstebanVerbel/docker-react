# This is a temp contained to build the files that will be serving with nginx in production
FROM node:alpine as builder


WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .

RUN npm run build

# Second base image. This is the one that will be used. The node:alpine is used just to build the files for the server
# This is for production
FROM nginx

# This tells beanstalk what port to expose for incomming traffic. Necessary for production, not for dev
EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html
