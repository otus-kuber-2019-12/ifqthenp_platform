#!/usr/bin/env bash

kubectl apply -f ./prometheus-operator/crds/crd-alertmanager.yaml
kubectl apply -f ./prometheus-operator/crds/crd-podmonitor.yaml
kubectl apply -f ./prometheus-operator/crds/crd-prometheus.yaml
kubectl apply -f ./prometheus-operator/crds/crd-prometheusrules.yaml
kubectl apply -f ./prometheus-operator/crds/crd-servicemonitor.yaml
kubectl apply -f ./prometheus-operator/crds/crd-thanosrulers.yaml

kubectl create namespace monitoring

helm upgrade --install prometheus ./prometheus-operator \
    --namespace monitoring \
    --set prometheusOperator.createCustomResource=false \
    --set prometheus.serviceMonitorSelectorNilUsesHelmValues=false \
    --set grafana.adminPassword=admin

kubectl apply -f ./nginx/servicemonitor.yaml -f ./nginx/nginx.yaml
