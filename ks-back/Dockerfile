FROM gradle:8.13.0-jdk-alpine AS build
WORKDIR /app

COPY --chown=gradle:gradle . .
RUN gradle build --no-daemon -x test

FROM openjdk:21-jdk-slim
WORKDIR /app
COPY --from=build /app/build/libs/*.jar ./app.jar

EXPOSE 5027

ENTRYPOINT ["java", "-jar", "app.jar"]