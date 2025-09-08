# ---- builder ----
FROM node:18-alpine AS builder
WORKDIR /app

# path to your app inside the repo (provided at build time)
ARG APP_SRC=.

# only copy manifests first for better caching
COPY ${APP_SRC}/package*.json ./
RUN npm ci --no-audit --no-fund

# now copy the full app source and build
COPY ${APP_SRC}/ ./
# If your app uses Nest/TypeScript, this builds to dist/
# otherwise adjust to your build command or remove if not needed
RUN npm run build || echo "no build script; skipping"

# ---- runtime ----
FROM node:18-alpine AS runtime
WORKDIR /app

# copy only package manifests first, install prod deps
COPY --from=builder /app/package*.json ./
RUN npm ci --omit=dev --no-audit --no-fund

# copy built output (dist/) if present, else copy source
# dist/ path assumes typical Nest/TS. Adjust if your app differs.
COPY --from=builder /app/dist ./dist 2>/dev/null || true
COPY --from=builder /app/. ./

ENV NODE_ENV=production
EXPOSE 4000

# Prefer "node dist/main.js" for Nest/TS; else fall back to npm start
CMD [ "sh", "-c", "if [ -f dist/main.js ]; then node dist/main.js; else npm start; fi" ]
