# ---------- Base layer ----------
FROM node:24-slim AS base
WORKDIR /app
RUN apt-get update && \
    apt-get install -y --no-install-recommends openssl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# ---------- Runner layer ----------
FROM base AS runner

RUN addgroup --system gameland && adduser --system --ingroup gameland gameland

COPY package.json package-lock.json ./
COPY .next ./.next
COPY prisma ./prisma
COPY public ./public
COPY node_modules ./node_modules

RUN mkdir -p /app/.next/cache/images \
    && chmod -R 755 /app/public /app/.next \
    && chown -R gameland:gameland /app/.next/cache/images

USER gameland
EXPOSE 3000
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"
CMD ["npm", "start"]
