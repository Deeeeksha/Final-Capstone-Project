FROM maven:3.6.0-jdk-8-alpine AS builder

WORKDIR /spring-app

COPY . .

RUN mvn package



FROM openjdk:18-jdk-alpine3.15

WORKDIR /spring-app

COPY --from=builder /spring-app/target/springboot-starterkit-1.0.jar .

EXPOSE 8080

ENV MONGODB_TABLE=Users MONGODB_PORT=27017 MONGODB_HOST=mongo 

ENTRYPOINT ["java", "-jar"]

CMD ["springboot-starterkit-1.0.jar"]