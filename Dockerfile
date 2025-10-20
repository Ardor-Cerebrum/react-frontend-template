# Build stage
FROM node:18-alpine AS build

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm i

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Production stage
FROM nginx:alpine

# Define ARG and ENV for port
ARG ARDOR_PORT=1337
ENV ARDOR_PORT=${ARDOR_PORT}

# Copy nginx configuration template
COPY nginx.conf /etc/nginx/nginx.conf

# Copy built app from build stage
COPY --from=build /app/dist /usr/share/nginx/html

# Expose configurable port
EXPOSE ${ARDOR_PORT}

# Start nginx with envsubst to replace environment variables
CMD ["/bin/sh", "-c", "envsubst '$ARDOR_PORT' < /etc/nginx/nginx.conf > /etc/nginx/nginx.conf.tmp && mv /etc/nginx/nginx.conf.tmp /etc/nginx/nginx.conf && nginx -g 'daemon off;'"]
