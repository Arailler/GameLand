# ---------- Base layer ----------
FROM node:20-slim AS base
ENV NODE_ENV=production
WORKDIR /app
RUN apt-get update && \
    apt-get install -y --no-install-recommends openssl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# ---------- Install dependencies (including dev) ----------
FROM base AS deps
COPY package.json package-lock.json ./
RUN npm ci

# ---------- Build layer ----------
FROM deps AS builder
COPY . .
RUN npx prisma generate && \
    npm run build

# ---------- Install production dependencies ----------
FROM base AS prod-deps
COPY package.json package-lock.json* ./
COPY prisma ./prisma
RUN npm ci --omit=dev && \
    npx prisma generate

# ---------- Final image ----------
FROM base AS runner

RUN addgroup --system gameland && adduser --system --ingroup gameland gameland

COPY --from=builder /app/.next ./.next
COPY --from=builder /app/prisma ./prisma
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./package.json
COPY --from=prod-deps /app/node_modules ./node_modules

RUN mkdir -p /app/.next/cache/images \
    && chmod -R 755 /app/public /app/.next \
    && chown -R gameland:gameland /app/.next/cache/images

USER gameland

EXPOSE 3000
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"
CMD ["npm", "start"]