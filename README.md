# Shared memory simple wrapper

## Description

Use shared memory as a cache with keys and values.

This project aims to check if containers can be able to share IPC's host and if that is natively the case for containers accross the same kubernetes pod.

Spoiler: yes !

## Git repositories

* main repo: https://gitlab.comwork.io/oss/shmwrapper
* github mirror backup: https://github.com/idrissneumann/shmwrapper

## Getting started

### Build the command

```shell
$ make all
```

### Getting help

```shell
$ ./shmwrapper -h
```

### Put a value in the shared memory

```shell
$ ./shmwrapper -w foo bar
```

### Get a value in the shared memory

```shell
$ ./shmwrapper -r foo
bar
```

### Remove a value in the shared memory

```shell
$ ./shmwrapper -c foo
```

## Testing with containers

### Testing with docker-compose

```shell
$ docker-compose up
```

### Testing with kubernetes

See [this md file](./kubernetes/README.md)
