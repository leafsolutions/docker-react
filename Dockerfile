# Production configuration
FROM node:16-alpine AS builder
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
# all the code needed for production
# is contained in the app/build directory

# setting up a nginx server for prod env
FROM nginx
# EXPOSE is a statement for other developers
# in AWS, however, the statement is taken seriously and
# used for automatic port mapping
EXPOSE 80
# copy something from the builder phase
# /app/build is the dir where the code is located
# the second location is the destination folder
#and in this case depends on a nnginx (default) configuration
COPY --from=builder /app/build /usr/share/nginx/html