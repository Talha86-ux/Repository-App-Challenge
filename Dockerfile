# Multi-stage build for RepositoryChallenge Rails application
# Compatible with Amazon Linux 2023 (AL2023)

# Stage 1: Builder
FROM ruby:2.7.4-slim as builder

# Set environment variables
ENV RAILS_ENV=production \
    RACK_ENV=production \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    RAILS_LOG_TO_STDOUT=true

# Install system dependencies required for building gems
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    postgresql-client \
    sqlite3 \
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js and Yarn for asset compilation
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn && \
    rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Copy Gemfile and package files
COPY Gemfile Gemfile.lock ./
COPY package.json yarn.lock ./

# Install Ruby gems
RUN bundle install --without development test

# Install JavaScript dependencies
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Copy application code
COPY . .

# Precompile assets
ARG RAILS_MASTER_KEY
ENV RAILS_MASTER_KEY=$RAILS_MASTER_KEY
RUN bundle exec rails assets:precompile

# Stage 2: Runtime
FROM ruby:2.7.4-slim

# Set environment variables
ENV RAILS_ENV=production \
    RACK_ENV=production \
    BUNDLE_PATH=/usr/local/bundle \
    RAILS_LOG_TO_STDOUT=true

# Install runtime dependencies only
RUN apt-get update && apt-get install -y \
    sqlite3 \
    postgresql-client \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy bundle from builder
COPY --from=builder /usr/local/bundle /usr/local/bundle

# Copy application from builder
COPY --from=builder /app .

# Create non-root user for security
RUN useradd -m -u 1000 appuser && \
    chown -R appuser:appuser /app
USER appuser

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:3000/health || exit 1

# Entrypoint script
RUN echo '#!/bin/bash\n\
set -e\n\
\n\
echo "Preparing database..."\n\
bundle exec rails db:create db:migrate\n\
\n\
echo "Starting Rails server..."\n\
exec bundle exec puma -c config/puma.rb' > /app/docker-entrypoint.sh && \
    chmod +x /app/docker-entrypoint.sh

ENTRYPOINT ["/app/docker-entrypoint.sh"]
