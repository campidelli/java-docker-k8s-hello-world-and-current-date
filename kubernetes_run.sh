#!/usr/bin/env bash
kubectl delete service hello-world-service

kubectl delete deployment hello-world

kubectl create -f kubernetes_deployment.yaml

kubectl create -f kubernetes_service.yaml
