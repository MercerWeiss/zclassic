#!/bin/bash
HOST=x86_64-w64-mingw32
CXX=x86_64-w64-mingw32-g++-posix
CC=x86_64-w64-mingw32-gcc-posix
PREFIX="$(pwd)/depends/$HOST"

set -eu -o pipefail

set -x
cd "$(dirname "$(readlink -f "$0")")/.."

cd depends/ && make HOST=$HOST V=1 NO_QT=1 && cd ../
./autogen.sh
CXXFLAGS="-I$PREFIX/include  -fopenmp"  ./configure --prefix="${PREFIX}" --with-gui=no --host="${HOST}" --enable-static --disable-shared
sed -i 's/-lboost_system-mt /-lboost_system-mt-s /' configure
cd src/
CC="${CC}" CXX="${CXX}" make V=1 zcashd.exe zcash-cli.exe
