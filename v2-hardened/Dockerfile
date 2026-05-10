#stge 1: builder-------
FROM node:20-slim AS builder
WORKDIR /app
COPY app/package*.json ./
RUN npm install
RUN npm ci --only=production --omit=dev
COPY app/server.js .

#stage2: final( the fortress) ---
FROM gcr.io/distroless/nodejs20-debian12
WORKDIR /app

# we only take app and results of build
COPY --from=builder /app /app

#distroless gave by default nonroot user (uid:65532)
USER nonroot
EXPOSE 3000

CMD ["server.js"]

