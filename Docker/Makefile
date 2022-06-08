# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

# Set these to the multipath-tools source directory
# and to the target (build container aka subdir) to use
# The values will be remembered in the file "target"

ifneq ($(wildcard target),)
MPATH_DIR := $(shell cut -d: -f1 target)
TARGET := $(shell cut -d: -f2 target)
ARCH := $(shell cut -d: -f3 target)
endif

DOCKER := $(shell (which docker || which podman || echo NO-DOCKER) | sed 's,.*/,,')
EXTRAVERSION := $(shell rev=$$(GIT_DIR=$(MPATH_DIR)/.git git rev-parse --short=7 HEAD 2>/dev/null); echo $${rev:+-g$$rev})
BUILDFLAGS += EXTRAVERSION=$(EXTRAVERSION) $(if $(patsubst centos7,,$(TARGET)),-j4 -O,-j4)
CNTDIR := /build


ifeq ($(DOCKER),docker)
DOCKER_OPTS := -u $$UID
BUILD_OPTS := --progress=plain
else
ifeq ($(DOCKER),podman)
DOCKER_OPTS := --userns=keep-id
endif
endif
DOCKER_OPTS += --name multipath-build-$(shell basename $(TARGET))$(_ARCH)
ifneq ($(ARCH),)
# we don't need to add this to DOCKER_OPTS
BUILD_OPTS += --arch $(ARCH)
endif

# Don't change these
CURRENT := $(MPATH_DIR):$(TARGET):$(ARCH)
_ARCH := $(if $(ARCH),-$(ARCH),)
SUFFIX := $(TARGET)$(_ARCH)
IMAGE-ID := image-id$(_ARCH)
RUNNER-ID := runner-id$(_ARCH)
# IS_LOCAL is non-empty if $TARGET contains either docker.io/ or registry.
IS_LOCAL = $(patsubst docker.io/%,,$(patsubst registry.%,,$(TARGET)))
IMAGE = $(if $(IS_LOCAL),multipath-build-$(SUFFIX),$(TARGET))
RUNNER = $(if $(IS_LOCAL),multipath-run-$(SUFFIX),$(TARGET))

.PHONY:	img build clean test install mpath_dir purge build-clean target run-test check-images

default:	test

mpath_dir:
	@echo checking for valid MPATH_DIR
	[ -n "$(MPATH_DIR)" ] && [ -d "$(MPATH_DIR)" ]

purge:	clean
	$(DOCKER) image rm $(IMAGE)
	rm -f $(TARGET)/$(IMAGE-ID)

target:	mpath_dir
ifneq ($(IS_LOCAL),)
	@echo checking for valid TARGET
	@[ -n "$(TARGET)" ] && [ -d $(TARGET) ]
endif
	@if [ -f $@ ] && [ "$$(cat $@)" != $(CURRENT) ]; then \
		echo updating target=$(TARGET); \
		:>need_clean; \
		echo -n $(CURRENT) >$@; \
	fi
	@echo Current TARGET is $(CURRENT)
	@sleep 1

clean:	m-clean

img-clean:	clean
	rm -f target

#
# This is where the heavy lifting (image build) happens
# 
$(TARGET)/$(IMAGE-ID): $(TARGET)/Dockerfile
ifneq ($(IS_LOCAL),)
ifeq ($(wildcard $(TARGET)/SUSEConnect),)
	cd $(TARGET) && $(DOCKER) build  $(BUILD_OPTS) -t $(IMAGE) .
else
# Special case for SLE - normal docker/podman build doesn't work, because
# SLE secrets need to be pulled in.
# We need buildkit for docker or we must use a buildah shell script
ifeq ($(DOCKER),docker)
	cd $(TARGET) && \
		DOCKER_BUILDKIT=1 $(DOCKER) build $(BUILD_OPTS) -t $(IMAGE) \
			--secret id=SUSEConnect,src=SUSEConnect \
			--secret id=SCCcredentials,src=SCCcredentials
else
ifeq ($(DOCKER),podman)
	cd $(TARGET) && \
		BUILD_OPTS=$(BUILD_OPTS) ./buildah.sh $(IMAGE)
endif
endif
endif
	$(DOCKER) image inspect --format '{{.ID}}' $(IMAGE) >$@
endif

check-images: target
ifneq ($(IS_LOCAL),)
	# verify that the image is available
	$(DOCKER) image inspect --format '{{ .RepoTags }}' $(file <$(TARGET)/$(IMAGE-ID)) || rm -rf $(TARGET)/$(IMAGE-ID)
ifneq ($(wildcard $(TARGET)/Runner/Dockerfile),)
	$(DOCKER) image inspect --format '{{ .RepoTags }}' $(TARGET)/$(RUNNER-ID) || rm -rf $(TARGET)/$(IMAGE-ID)
endif
endif

ifeq ($(IS_LOCAL),)
img:
	$(DOCKER) inspect --format '{{ .RepoTags }}' $(TARGET) || \
	$(DOCKER) pull $(TARGET)
else
img:	check-images $(TARGET)/$(IMAGE-ID)
endif

build:	target img
	if [ -e need_clean ]; then make clean; rm -f need_clean; fi
	$(DOCKER) run --rm $(DOCKER_OPTS) -v $(MPATH_DIR):$(CNTDIR) \
		$(IMAGE) $(BUILDFLAGS)

test.clean:	build
	$(DOCKER) run --rm $(DOCKER_OPTS) -v $(MPATH_DIR):$(CNTDIR) \
		$(IMAGE) $(BUILDFLAGS) tests.clean test

test-progs:	build
	$(DOCKER) run --rm $(DOCKER_OPTS) -v $(MPATH_DIR):$(CNTDIR) \
		$(IMAGE) $(BUILDFLAGS) $@

$(TARGET)/$(RUNNER-ID):	$(TARGET)/Runner/Dockerfile
	$(DOCKER) build $(BUILD_OPTS) --tag $(RUNNER) -f $^
	$(DOCKER) image inspect --format '{{.ID}}' $(RUNNER) >$@

test:	test-progs $(if $(wildcard $(TARGET)/Runner/Dockerfile), $(TARGET)/$(RUNNER-ID))
ifeq ($(wildcard $(TARGET)/Runner/Dockerfile),)
	$(DOCKER) run --rm $(DOCKER_OPTS) -v $(MPATH_DIR):$(CNTDIR) \
		$(IMAGE) $(BUILDFLAGS) test
else
	$(DOCKER) run --rm $(DOCKER_OPTS) -v $(MPATH_DIR):$(CNTDIR) \
		$(RUNNER)
endif

install:	build
	[ -n "$(DESTDIR)" ]
	mkdir -p $(DESTDIR)
	$(DOCKER) run --rm $(DOCKER_OPTS) -v $(MPATH_DIR):$(CNTDIR) -v $(DESTDIR):$(DESTDIR) \
		$(IMAGE) $(BUILDFLAGS) DESTDIR=$(DESTDIR) install

shell:	img
	$(DOCKER) run -it --rm $(DOCKER_OPTS) -v $(MPATH_DIR):$(CNTDIR) --entrypoint=/bin/sh $(IMAGE)

# This allows running any target with make; type "make m-clean" for running "make clean"
# in the container
m-%:	img
	$(DOCKER) run -it --rm $(DOCKER_OPTS) -v $(MPATH_DIR):$(CNTDIR) $(IMAGE) $(@:m-%=%)
