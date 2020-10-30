# build-multipath - files for multipath-tools CI

Scripts and helpers for building multipath-tools and running the CI.
Work in progress.

## Docker

Run all commands below in the `Docker` subdirectory.

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
[the multipath-tools repository](https://github.com/openSUSE/multipath-tools).
The directory will be mounted into the container, and will be written to
using comands like `make` and `make clean`.

### make targets

 * test: build and run unit tests. This is the default target.
 * img: build the docker image.
 * build: build multipath-tools.
 * build-clean: run `make clean`.
 * install: run `make install`. `DESTDIR` must be set when invoked.
 * clean: run `make clean`, and forget current settings.
 * purge: remove current image from local docker storage.

### Using containers from a registry

If the `TARGET` name starts with `registry.`, building the container image
will not be attempted. Rather, the given image will be pulled from a registry.
Example:

    TARGET=registry.suse.de/some/project/images/sle-15-sp1/containers/multipath-build

### Using locally built containers

If `TARGET` doesn't start with `registry.`, it must be the name of a
subdirectory of `Docker`, usually a nickname of a distribution, containing
a Dockerfile. The Dockerfile should create an environment suitable for
building `multipath-tools`. See existing Dockerfiles for examples.
The built container image will be called `multipath-build-$TARGET`.

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


