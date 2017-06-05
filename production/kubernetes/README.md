# Deploying TaxonWorks on Kubernetes 

_At present tntended to trigger memory rather than spell it out._

## Kubernetes

* [Cheatsheat](https://kubernetes.io/docs/user-guide/kubectl-cheatsheet/)

### Client

* `config` is typically in something like `~/.kube`

### Taxonworks configuration

* At [/k8s](https://github.com/SpeciesFileGroup/taxonworks/tree/development/k8s)

### Startup

* Apply specific settings. Files looking like [this](https://github.com/SpeciesFileGroup/taxonworks/tree/development/k8s/dev), namespace first, then  `kubectl apply -f .`
* Apply [application settings](https://github.com/SpeciesFileGroup/taxonworks/tree/development/k8s)

### Frequently used

* `kubectl get pod`
* `kubectl apply -f .` (start everything, but not recursively)
* `kubectl exec -it taxonworks-####-##### bash`
* `kubectl logs taxonworks-1122781372-5hm4z`
* `kubectl delete -f .`
* `kubectl get service` (get port for service)
* `kubectl proxy` (localhost:8001), then in browser: `http://127.0.0.1:8001/ui` (don't forget the /ui)

## Minikube (test in development)

* Switch context (change `config` in ~/.kube)
* `minikube ip` (get IP for minikube, stable, shouldn't change)

### Set context/onetime setup

* Create namespace for tw in minikube `kubectl create namespace tw`
* Set context: (run once, OS X version):

    #!/bin/bash
    export CONTEXT=$(kubectl config view | awk '/current-context/ {print $2}')
    kubectl config set-context $CONTEXT --namespace=tw

## Docker 

### Rebuilding production

The docker build uses `Dockerfile`.  Ultimately it will track the [master branch](https://github.com/SpeciesFileGroup/taxonworks/tree/master).

Containers are found at [https://hub.docker.com/u/sfgrp/][https://hub.docker.com/u/sfgrp/]. At present numerically tagged versions are production, and :dev is the development snapshot.  Neither is automatically updated yet.

* `docker build --rm -t sfgrp/taxonworks:0.0.x .` 
* `docker push sfgrp/taxonworks:0.0.x`

## OS X notes

* It really helps to have the latest `bash`.  [See here](https://apple.stackexchange.com/questions/193411/update-bash-to-version-4-0-on-osx/197172).
