
# STAGE 1

FROM node:22.12.0-alpine3.21 AS builder

# Set working directory
WORKDIR /build

# Copy package files first (better caching)
COPY package.json package.json
COPY package-lock.json package-lock.json

# Install Node modules
RUN npm install

# Copy all project files
COPY . .

# Build project (if frontend or build step exists)
RUN npm run build

# RUN rm -rf src/
# RUN rm -rf tsconfig.json

# STAGE 2
FROM node:22.12.0-alpine3.21 AS runner

WORKDIR /app

COPY --from=builder /build/node_modules node_modules/
COPY --from=builder /build/package.json package.json
COPY --from=builder /build/package-lock.json package-lock.json
COPY --from=builder /build/dist/ dist/
# Command to run your app
CMD ["npm", "start"]
