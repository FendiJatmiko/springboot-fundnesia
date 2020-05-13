FROM maven:3.6.3-jdk-8
LABEL maintainer="jatmikofendi@gmail.com"
COPY . /app
WORKDIR /app
COPY pom.xml /app
RUN mvn clean install
COPY target/spring-boot-rest-api-docker-0.0.1-SNAPSHOT.jar /app/spring-boot-app.jar
ENTRYPOINT ["java","-jar","spring-boot-app.jar"]
