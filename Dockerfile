FROM maven:3.6.3-jdk-8 AS build-dev
LABEL maintainer="jatmikofendi@gmail.com"
COPY . /app/
WORKDIR /app
RUN mvn clean install
# Use an official OpenJDK runtime as a parent image
FROM openjdk:8-jre-alpine
RUN apk update && apk add bash
# Set the working directory to /app
WORKDIR /app
# Copy the fat jar into the container at /app
COPY --from=build-dev /app/target/docker-java-app-example.jar /app
# Make port 8080 available to the world outside this container
EXPOSE 8080
# Run jar file when the container launches
CMD ["java", "-jar", "docker-java-app-example.jar"]
