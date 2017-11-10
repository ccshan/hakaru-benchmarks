.PHONY: setup initSubmodules generateTestCode installRktPkg runtests benchmark


setup: init hakaru rkt input

init:
	git submodule init
	git submodule update

hakaru:
	cd ./hakaru ; stack build && stack install --local-bin-path ../hkbin

test:
	cd ./testcode/hkrkt ; make
	cd ./testcode/hksimp ; make
	cd ./testcode/hssrc ; make

rkt:
	cd ./sham ; raco pkg install --skip-installed
	cd ./hakrit ; raco pkg install --skip-installed

input:
	cd ./input ; make all

clean:
	cd ./hakaru; stack clean
	cd ./input; make clean
	rm ./hkbin/*
	cd ./testcode/hkrkt ; make clean
	cd ./testcode/hksimp ; make clean
	cd ./testcode/hssrc ; make clean

docker:
	cd ./docker; sudo docker build -t hakaru-benchmark .

runtests:
	echo "TODO runtests :P"

benchmark: runtests
	echo "We can't even run yet how do we benchmark??"
