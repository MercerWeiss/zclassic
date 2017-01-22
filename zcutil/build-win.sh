#!/bin/bash
export PATH=/C/msys64/mingw64/bin:/mingw64/bin:/usr/local/bin:/usr/bin:/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl
HOST=x86_64-pc-mingw64
PREFIX="$(pwd)/depends/$HOST"

set -eu -o pipefail

set -x
cd "$(dirname "$(readlink -f "$0")")/.."

cd depends/ && make HOST=$HOST V=1 NO_QT=1 && cd ../

DBINC="${PREFIX}/include/bdb"
mkdir -p $DBINC
cp ${PREFIX}/include/db*h $DBINC


./autogen.sh
CONFIG_SITE=$PWD/depends/x86_64-pc-mingw64/share/config.site CXXFLAGS+=" -fopenmp -I$PREFIX/include -I/home/djm/mpir" CPPFLAGS="-I$PREFIX/include" LDFLAGS="-L/home/djm/mpir" ./configure --prefix="${PREFIX}" --with-gui=no --host="${HOST}" --enable-static --disable-shared
sed -i 's/-lboost_system-mt /-lboost_system-mt-s /' configure
make V=1
