#!/usr/bin/env bash
printf "Building java project [current-date]\n\n"
mvn clean install

printf "Get current project version and replace it inside the build manifest file\n"
VERSION=$(grep -Po -m 1 '<version>\K[^<]*' pom.xml)
printf "Project version: $(printf $VERSION)\n\n"

cp k8s_deployment.yaml.template k8s_deployment.yaml
sed -i -- "s/<VERSION>/$(printf $VERSION)/g" k8s_deployment.yaml

printf "Pulling Docker Java8 base image\n\n"
docker pull openjdk:8-jdk-alpine

printf "Building docker image [current-date] for GCE\n"
printf "docker build -t gcr.io/${PROJECT_ID}/current-date:$VERSION .\n\n"
export PROJECT_ID="$(gcloud config get-value project -q)"
docker build -f Dockerfile -t gcr.io/${PROJECT_ID}/current-date:$VERSION .

printf "Uploading docker image [current-date] on GCE\n"
printf "gcloud docker -- push gcr.io/${PROJECT_ID}/current-date:$VERSION\n"
gcloud docker -- push gcr.io/${PROJECT_ID}/current-date:$VERSION

printf "\nDeleting previous service on kubernetes\n"
printf "kubectl delete service current-date-service\n"
kubectl delete service current-date-service

printf "\nDeleting previous deployment on kubernetes\n"
printf "kubectl delete deployment current-date\n"
kubectl delete deployment current-date

printf "\nCreating a new deployment on kubernetes\n"
printf "kubectl create -f k8s_deployment.yaml\n"
kubectl create -f k8s_deployment.yaml

printf "\nCreating a new service on kubernetes\n"
printf "kubectl create -f k8s_service.yaml\n"
kubectl create -f k8s_service.yaml
