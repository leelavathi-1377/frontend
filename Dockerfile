# Stage 1: Build
FROM node:16-slim as build
WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential python3 \
    && rm -rf /var/lib/apt/lists/*

COPY package*.json ./
RUN npm cache clean --force
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Serve
FROM node:16-slim
WORKDIR /app

RUN npm install -g serve
COPY --from=build /app/build ./build

# Use Cloud Run PORT
ENV PORT $PORT
EXPOSE $PORT

CMD ["sh", "-c", "serve -s build -l $PORT"]
