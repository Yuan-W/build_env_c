# build_env_c
Dockerized Environment for build C projects


### Usage

__Compilation__

`docker build -t <label:version> .`

__Run Container(Start Build)__
`docker run --rm -v "$PWD:/src" -it <label:version> <Make Arguments>`

__Start Interactive Shell__
`docker run --rm -v "$PWD:/src" -it --entrypoint=/bin/bash  <label:version>`