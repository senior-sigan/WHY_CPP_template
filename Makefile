all: clean reload compile run

clean:
	rm -rf cmake-build-debug
	mkdir cmake-build-debug

reload:
	cd cmake-build-debug;cmake ..

compile:
	cd cmake-build-debug;make -j4

run:
	cd cmake-build-debug;./game