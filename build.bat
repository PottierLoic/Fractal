cmake -DBUILD_SHARED_LIBS=OFF -G "MinGW Makefiles" -B "./build" . -DFLAGS=%1
@echo off
cd build
make
cd ..
