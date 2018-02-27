# Java (Spring Boot) + Docker + Kubernetes (k8s) = Hello World + Current Date

This document provides a brief overview of this project and how to build them from scratch.

# Overview

The Hello-world project is running in a Docker container, when its API is called, it gets the NAME and SURNAME from an application.yaml file, or environment variables to return as a String.
It also calls an API to get the current date and append this information to the returned String. The called API is running in other Docker container, and simply return the current date.

The main objective here is to test the following Kubernetes features:

1. DNS Services - Inside hello-world's [application.yaml](https://github.com/campidelli/java-docker-k8s-hello-world-and-current-date/blob/master/hello-world/src/main/resources/application.yaml)
file, there is a property called ```current-date.endpoint```, its value is not a PROTOCOL://HOST:PORT address, it is the
Current-date service name created on Kubernetes, since both containers are deployed under the same domain, we only have to
lookup for the service name [(+ info)](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#a-records-1).

2. Envinment variables - Since we are using Spring Boot and its configurations described on application.yaml can be overrided
by command args and/or environment variable, we are testing how to pass environment variables from Kubernetes. Two environments
variables have been created on hello-world's [k8s_deployment.yaml](https://github.com/campidelli/java-docker-k8s-hello-world-and-current-date/blob/master/hello-world/k8s_deployment.yaml.template)
they are named YOUR_NAME and YOUR_SURNAME, and they must override these properties defined in its [application.yaml](https://github.com/campidelli/java-docker-k8s-hello-world-and-current-date/blob/master/hello-world/src/main/resources/application.yaml).

# How to build and run it

1. Install [GCloud tool](https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu) to access Google Cloud Platform
2. Install [Kubernetes tool](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-binary-via-curl) to manage your containers
3. Run ```gcloud init``` and select a project (usually the first one)
4. Execute the following command ```gcloud container clusters get-credentials <your-info>``` to update Kubernetes tool and allow it to access your cloud environment
5. Create an environment variable to get the project's ID ```export PROJECT_ID="$(gcloud config get-value project -q)"```
6. Run ```./k8s_build_push_run.sh```, it will build the projects, push their images to a registry, deploy them and create its services.

Once everything is done, and you access ```http://<hello-world-service-external-endpoint>/hello-world``` and you must see
```Hello Campidelli, Bruno. Today is <curren-date>.```

That is all :)
