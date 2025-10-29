#!/usr/bin/env bash

set -e

[ -d KTX-Software ] || git clone https://github.com/KhronosGroup/KTX-Software --depth 1

echo "Building KTX.."
cd KTX-Software
cmake . -B build -DKTX_FEATURE_TOOLS=OFF -DBUILD_SHARED_LIBS=OFF -DKTX_FEATURE_TESTS=OFF -DCMAKE_BUILD_TYPE=Release
if [ $(uname -s) = 'Darwin' ]; then
    make -j$(sysctl -n hw.ncpu) -C build
    LIB_EXT=darwin
else
    make -j$(nproc) -C build
    LIB_EXT=linux
fi
#
cp build/libktx.a ../ktx.$LIB_EXT.a
