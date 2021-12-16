Traefik Local Plugins
=====================

A demo of Traefik local plugins running in Kubernetes.

To demonstrate that the local plugin is running we'll block exploits against log4j.

## Prerequisites

This demo can be run in any k8s cluster that isn't already using Traefik, but to follow
along with this README, you'll need:

* This repository cloned locally
* [kind](https://kind.sigs.k8s.io/)
* A web browser
* cURL

## Running the Demo

First, start everything up, including your local Kubernetes cluster

```bash
kind create cluster --image=kindest/node:v1.23.0
kubectl apply -k k8s-demo/
```

Wait about a minute for things to get stable. When things are done, you should
have 4 running pods.

Once things are up, you'll want at least 3 terminal windows:

1. Port-forward the Traefik main ingress port
  
  `kubectl port-forward svc/traefik-ingress 8000:80`

2.  Port-forward the [Traefik dashboard](http://localhost:8080/dashboard/) (login with admin/password)
  
  `kubectl port-forward svc/traefik-admin 8080`

3. A place to run cURL commands:

Running `curl -v -H 'Host: example.com' -H 'User-Agent: ${${lower:j}ndi:ldap://127.0.0.1/a}' http://localhost:8000` should fail with the response code `500`.

Running `curl -v -H 'Host: example.com' http://localhost:8000` will return a 200 with
some information about the request as expected, since you're not trying to exploit anything
