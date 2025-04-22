FROM gradle:8.13.0-jdk-alpine AS build
WORKDIR /app

COPY --chown=gradle:gradle . .
RUN gradle build --no-daemon -x test

# ==========================

FROM openjdk:21-jdk-slim
WORKDIR /app

# Installer utilitaires pour télécharger le certificat
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Récupérer le certificat SSL de Keycloak
RUN echo | openssl s_client -connect ka-auth.franzka.net:443 -servername ka-auth.franzka.net 2>/dev/null \
    | openssl x509 -outform PEM > /usr/local/share/ca-certificates/keycloak.crt

# Importer dans le truststore Java
RUN keytool -import -trustcacerts -noprompt \
    -alias keycloak \
    -file /usr/local/share/ca-certificates/keycloak.crt \
    -keystore $JAVA_HOME/lib/security/cacerts \
    -storepass changeit

# Copier le jar
COPY --from=build /app/build/libs/*.jar ./app.jar

EXPOSE 5027

ENTRYPOINT ["java", "-jar", "app.jar"]