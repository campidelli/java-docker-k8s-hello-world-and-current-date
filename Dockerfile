FROM openjdk:8-jdk-alpine

EXPOSE 8080

COPY ./target/hello-world.jar /opt/symphony/hello-world/hello-world.jar
COPY ./startup.sh /opt/symphony/hello-world/startup.sh

WORKDIR /opt/symphony/hello-world

ENTRYPOINT [ "/opt/symphony/hello-world/startup.sh", "run" ]
