FROM maven:3.6.0-jdk-8-alpine AS builder

WORKDIR /spring-app

COPY . .

RUN mvn package -DskipTests


FROM openjdk:18-jdk-alpine3.15

WORKDIR /spring-app

COPY --from=builder /spring-app/target/springboot-starterkit-1.0.jar .

ENV MONGODB_TABLE Users

EXPOSE 8080

ENTRYPOINT ["java", "-jar"]

CMD ["springboot-starterkit-1.0.jar"]