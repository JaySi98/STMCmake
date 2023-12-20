#!/bin/sh

bin=$1
address=$2

echo "bin: " $bin
echo "address: " $address

st-flash write $bin $address