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
RUN addgroup -S rating_service_group && adduser -S rating_service_user -G rating_service_group

# Change to non-root privilege
USER rating_service_user

CMD ["java","-jar","app.jar"]