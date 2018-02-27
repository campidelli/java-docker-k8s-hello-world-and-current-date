FROM openjdk:8-jdk-alpine

RUN apk add --no-cache bash && \
        rm -rf /tmp/* \
        /var/cache/*

COPY ./target/hello-world.jar     /opt/symphony/hello-world/hello-world.jar

WORKDIR /opt/symphony/hello-world

ENTRYPOINT ["java", "-jar", "/opt/symphony/hello-world/hello-world.jar"]

EXPOSE 8080
