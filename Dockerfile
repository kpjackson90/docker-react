#Find node image from node repo and tag it as builder
FROM node:alpine as builder

#Define the work directory
WORKDIR '/app'

#Make a copy of the package.json file
COPY package.json .

#install all node dependencies
RUN npm install

#copy over the remaining files in the directory
COPY . .

#Build the project
RUN npm run build

#Find nginx image from docker repo
FROM nginx

#Copy build folder from the build phase to a specific location
COPY --from=builder /app/build /usr/share/nginx/html

