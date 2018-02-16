#!/usr/bin/env bash
WORKSPACE="$(pwd)"

echo "Building java project [hello-world]"
mvn clean install

echo "Get current project version and replace it inside the build manifest file"
VERSION=$(grep -Po -m 1 '<version>\K[^<]*' pom.xml)
echo "Project version: $(echo $VERSION)"

cp deploy_manifest.yaml.template deploy_manifest.yaml
sed -i -- "s/<VERSION>/$(echo $VERSION)/g" deploy_manifest.yaml

echo "Pulling Docker Java8 base image"
docker pull openjdk:8-jdk-alpine

echo "Building docker image [hello-world] for GCE"
echo "docker build -t gcr.io/${PROJECT_ID}/hello-world:$VERSION ."
export PROJECT_ID="$(gcloud config get-value project -q)"
docker build -f Dockerfile -t gcr.io/${PROJECT_ID}/hello-world:$VERSION .

echo "Uploading docker image [hello-world] on GCE"
echo "gcloud docker -- push gcr.io/${PROJECT_ID}/hello-world:$VERSION"
gcloud docker -- push gcr.io/${PROJECT_ID}/hello-world:$VERSION
