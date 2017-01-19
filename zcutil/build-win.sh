#!/bin/bash
export HOST=x86_64-w64-mingw32
cd depends
make
cd ..
./augogen.sh
CXX=x86_64-w64-mingw32-g++-posix CC=x86_64-w64-mingw32-gcc-posix CXXFLAGS+="  -fopenmp" CONFIG_SITE=$PWD/depends/x86_64-w64-mingw32/share/config.site ./configure --prefix=/  --with-gnu-ld --enable-static --disable-shared CXX=x86_64-w64-mingw32-g++-posix CC=x86_64-w64-mingw32-gcc-posix --host=x86_64-w64-mingw32
cd src
sed -i 's/-lboost_system-mt /-lboost_system-mt-s /' Makefile
cd ..
CXX=x86_64-w64-mingw32-g++-posix CC=x86_64-w64-mingw32-gcc-posix make
