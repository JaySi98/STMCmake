#!/bin/sh

source_dir=$1

drivers_dir="cubeMX"
src_dir="src"
include_dir="include"
sources_file="cmake/sources.cmake"

if [ -d "$source_dir/Core" ] && [ -d "$source_dir/Drivers" ]; then

    # check if source directory contains Makefile
    if [ -n "$(echo $source_dir/Makfile)" ]; then
        
        # create cubeMX directory
        if [ -d $drivers_dir ]; then
            rm -rf $drivers_dir
        fi
            mkdir $drivers_dir

        # clear cmake/sources.cmake
        > "$sources_file"

        # parse Makefile

    else
        echo $source_dir " is missing Makefile"
        echo "cmake/sources.cmake needs to be updated manually"
        echo "cmake/gcc-arm-none-eabi.cmake needs to be updated manually"
        return 1
    fi




    # ======= copy startup files =======
    mkdir "$drivers_dir/Startup"
    s_files="$source_dir"/*.s
    ld_files="$source_dir"/*.ld

    # Check if files exist before attempting to copy
    if [ -n "$(echo $s_files)" ]; then
        cp $s_files "$drivers_dir/Startup/"

        # add file to cmake/sources.cmake
        s_files="$drivers_dir/Startup/"*.s
        echo "" >> "$sources_file"  # Add a newline for separation
        echo "set(STARTUP_SCRIPT" >> "$sources_file"
        for s_file in $s_files; do
            echo "  "'${CMAKE_CURRENT_SOURCE_DIR}'"/$s_file" >> "$sources_file"
        done
        echo ")" >> "$sources_file"
    fi

    if [ -n "$(echo $ld_files)" ]; then
        cp $ld_files "$drivers_dir/Startup/"

        # add files to cmake/sources.cmake
        ld_files="$drivers_dir/Startup/"*.ld
        echo "set(MCU_LINKER_SCRIPT" >> "$sources_file"
        for ld_file in $ld_files; do
            echo "  "'${CMAKE_CURRENT_SOURCE_DIR}'"/$ld_file" >> "$sources_file"
        done
        echo ")" >> "$sources_file"
    fi




    #  ======= copy Core/ files to inc/ and src/ =======
    cp -r $(find "$source_dir/Core/Inc" -type f) "$include_dir"
    cp -r $(find "$source_dir/Core/Src" -type f) "$src_dir"

    # add all files from src/ and include/ to cmake/sources.cmake
    src_files="$src_dir"/*.c
    include_files="$include_dir"/*.h

    # # Add *.h files to sources.cmake
    # if ls $include_files 1> /dev/null 2>&1; then
    #     echo "set(HEADERS" >> "$sources_file"
    #     for file in $include_files; do
    #         echo "    $file" >> "$sources_file"
    #     done
    #     echo ")" >> "$sources_file"
    # fi

    # Add *.c files to sources.cmake
    if ls $src_files 1> /dev/null 2>&1; then
        echo "" >> "$sources_file"  # Add a newline for separation
        echo "set(SOURCES" >> "$sources_file"
        for file in $src_files; do
            echo "    $file" >> "$sources_file"
        done
        echo ")" >> "$sources_file"
    fi




    # copy CMSIS driver
    cp -r "$source_dir/Drivers/CMSIS" "$drivers_dir/CMSIS"

    # copy HAL driver
    cp -r "$source_dir/Drivers/"*_HAL_Driver "$drivers_dir/HAL_Driver"

else
    echo $source_dir " is not a cubeMX project"
fi