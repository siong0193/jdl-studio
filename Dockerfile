# Use Node.js 18 Alpine as base
FROM node:18-alpine

# Install system dependencies for canvas and node-gyp
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    libpng \
    libpng-dev \
    jpeg-dev \
    pango-dev \
    cairo-dev \
    giflib-dev

# Set Python path for node-gyp
ENV PYTHON=/usr/bin/python3

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install production dependencies
RUN npm ci --only=production

# Copy built files
COPY dist /app/dist

# Copy server file
COPY server.js /app/server.js

# Expose the app port
EXPOSE 3000

# Command to run the app
CMD ["node", "server.js"]