#!/bin/sh

source=$1
build=$2
type=$3

echo "source: " $source
echo "build: " $build
echo "type: " $type

cmake -S $source -B $build \
    -DCMAKE_BUILD_TYPE=$type \
    -DCMAKE_TOOLCHAIN_FILE=cmake/gcc-arm-none-eabi.cmake \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=1
