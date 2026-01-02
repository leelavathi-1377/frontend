# Stage 1: Build
FROM node:16-slim as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve
FROM node:16-slim
WORKDIR /app
RUN npm install -g serve
COPY --from=build /app/build ./build
EXPOSE 8080
CMD ["serve", "-s", "build", "-l", "8080"]
