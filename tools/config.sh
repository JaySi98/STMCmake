#!/bin/sh

cmake -S . -B build \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_TOOLCHAIN_FILE=cmake/gcc-arm-none-eabi.cmake