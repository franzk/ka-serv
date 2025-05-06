# This Dockerfile is used to create a base image for Java applications
FROM openjdk:21-jdk-slim

# Install necessary utilities to download the certificate
RUN apt-get update && apt-get install -y \
    ca-certificates curl openssl \
    && rm -rf /var/lib/apt/lists/*

# Add keycloak's SSL certificate to the Java truststore
RUN echo | openssl s_client -connect ka-auth.franzka.net:443 -servername ka-auth.franzka.net 2>/dev/null \
    | openssl x509 -outform PEM > /usr/local/share/ca-certificates/keycloak.crt

# Import the certificate into the Java truststore
RUN keytool -import -trustcacerts -noprompt \
    -alias keycloak \
    -file /usr/local/share/ca-certificates/keycloak.crt \
    -keystore $JAVA_HOME/lib/security/cacerts \
    -storepass changeit