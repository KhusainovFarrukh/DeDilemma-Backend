# Build stage
FROM openjdk:17-alpine AS build
WORKDIR /app
COPY . .
# Exclude test task from build (for now)
RUN ./gradlew clean build -x test

# Run stage
FROM openjdk:17-alpine
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar

# Create a user and group
RUN addgroup -S discovery_server_group && adduser -S discovery_server_user -G discovery_server_group

# Change to non-root privilege
USER discovery_server_user

CMD ["java","-jar","app.jar"]