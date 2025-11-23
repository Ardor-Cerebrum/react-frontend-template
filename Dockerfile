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

# Build args for nginx configuration
ARG PORT=1337
ARG BACKEND_URL=""  # Leave empty for static-only, or set default: "http://backend:{PORT}}"

# Copy nginx configuration template and substitute variables
COPY nginx.conf /etc/nginx/nginx.conf
RUN sed -i "s/\${PORT}/${PORT}/g" /etc/nginx/nginx.conf && \
    if [ -z "$BACKEND_URL" ]; then \
      # If no backend, use dummy URL (502 on /api calls - expected for static frontend)
      sed -i "s|\${BACKEND_URL}|http://127.0.0.1:9999|g" /etc/nginx/nginx.conf; \
    else \
      sed -i "s|\${BACKEND_URL}|${BACKEND_URL}|g" /etc/nginx/nginx.conf; \
    fi

# Copy built app from build stage
COPY --from=build /app/dist /usr/share/nginx/html

# Expose configurable port
EXPOSE ${PORT}

# Define ENV for runtime
ENV PORT=${PORT}
ENV BACKEND_URL=${BACKEND_URL}

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
