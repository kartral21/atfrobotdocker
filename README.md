# ATF Proof of concept - Containerize robot with docker and run on kubernetes cluster

## Prerequisites
You must install and configure the following tools before moving forward
* docker
* minikube
* kubectl
* helm
* Kubernetes cluster must be running

## Usage

### Docker

Use docker to buid & push to docker hub

```bash
docker build -t <your username>/<appname> .

docker login                           // To login into dockerhub

docker push  <your username>/<appname> // push image to your repo
```

### Helm

Use helm to package & deploy to Kubernetes cluster 

```bash
helm package atfrobotdocker

helm install atfrobotdocker ./atfrobotdocker-0.1.0.tgz
```
### Kubernetes

Verify the Pod in Kubernetes cluster 

```bash
karthiks-mbp:atfnodejsdocker karthikrallapalli$ kubectl get pods
NAME                               READY   STATUS    RESTARTS   AGE
atfnodejsdocker-5b5fc7dd65-n7h4g   1/1     Running   0          69m
atfrobotdocker-6cc6cd4db4-72x6x    1/1     Running   0          89m
```

### Robot

Verify Robot is running in the container

```bash
kubectl exec <your_pod_name> -it -- /bin/sh
# robot --version
Robot Framework 3.2.1 (Python 3.8.5 on linux)
```

Copy the test.robot file to your container & run the tests. Your results should look like 

```bash
# robot test.robot
==============================================================================
Test                                                                          
==============================================================================
Test Robot Framework Logging                                          ..Display to console while Robot is running
Test Robot Framework Logging                                          | PASS |
------------------------------------------------------------------------------
Test                                                                  | PASS |
1 critical test, 1 passed, 0 failed
1 test total, 1 passed, 0 failed
==============================================================================
Output:  /output.xml
Log:     /log.html
Report:  /report.html
```
