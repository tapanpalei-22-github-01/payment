# Use lightweight Alpine base image with Java 21
FROM eclipse-temurin:21-jdk-alpine

# Set working directory inside container
WORKDIR /app

# Copy the Spring Boot JAR
COPY payment.jar /app/payment.jar

# Copy configuration files (adjust paths as needed)
COPY config/ /app/config/

# Expose the default Spring Boot port
EXPOSE 8080

# Run the application
# The entry point is the JAR, which internally calls PaymentApplication.main()
ENTRYPOINT ["java", "-jar", "/app/payment.jar"]
