#!/bin/sh

source_dir=$1
drivers_dir="cubeMX"

if [ -d "$source_dir/Core" ] && [ -d "$source_dir/Drivers" ]; then
    # copy Core files to inc/ and src/
    cp -r $(find "$source_dir/Core/Inc" -type f) "include"
    cp -r $(find "$source_dir/Core/Src" -type f) "src" 

    # create cubeMX directory and copy files from Drivers
    if [ -d $drivers_dir ]; then
        rm -rf $drivers_dir
    fi
    mkdir $drivers_dir

    # copy startup files
    mkdir "$drivers_dir/Startup"
    s_files="$source_dir"/*.s
    ld_files="$source_dir"/*.ld

    # Check if files exist before attempting to copy
    if [ -n "$(echo $s_files)" ]; then
        cp $s_files "$drivers_dir/Startup/"
    fi

    if [ -n "$(echo $ld_files)" ]; then
        cp $ld_files "$drivers_dir/Startup/"
    fi

    # copy CMSIS driver
    cp -r "$source_dir/Drivers/CMSIS" "$drivers_dir/CMSIS"

    # copy HAL driver
    cp -r "$source_dir/Drivers/"*_HAL_Driver "$drivers_dir/HAL_Driver"


    # Parse $source_dir/Makefile
    

else
    echo $source_dir " is not a cubeMX project"
fi