# build-multipath - helpers for multipath-tools CI

Scripts and helpers for building multipath-tools and running the CI.
Work in progress.

## License

Copyright (c) 2021 Martin Wilck, SUSE LLC

All files in this project are licensed under the [GNU General Public License
v2.0](COPYING), or any later version. **THE CODE IS PROVIDED WITHOUT WARRANTY OF ANY
KIND**. Refer to the license text for details.

## Purpose

### Dockerfile generation

Generate Dockerfiles for creating build environments for compiling
multipath-tools. The Dockerfiles are generated with **m4**. Currently
supported distributions:

  - Alpine
  - Arch
  - Centos (7, 8)
  - Debian (jessie, buster, bullseye, sid)
  - Fedora
  - openSUSE Leap, Tumbleweed, SUSE Linux Enterprise Server
  - Ubuntu 
   
These distributions are supported for multiple architectures.
For Debian, cross-compilation environments are supported too.

#### Using m4

The m4 command line for creating a Dockerfile looks as follows:

    m4 -I m4 -D DISTRO=$dist header.m4 dockerfile.m4

The `DISTRO` argument has the format `$distribution[-$release[-$tag]]`.
The "release" is a variant of the distribution and the "tag" is the docker
registry tag to be used to pull the base image. The conventions vary between
distributions, but the code has helpful defaults. Valid `DISTRO` values are e.g.:

 - `alpine`, `arch`
 - `debian-buster`, `debian-sid`
 - `centos-8`
 - `ubuntu-focal`
 - `opensuse-leap-15.3` (note specific tag), `opensuse-leap`,
   `opensuse-tumbleweed`
 - `sles-15`, `sles-15-15.4`, `sles-12`
 - `fedora-rawhide`, `fedora-36`
 - `debian_cross-bullseye` (this is debian for cross-compilation)

To create a Dockerfile for the runtime environment, use `runnerfile.m4`:

    m4 -I m4 -D DISTRO=debian-bullseye header.m4 runnerfile.m4

Optionally, you can also set `-D PACKAGE=multipath`. This might matter in the
future if additional packages besides multipath-tools are supported. Currently
it defaults to `multipath`.

For SLES, the created dockerfiles use **secrets** that have to be passed on
the docker command line. This is necessary for building the containers
locally. `sles` and `opensuse-leap` builds support an option argument `-D TYPE=obs`
which creates a Dockerfile suitable for building in the OpenSUSE Build Service
(OBS), which will omit the secrets (not necessary on OBS) and will add
additional labels and meta data that OBS requires
(see [Building derived containers](https://en.opensuse.org/Building_derived_containers)).

Additional packages can be included in the build container using `-DADD_PKGS=$package`.

### Additional files

For some environments, additional files are required to build the container.
These are stored under subdirectories of the name of the respective
distribution (e.g. `centos-7`) and must be copied or linked into the same
directory where the Dockerfile was stored before building the container.

### Container generation

Containers are generated from the Dockerfiles created above using GitHub
workflows. The built packages are available from
[ghcr.io](https://github.com/mwilck?tab=packages&repo_name=build-multipath).

 - `multipath-build-$DISTRIBUTION[-$RELEASE]`: Containers for building and
   running the unit tests.
 - `multipath-cross-debian_cross-$RELEASE-$ARCH`: Cross-compilation
   environment. For non-native architectures, cross compilation is much
   faster than running in an emulator environment.
 - `multipath-run-debian-$RELEASE`: Runtime environment to test the
   cross-compiled binaries.
   
The build and cross-build containers expect the multipath-tools source
directory to be mounted under `/build`. They use **make** as entrypoint. To
compile multipath-tools and run the unit tests, run e.g.

    docker run --platform linux/arm64 -it --rm -v $PWD:/build \
	    ghcr.io/mwilck/multipath-build-centos-8 -j test

(Note that for running non-native containers, you'll have to install the
qemu-user package on your distribution. See e.g. [qemu-user-static](https://github.com/multiarch/qemu-user-static)).

To use cross compilation:

    docker run -it --rm -v $PWD:/build \
	    ghcr.io/mwilck/multipath-cross-debian_cross-sid-s390x -j test-progs
    docker run --platform linux/s390x -it --rm -v $PWD:/build \
	    ghrc.io/mwilck/multipath-run-debian-sid test

Note that the `test-progs` target is used for the build step.

# Old content (deprecated)

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
