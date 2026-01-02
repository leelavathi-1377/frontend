# Stage 1: Build
FROM node:16-slim AS build
WORKDIR /app

# Install build tools for Rollup/Vite
RUN apt-get update && apt-get install -y build-essential python3 && rm -rf /var/lib/apt/lists/*

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Build React app
RUN npm run build

# Stage 2: Serve
FROM node:16-slim
WORKDIR /app

# Install 'serve' to serve static files
RUN npm install -g serve

# Copy built files from previous stage
COPY --from=build /app/build ./build

# Use Cloud Run port
ENV PORT $PORT
EXPOSE $PORT

# Serve the React app
CMD ["sh", "-c", "serve -s build -l $PORT"]
