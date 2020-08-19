# ATF Proof of concept - Containerize robot with docker and run on Kubernetes or OpenShift cluster

## Prerequisites
You must install and configure the following tools before moving forward
* docker
* kubectl(Kuberntes cluster) or oc(OpenShift cluster)
* helm
* Kubernetes or OpenShift cluster must be running

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
### Robot running on Kubernetes cluster

Verify the Pod in Kubernetes cluster 

```bash
kubectl get pods
NAME                               READY   STATUS    RESTARTS   AGE
atfnodejsdocker-5b5fc7dd65-n7h4g   1/1     Running   0          69m
atfrobotdocker-6cc6cd4db4-72x6x    1/1     Running   0          89m
```

Copy the robot directory to your container 

```bash
kubectl cp ./robot <your_pod_name>:/tmp 
```

Verify Robot is running in the container

```bash
kubectl exec <your_pod_name> -it -- /bin/sh
# robot --version
Robot Framework 3.2.1 (Python 3.8.5 on linux)
```

 Run the tests. Your results should look like 

```bash
# cd tmp/robot
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
Output:  /tmp/robot/output.xml
Log:     /tmp/robot/log.html
Report:  /tmp/robot/report.html
```

### Robot running on OpenShift cluster

Create project in OpenShift cluster 

```bash
oc new-project atfrobotdocker
```

Verify the Pod in OpenShift cluster 

```bash
oc get pods
NAME                              READY   STATUS    RESTARTS   AGE
atfrobotdocker-6cc6cd4db4-6m7tb   1/1     Running   0          11m
```

Copy the robot directory to your container 

```bash
oc rsync ./robot <your_pod_name>:/tmp
```

Verify Robot is running in the container

```bash
oc exec <your_pod_name> -it -- /bin/sh
# robot --version
Robot Framework 3.2.1 (Python 3.8.5 on linux)
```

 Run the tests. Your results should look like 

```bash
# cd tmp/robot
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
Output:  /tmp/robot/output.xml
Log:     /tmp/robot/log.html
Report:  /tmp/robot/report.html
```
