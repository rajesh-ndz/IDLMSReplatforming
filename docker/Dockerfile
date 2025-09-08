# ---- builder ----
FROM node:18-alpine AS builder
WORKDIR /app

# path to your app inside the repo (provided at build time)
ARG APP_SRC=.

# copy manifests first for cache
COPY ${APP_SRC}/package*.json ./
RUN if [ -f package-lock.json ]; then \
    npm ci --no-audit --no-fund; \
    else \
    npm install --no-audit --no-fund; \
    fi

# copy source and build
COPY ${APP_SRC}/ ./
RUN npm run build || echo "no build script; skipping"

# ---- artifact (strip dev stuff like node_modules) ----
FROM node:18-alpine AS artifact
WORKDIR /out
COPY --from=builder /app/ ./
RUN rm -rf node_modules

# ---- runtime ----
FROM node:18-alpine AS runtime
WORKDIR /app

# install production deps only
COPY --from=artifact /out/package*.json ./
RUN if [ -f package-lock.json ]; then \
    npm ci --omit=dev --no-audit --no-fund; \
    else \
    npm install --omit=dev --no-audit --no-fund; \
    fi

# bring app code (includes dist if it exists)
COPY --from=artifact /out/ ./

ENV NODE_ENV=production
EXPOSE 4000

# Prefer compiled dist/main.js (Nest). Fallback to npm start.
CMD [ "sh", "-c", "if [ -f dist/main.js ]; then node dist/main.js; else npm start; fi" ]
