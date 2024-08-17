# Stage 1: Build the React app
FROM node:16 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock) to the container
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Create the production image
FROM node:16-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy only the build output from the previous stage
COPY --from=builder /app/build ./build

# Install a minimal server to serve the React app
RUN npm install -g serve

# Expose the port that the app will run on
EXPOSE 3000

# Start the React app when the container starts
CMD ["serve", "-s", "build", "-l", "3000"]
