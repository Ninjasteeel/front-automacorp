# Use an official Node.js runtime as a base image
FROM node:18.17.1-alpine3.17

# Set the working directory in the container
WORKDIR src/app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Expose the port on which the app will run
EXPOSE 8080

# Command to run the application
CMD ["npm", "run", "serve"]
