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

# Define ARG for port
ARG PORT=1337


# Copy nginx configuration template
COPY nginx.conf /etc/nginx/nginx.conf

# Replace placeholder with actual port value during build
RUN sed -i "s/\${PORT}/${PORT}/g" /etc/nginx/nginx.conf

# Copy built app from build stage
COPY --from=build /app/dist /usr/share/nginx/html

# Expose configurable port
EXPOSE ${PORT}

#Define ENV for port
ENV PORT=${PORT}

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
