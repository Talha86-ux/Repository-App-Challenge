WORKDIR /app

# Copy bundle from builder
COPY --from=builder /usr/local/bundle /usr/local/bundle

# Copy application from builder
COPY --from=builder /app .

# Entrypoint script — create BEFORE switching user
RUN echo '#!/bin/bash\n\
set -e\n\
\n\
echo "Precompiling assets..."\n\
bundle exec rails assets:precompile\n\
\n\
echo "Preparing database..."\n\
bundle exec rails db:create db:migrate\n\
\n\
echo "Starting Rails server..."\n\
exec bundle exec puma -c config/puma.rb' > /app/docker-entrypoint.sh && \
    chmod +x /app/docker-entrypoint.sh

# Create non-root user for security
RUN useradd -m -u 1000 appuser && \
    chown -R appuser:appuser /app
USER appuser

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:3000/health || exit 1

# ✅ This line was missing!
ENTRYPOINT ["/app/docker-entrypoint.sh"]