# Build stage
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY . .
# Exclude test task from build (for now)
RUN mvn clean package -DskipTests

# Run stage
FROM openjdk:17-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Create a user and group
RUN addgroup -S config_server_group && adduser -S config_server_user -G config_server_group

# Change to non-root privilege
USER config_server_user

CMD ["java","-jar","app.jar"]