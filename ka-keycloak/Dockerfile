# Use official Keycloak base image
FROM quay.io/keycloak/keycloak:26.2.2

# Enable production features
ENV KC_DB=postgres
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_LOG_LEVEL=info

# Copy realm export for initial import (used with --import-realm)
COPY --chown=1000:1000 ./realm-export.json /opt/keycloak/data/import/realm-export.json

# Copy custom theme
COPY ./theme /opt/keycloak/themes/ka-theme

# Switch to root to set permissions and install scripts
USER root

# Build Keycloak
RUN /opt/keycloak/bin/kc.sh build
# Switch back to default non-root user
USER 1000

# Expose default Keycloak port
EXPOSE 8080
