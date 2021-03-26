# build-multipath - helpers for multipath-tools CI

Scripts and helpers for building multipath-tools and running the CI.
Work in progress.

## License

Copyright (c) 2021 Martin Wilck, SUSE LLC

All files in this project are licensed under the [GNU General Public License
v2.0](COPYING), or any later version. **THE CODE IS PROVIDED WITHOUT WARRANTY OF ANY
KIND**. Refer to the license text for details.

## Github workflows

The project contains workflows that build a subset of the containers defined
in this repository and upload them to [docker hub](https://hub.docker.com/u/mwilck).
The containers are named `mwilck/multipath-build-$os-$arch` and
`mwilck/multipath-run-$os-$arch` (see "foreign architectures") below).
They are used by CI workflows on the
[openSUSE multipath-tools repository](https://github.com/mwilck/multipath-tools/actions).

## Containers (docker, podman)

Run all commands below in the `Docker` subdirectory. Both `podman` and
`docker` container runtimes are supported.

Basic usage:

	make MPATH_DIR=/my/multipath-tools/dir TARGET=alpine

This will create the docker image for testing under the given distribution
(here: alpine linux), build multipath-tools from the given directory,
and run the unit tests (only those that don't require block devices, because
they can't be run in containers).

Subsequent `make` invocations can be done without setting `MPATH_DIR` and
`TARGET`; they will be remembered.

`MPATH_DIR` should be a directory containing the `multipath-tools` sources,
such as a checked-out mirror of
[the multipath-tools repository](https://github.com/opensvc/multipath-tools).
The directory will be mounted into the container, and will be written to
using comands like `make` and `make clean`.

### make targets

 * test: build and run unit tests. This is the default target.
 * test-progs: build libraries, commands, and unit tests, but don't run the
   tests.
 * img: build the docker image.
 * build: build multipath-tools.
 * install: run `make install`. `DESTDIR` must be set when invoked.
 * clean: run `make clean`.
 * img-clean: run `make clean`, and forget current settings.
 * purge: remove current image from local docker storage.

Furthermore, every defined "make" target from the multipath-tools Makefile can
be built by prepending it with `m-`; e.g. `make m-tests.clean` runs `make
tests.clean` in the container (this is useful if you want to re-run the
tests).

**Note:** Makefile logic tries to ensure that if `TARGET` is changed, the
complete sources are rebuilt. But sometimes this fails. In this case, running
`make clean; make` usually fixes the issue.

### Environment variables for building

To override build variables like `CC` or `OPTFLAGS` in the container, you have
to set the environment variable `BUILDFLAGS` on the host:

```
make 'BUILFLAGS="CC=clang OPTFLAGS="-O0 -g"'
```

### Using locally built containers

Unless `TARGET` starts with "`registry.`" or "`docker.io`", it must be the name of a
subdirectory of `Docker`, usually a nickname of a distribution, containing
a Dockerfile. The Dockerfile should create an environment suitable for
building `multipath-tools`. See existing Dockerfiles for examples.
The built container image will be called `multipath-build-$TARGET`.

### Using containers from a registry

If the `TARGET` name starts with `registry.` or `docker.io/`, building the container image
will not be attempted. Rather, the given image will be pulled from a registry.
Example:

    TARGET=registry.suse.de/some/project/images/sle-15-sp1/containers/multipath-build
	TARGET=docker.io/mwilck/multipath-build-alpine

Note that multipath build will fail if the downloaded containers don't include all
necessary dependencies.

### Note on SUSE Linux Enterprise (SLE) containers

Building these containers requires a valid SLE subscription. 
If in doubt, check your licensing conditions to figure out if you
are entitled to build and run SLE containers in this way.

Building the images requires features that are only available
in recent docker versions. Before running `make`, set the environment variable
`DOCKER_BUILDKIT=1`, otherwise the image build will fail.
See [the documentation about building SLE containers](https://github.com/SUSE/container-suseconnect).

On a registered SLE host, building the images should just work. In other
environments, valid credentials must be pulled in from elsewhere.
Copy the files `/etc/zypp/credentials.d/SCCcredentials` and `/etc/SUSEConnect` from
a registered SLE system into the respective subdirectory before building
the image. The registered system must have the required additional
modules enabled (see the distribution's Dockerfile).

## Foreign architectures (ppc64le, aarch64, s390x)

The containers in this repository are designed to be run on Intel-compatible
platforms (`x86_64` architecture). For some distributions, other architectures
are supported as well. In this case, the unit tests are run in a special
container called `multipath-run-$os-$arch`. This container is built from
another Dockerfile stored under `$(TARGET)/Runner`. The container includes
an emulator (usually `qemu-user-static` for emulating the target architecture), and
is otherwise a native environment for the target architecture including the
run-time dependencies for multipath-tools. Currently, containers built
this way are not used for the build process itself, only for running the
tests. The build containers use cross-compilation instead, utilizig Debian's
multiarch cross-compilation features.
