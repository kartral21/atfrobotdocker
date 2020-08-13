# ATF POC - Containerize ROBOT with Docker and run on Kubernetes 

## Prerequisites
You must install and configure the following tools before moving forward
* nodeJS
* nocker
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

Verify the Pod & service in Kubernetes cluster 

```bash
kubectl get pods 
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
