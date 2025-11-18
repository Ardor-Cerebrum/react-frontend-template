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

# Define ARG for port and backend URL
ARG PORT=1337
ARG BACKEND_URL=""

# Copy nginx configuration template
COPY nginx.conf /etc/nginx/nginx.conf

# Replace placeholders with actual values during build
RUN sed -i "s/\${PORT}/${PORT}/g" /etc/nginx/nginx.conf && \
    sed -i "s|\${BACKEND_URL}|${BACKEND_URL}|g" /etc/nginx/nginx.conf

# Copy built app from build stage
COPY --from=build /app/dist /usr/share/nginx/html

# Expose configurable port
EXPOSE ${PORT}

# Define ENV for runtime
ENV PORT=${PORT}
ENV BACKEND_URL=${BACKEND_URL}

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
