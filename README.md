# Shared memory simple wrapper

## Description

Use shared memory as a cache with keys and values.

## Getting started

### Build the commands

```shell
$ make all
```

### Put a value in the shared memory

```shell
$ ./writter foo bar
```

## Get a value in the shared memory

```shell
$ ./reader foo
bar
```

## Remove a value in the shared memory

```shell
$ ./clear foo
```
