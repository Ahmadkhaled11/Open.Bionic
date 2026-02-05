# Backend Dockerfile for Open.Bionic Elixir API
FROM elixir:1.15-alpine AS builder

# Install build dependencies
RUN apk add --no-cache build-base git

WORKDIR /app

# Install hex and rebar
RUN mix local.hex --force && mix local.rebar --force

# Set build environment
ENV MIX_ENV=prod

# Copy dependency files
COPY mix.exs mix.lock ./
COPY config config

# Install and compile dependencies
RUN mix deps.get --only prod
RUN mix deps.compile

# Copy application source
COPY lib lib
COPY priv priv

# Compile application
RUN mix compile

# Create release
RUN mix release

# ============================================
# Runtime Stage
# ============================================
FROM alpine:3.18 AS runner

# Install runtime dependencies
RUN apk add --no-cache libstdc++ openssl ncurses-libs

# Create non-root user
RUN addgroup -S app && adduser -S app -G app

WORKDIR /app

# Copy release from builder
COPY --from=builder /app/_build/prod/rel/open_bionic ./
RUN chown -R app:app /app

USER app

# Runtime configuration
ENV PHX_SERVER=true
ENV PORT=4000
EXPOSE 4000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:4000/api/v1/health || exit 1

# Start the application
CMD ["bin/open_bionic", "start"]
