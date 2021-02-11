# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

# Set these to the multipath-tools source directory
# and to the target (build container aka subdir) to use
# The values will be remembered in the file "target"
MPATH_DIR := $(shell [ -f target ] && sed 's/:.*$$//' target)
TARGET := $(shell [ -f target ] && sed 's/^.*://' target)

BUILDFLAGS += $(if $(patsubst centos7,,$(TARGET)),-j4 -O,-j4)
DOCKER := docker
CNTDIR := /build
ifeq ($(DOCKER),docker)
DOCKER_OPTS := -u $$UID
BUILD_OPTS := --progress=plain
else
ifeq ($(DOCKER),podman)
DOCKER_OPTS := --userns=keep-id
endif
endif
DOCKER_OPTS += --name multipath-build-$(TARGET)

# Don'c change these
CURRENT = $(MPATH_DIR):$(TARGET)
IS_LOCAL = $(patsubst registry.%,,$(TARGET))
IMAGE = $(if $(IS_LOCAL),multipath-build-$(TARGET),$(TARGET))

.PHONY:	img build clean test install mpath_dir purge build-clean

default:	test

mpath_dir:
	@echo checking for valid MPATH_DIR
	[ -n "$(MPATH_DIR)" ]

purge:	clean
	$(DOCKER) image rm $(IMAGE)
	rm $(TARGET)/image-id

target:	mpath_dir
ifneq ($(IS_LOCAL),)
	@echo checking for valid TARGET
	[ -n "$(TARGET)" ] && [ -d $(TARGET) ]
endif
	if [ -f $@ ] && [ "$$(cat $@)" != $(CURRENT) ]; then :>need_clean; fi
	echo -n $(CURRENT) >$@

clean: img
	$(DOCKER) run --rm $(DOCKER_OPTS) -v $(MPATH_DIR):$(CNTDIR) \
		$(IMAGE) $(BUILDFLAGS) clean

img-clean:	build-clean
	rm -f target

$(TARGET)/image-id:
ifeq ($(IS_LOCAL),)
	$(DOCKER) pull $(TARGET)
else
ifeq ($(wildcard $(TARGET)/SUSEConnect),)
	cd $(TARGET) && $(DOCKER) build -t $(IMAGE) .
else
ifeq ($(DOCKER),docker)
	cd $(TARGET) && \
		DOCKER_BUILDKIT=1 $(DOCKER) build -t $(IMAGE) \
			--secret id=SUSEConnect,src=SUSEConnect \
			--secret id=SCCcredentials,src=SCCcredentials
else
ifeq ($(DOCKER),podman)
	cd $(TARGET) && \
		./buildah.sh $(IMAGE)
endif
endif
endif
	$(DOCKER) image inspect --format '{{.ID}}' $(IMAGE) >$@
endif

img:	$(TARGET)/image-id

build:	img
	if [ -e need_clean ]; then make build-clean; rm -f need_clean; fi
	$(DOCKER) run --rm $(DOCKER_OPTS) -v $(MPATH_DIR):$(CNTDIR) \
		$(IMAGE) $(BUILDFLAGS)

test.clean:	build
	$(DOCKER) run --rm $(DOCKER_OPTS) -v $(MPATH_DIR):$(CNTDIR) \
		$(IMAGE) $(BUILDFLAGS) tests.clean test
test:	build
	$(DOCKER) run --rm $(DOCKER_OPTS) -v $(MPATH_DIR):$(CNTDIR) \
		$(IMAGE) $(BUILDFLAGS) test

install:	build
	[ -n "$(DESTDIR)" ]
	mkdir -p $(DESTDIR)
	$(DOCKER) run --rm $(DOCKER_OPTS) -v $(MPATH_DIR):$(CNTDIR) -v $(DESTDIR):$(DESTDIR) \
		$(IMAGE) $(BUILDFLAGS) DESTDIR=$(DESTDIR) install

shell:	img
	$(DOCKER) run -it --rm $(DOCKER_OPTS) -v $(MPATH_DIR):$(CNTDIR) --entrypoint=/bin/sh $(IMAGE)
