#!/usr/bin/env bash
printf "Building java project [hello-world]\n\n"
mvn clean install

printf "Get current project version and replace it inside the build manifest file\n"
VERSION=$(grep -Po -m 1 '<version>\K[^<]*' pom.xml)
printf "Project version: $(printf $VERSION)\n\n"

cp k8s_deployment.yaml.template k8s_deployment.yaml
sed -i -- "s/<VERSION>/$(printf $VERSION)/g" k8s_deployment.yaml

printf "Pulling Docker Java8 base image\n\n"
docker pull openjdk:8-jdk-alpine

printf "Building docker image [hello-world] for GCE\n"
printf "docker build -t gcr.io/${PROJECT_ID}/hello-world:$VERSION .\n\n"
export PROJECT_ID="$(gcloud config get-value project -q)"
docker build -f Dockerfile -t gcr.io/${PROJECT_ID}/hello-world:$VERSION .

printf "Uploading docker image [hello-world] on GCE\n"
printf "gcloud docker -- push gcr.io/${PROJECT_ID}/hello-world:$VERSION\n"
gcloud docker -- push gcr.io/${PROJECT_ID}/hello-world:$VERSION

printf "\nDeleting previous service on kubernetes\n"
printf "kubectl delete service hello-world-service\n"
kubectl delete service hello-world-service

printf "\nDeleting previous deployment on kubernetes\n"
printf "kubectl delete deployment hello-world\n"
kubectl delete deployment hello-world

printf "\nCreating a new deployment on kubernetes\n"
printf "kubectl create -f k8s_deployment.yaml\n"
kubectl create -f k8s_deployment.yaml

printf "\nCreating a new service on kubernetes\n"
printf "kubectl create -f k8s_service.yaml\n"
kubectl create -f k8s_service.yaml
