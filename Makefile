# Copyright (c) 2020 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

# Set these to the multipath-tools source directory
# and to the target (build container aka subdir) to use
# The values will be remembered in the file "target"
MPATH_DIR := $(shell [ -f target ] && sed 's/:.*$$//' target)
TARGET := $(shell [ -f target ] && sed 's/^.*://' target)

BUILDFLAGS := -j4 -O
DOCKER := docker
CNTDIR := /build
DOCKER_OPTS := -u $$UID

# Don'c change these
CURRENT = $(MPATH_DIR):$(TARGET)
IMAGE = multipath-build-$(TARGET)

.PHONY:	img build clean test install mpath_dir purge build-clean

default:	test

mpath_dir:
	@echo checking for valid MPATH_DIR
	[ -n "$(MPATH_DIR)" -a -d "$(MPATH_DIR)/libmultipath" ]

purge:	clean
	$(DOCKER) image rm $(IMAGE)

target:	mpath_dir $(TARGET)
	@echo checking for valid TARGET
	[ -n "$(TARGET)" ] && [ -d $(TARGET) ]
	if [ -f $@ ] && [ "$$(cat $@)" != $(CURRENT) ]; then :>need_clean; fi
	echo -n $(CURRENT) >$@

build-clean:
	$(DOCKER) run --rm $(DOCKER_OPTS) -v $(MPATH_DIR):$(CNTDIR) \
		$(IMAGE) $(BUILDFLAGS) clean

clean:	build-clean
	rm -f target

img:	target
	cd $(TARGET) && docker build -t $(IMAGE) .

build:	img
	if [ -e need_clean ]; then make build-clean; rm -f need_clean; fi
	$(DOCKER) run --rm $(DOCKER_OPTS) -v $(MPATH_DIR):$(CNTDIR) \
		$(IMAGE) $(BUILDFLAGS)

test:	build
	$(DOCKER) run --rm $(DOCKER_OPTS) -v $(MPATH_DIR):$(CNTDIR) \
		$(IMAGE) $(BUILDFLAGS) tests.clean test

install:	build
	[ -n "$(DESTDIR)" ]
	mkdir -p $(DESTDIR)
	$(DOCKER) run --rm $(DOCKER_OPTS) -v $(MPATH_DIR):$(CNTDIR) -v $(DESTDIR):$(DESTDIR) \
		$(IMAGE) $(BUILDFLAGS) DESTDIR=$(DESTDIR) install
