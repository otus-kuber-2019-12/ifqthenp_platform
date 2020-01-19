# ifqthenp_platform

ifqthenp Platform repository

## HW 1. Kubernetes Intro

- Created Docker image with simple http server using `kubernetes-intro/web/Dockerfile` file
- Created Kubernetes manifest file describing Pod with `containers` and `initContainer` specs
- :star: Fixed broken `frontend` Pod from [Hipster Shop repo][1] and saved result in `kubernetes-intro/frontend-pod-healthy.yaml`

[1]: https://github.com/GoogleCloudPlatform/microservices-demo

## HW 2. Kubernetes Controllers

- Launched Kubernetes cluster using [Kind][1] tool
- Created ReplicaSet resource for the `frontend` microservice
- Changed the number of replicas using ad-hoc command `kubectl scale replicaset frontend --replicas=3`
- Updated pod template in the `frontend` ReplicaSet to use different docker image:
  - `export KUBE_EDITOR="/usr/local/bin/code"`
  - `kubectl edit rs frontend` (change image tag either to `v0.0.1` or `v.0.0.2`)
  - `kubectl get replicaset frontend -o=jsonpath='{.spec.template.spec.containers[0].image}'`
  - `kubectl get pods -l app=frontend -o=jsonpath='{.items[0:3].spec.containers[0].image}'`
  - alternatively, make changes in `frontend-replicaset.yaml` file and re-apply it with `kubectl apply -f frontend-replicaset.yaml`
- Created ReplicaSet and Deployment resources for the `payment` microservice
- :star: Used `maxSurge` and `maxUnavailable` parameters in `payment` microservice to create deployment strategies similar to **Blue/Green** and **Reverse Rolling Update**
- Added pod readiness probes to `frontend` microservice:
  - `kubectl rollout status deployment/frontend --timeout=60s`
  - `kubectl rollout undo deployment/frontend` (in case of readiness probe failure)
- :star::star: Created manifest `node-exporter-daemonset.yaml` configured to collect hardware and OS metrics for both worker and master nodes using [Node Exporter][2]:
  - `kubectl port-forward <POD_NAME> 9100:9100`
  - `curl localhost:9100/metrics`

[1]: https://kind.sigs.k8s.io/docs/user/quick-start
[2]: https://github.com/prometheus/node_exporter

## HW 3. Kubernetes Security

Kubectl Reference Documents for ["kubectl auth can-i"][1]

Account usernames are formatted like this: `system:serviceaccount:<namespace>:<service account name>`

List available API resources: `kubectl api-resources`

### Task 1

Created ServiceAccount `bob` and assigned default ClusterRole `admin` to it,
using ClusterRoleBinding.

- `kubectl auth can-i --list --namespace=kube-system --as=system:serviceaccount:default:bob`
- `kubectl auth can-i --list --namespace=default --as=system:serviceaccount:default:bob`

Created ServiceAccount `dave` and assigned Role `dave` to it, using RoleBinding.
This role has permissions for using all resources and verbs within  `default` namespace.

- `kubectl auth can-i --list --namespace=kube-system --as=system:serviceaccount:default:dave`
- `kubectl auth can-i --list --namespace=default --as=system:serviceaccount:default:dave`

### Task 2
 
Created ServiceAccount `carol` in the Namespace `prometheus` and assigned permissions to `carol`
to read, list and watch Pods in all Namespaces of the cluster

- `kubectl auth can-i --list --namespace=kube-system --as=system:serviceaccount:prometheus:carol`
- `kubectl auth can-i watch pods --all-namespaces --as=system:serviceaccount:prometheus:carol`

### Task 3

Created Namespace `dev` and two ServiceAccounts `jane` and `ken`, assigned ClusterRole `admin`
and `view` to `jane` and `ken` respectively, using RoleBinding. A RoleBinding referring to 
a ClusterRole only grants access to resources inside the RoleBinding's namespace.

- `kubectl auth can-i --list --as=system:serviceaccount:dev:jane -n dev`
- `kubectl auth can-i create deployments --as=system:serviceaccount:dev:jane --all-namespaces`
- `kubectl auth can-i create deployments --as=system:serviceaccount:dev:jane -n dev`
- `kubectl auth can-i --list --as=system:serviceaccount:dev:ken -n dev`
- `kubectl auth can-i list pods --as=system:serviceaccount:dev:ken -n default`
- `kubectl auth can-i list pods --as=system:serviceaccount:dev:ken -n dev`

[1]: https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-can-i-em

## HW 4. Kubernetes Networks

*TODO:* All tasks marked with :star2:

### Working with test web application

- Added readiness/liveness probes to a Pod
- Created Deployment object from `kubernetes-intro/web-pody.yam`
- Added services of `ClusterIP` type to the cluster
- Enabled IPVS load balancing mode in the cluster

### Accessing application from outside cluster

- Set up MetalLB in Layer2 mode
- Added `LoadBalancer` service
- Set up `Ingress` controller and `ingres-nginx` proxy
- Created `Ingress` rules

## HW 5. Kubernetes Volumes, Storages, StatefulSet

- Deployed `StatefulSet` with MinIO application as local S3 storage
- Created headless service for the app
- Installed `mc` CLI tool for MinIO and managed resources in the storage using this tool
- :star: Added `Secret` object to store MinIO access and secret keys and configured `StatefulSet` to use data from `Secret`
