# set this to the multipath-tools source directory
MPATH_DIR :=
BUILDFLAGS := -j4 -O
DOCKER := docker

.PHONY:	*.img *.build *.clean *.test *.install mpath_dir

mpath_dir:
	[ -n "$(MPATH_DIR)" -a -d $(MPATH_DIR)/libmultipath ]

%.img:	%
	cd $<; docker build -t build-multipath-$< .

%.clean:	%.img
	$(DOCKER) run --rm -u $$UID -v $(MPATH_DIR):/tmp/multipath $(@:%.clean=build-multipath-%) clean

%.build:	mpath_dir %.img
	if [ ! -e current_target ] || [ $$(cat current_target) != $(MPATH_DIR):$(@:%.build=%) ]; then \
		$(MAKE) $(@:%.build=%.clean); \
	fi
	@echo -n $(MPATH_DIR):$(@:%.build=%) >current_target
	$(DOCKER) run --rm -u $$UID -v $(MPATH_DIR):/tmp/multipath \
		$(@:%.build=build-multipath-%) $(MAKEFLAGS)

%.test:	%.build
	$(DOCKER) run --rm -u $$UID -v $(MPATH_DIR):/tmp/multipath \
		$(@:%.test=build-multipath-%) $(MAKEFLAGS) tests.clean test

%.install: %.build
	[ -n "$(DESTDIR)" ]
	mkdir -p $(DESTDIR)
	$(DOCKER) run --rm -u $$UID -v $(MPATH_DIR):/tmp/multipath -v $(DESTDIR):$(DESTDIR) \
		$(@:%.install=build-multipath-%) $(MAKEFLAGS) DESTDIR=$(DESTDIR) install

%.purge:
	$(DOCKER) image rm $(@:%.purge=build-multipath-%)
