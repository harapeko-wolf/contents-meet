##################### builder #####################
FROM node:21-alpine AS builder
WORKDIR /app
COPY frontend/package*.json ./
RUN npm ci
COPY frontend .
RUN npm run build

##################### dev (ホットリロード) ########
FROM node:21-alpine AS dev
WORKDIR /app
COPY frontend .
RUN npm install
EXPOSE 3000
CMD ["npm","run","dev"]