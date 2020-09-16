# Testing with Kubernetes

## Getting started

```shell
$ kubectl create namespace shmwrapper
$ kubectl -n shmwrapper apply -f deployment.yaml
$ kubectl -n shmwrapper get pods
NAME                          READY   STATUS    RESTARTS   AGE
shmwrapper-859c66f785-v59pz   1/1     Running   0          5s
```

### Check the writer container

```shell
$ kubectl -n shmwrapper logs shmwrapper-859c66f785-v59pz -c shmwrapper-writer
```

Expected end of output:

```
./writer foo bar
```

### Check the reader container 

```shell
$ kubectl -n shmwrapper logs shmwrapper-859c66f785-v59pz -c shmwrapper-reader
```

Expected end of output:

```
./reader foo
bar
./clear foo
```

## Cleaning

```
$ kubectl -n shmwrapper delete deployment shmwrapper
$ kubectl delete namespace shmwrapper
```
