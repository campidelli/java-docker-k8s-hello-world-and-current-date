FROM openjdk:8-jdk-alpine

RUN apk add --no-cache bash && \
        rm -rf /tmp/* \
        /var/cache/*

COPY ./target/current-date.jar     /opt/symphony/current-date/current-date.jar

WORKDIR /opt/symphony/current-date

ENTRYPOINT ["java", "-jar", "/opt/symphony/current-date/current-date.jar"]

EXPOSE 8080
