#!/bin/sh

source_dir=$1

echo "source directory: " $source_dir

# && [-d "$source_dir/Drivers"]
if [ -d "$source_dir/Core" ] && [ -d "$source_dir/Drivers" ]; then
    echo "gitowa"
else
    echo $source_dir " is not a cubeMX project"
fi