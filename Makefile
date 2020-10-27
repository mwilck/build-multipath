.PHONY:	*.img

%.img:	%
	cd $<; docker build -t build-multipath-$< .
