FROM node:14-alpine3.11 AS builder

WORKDIR /app

COPY package*.json ./

RUN apk --no-cache --virtual build-dependencies add python make g++ \
    && npm install
    
COPY . .

# Install client dependencies
RUN mkdir -p ./public ./data \
    && cd client \
    && npm install \
    && npm rebuild node-sass

# Build
RUN npm run build \
    && mv ./client/build/* ./public

# Clean up src files
RUN rm -rf src/ ./client \
    && npm prune --production \
    && apk del build-dependencies

FROM node:14-alpine

USER node

WORKDIR /app

COPY --from=builder /app /app

EXPOSE 5000

ENV NODE_ENV=production

CMD ["node", "build/server.js"]