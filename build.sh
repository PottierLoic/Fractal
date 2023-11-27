#!/bin/bash

cmake -G "Unix Makefiles" -B "./build" . -DFLAGS=$1
cd build
make
cd ..
