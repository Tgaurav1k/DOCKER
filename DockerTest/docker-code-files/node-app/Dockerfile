FROM node:22.12.0-alpine3.21

# Set working directory
WORKDIR /app

# Copy package files first (better caching)
COPY package.json package.json
COPY package-lock.json package-lock.json

# Install Node modules
RUN npm install

# Copy all project files
COPY . .

# Build project (if frontend or build step exists)
RUN npm run build



# Command to run your app
CMD ["npm", "start"]
