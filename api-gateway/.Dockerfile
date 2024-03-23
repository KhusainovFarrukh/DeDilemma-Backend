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
RUN addgroup -S api_gateway_group && adduser -S api_gateway_user -G api_gateway_group

# Change to non-root privilege
USER api_gateway_user

CMD ["java","-jar","app.jar"]