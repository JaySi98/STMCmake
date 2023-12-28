#!/bin/sh

source_dir=$1

makefile=$source_dir/Makefile
drivers_dir="cubeMX"
src_dir="src"
include_dir="include"
sources_file="cmake/sources.cmake"

if [ -d "$source_dir/Core" ] && [ -d "$source_dir/Drivers" ]; then

    # check if source directory contains Makefile
    if [ -n "$(echo $makefile)" ]; then
        
        # # create cubeMX directory
        if [ -d $drivers_dir ]; then
            rm -rf $drivers_dir
        fi
            mkdir $drivers_dir

        # clear cmake/sources.cmake
        > "$sources_file"


        # ======= parse Makefile ======= 
        # set MCU_FAMILY inside cmake/sources.cmake
        hal_driver_line=$(grep -E '_HAL_Driver/Inc ' "$makefile" | grep -oE '\w+_HAL_Driver/Inc ')
        if [ -n "$hal_driver_line" ]; then
            MCU_FAMILY=$(echo "$hal_driver_line" | cut -d'_' -f1)
            echo "MCU_FAMILY: $MCU_FAMILY"
            echo "set(MCU_FAMILY $MCU_FAMILY)" >> "$sources_file"
        else
            echo "MCU_FAMILY not found in the Makefile."
        fi
        # set MCU_MODEL inside cmake/sources.cmake
        model_line=$(grep -E '\-DSTM32\w+' "$makefile")
        if [ -n "$model_line" ]; then
            MCU_MODEL=$(echo "$model_line" | sed -E 's/\-D//;s/[^[:print:]]*$//')
            echo "MCU_MODEL: $MCU_MODEL"
            echo "set(MCU_MODEL $MCU_MODEL)" >> "$sources_file"
        else
            echo "MCU_MODEL not found in the Makefile."
        fi
        # set CPU_PARAMETERS inside cmake/sources.cmake
        # TODO: make it parse makefile instead of raw strings
        echo "" >> "$sources_file"  # Add a newline for separation
        echo "set(CPU_PARAMETERS" >> "$sources_file"
        echo "  -mcpu=cortex-m4" >> "$sources_file"
        echo "  -mthumb" >> "$sources_file"
        echo "  -mfpu=fpv4-sp-d16" >> "$sources_file"
        echo "  -mfloat-abi=hard" >> "$sources_file"
        echo ")" >> "$sources_file"
        
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

    # Add *.h files to sources.cmake
    # TODO finish it for unit tests
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



    #  ======= copy Drivers/ files to cubeMX =======
    # copy CMSIS driver
    cp -r "$source_dir/Drivers/CMSIS" "$drivers_dir/CMSIS"
    # copy HAL driver
    cp -r "$source_dir/Drivers/"*_HAL_Driver "$drivers_dir/HAL_Driver"

    # add cubeMX includes to cmake/sources.cmake
    # this is fine, beacuse it will always look like this
    echo "" >> "$sources_file"  # Add a newline for separation
    echo "set(STM32CUBEMX_INCLUDE_DIRECTORIES" >> "$sources_file"
    echo "  "'${CMAKE_CURRENT_SOURCE_DIR}'"/cubeMX/HAL_Driver/Inc" >> "$sources_file"
    echo "  "'${CMAKE_CURRENT_SOURCE_DIR}'"/cubeMX/HAL_Driver/Inc/Legacy" >> "$sources_file"
    echo "  "'${CMAKE_CURRENT_SOURCE_DIR}'"/cubeMX/CMSIS/Device/ST/"'${MCU_FAMILY}'"/Include" >> "$sources_file"
    echo "  "'${CMAKE_CURRENT_SOURCE_DIR}'"/cubeMX/CMSIS/Include" >> "$sources_file"
    echo ")" >> "$sources_file"

    # add cubeMX source files to cmake/sources.cmake
    cubemx_sources="$drivers_dir"/HAL_Driver/Src/*.c
    if ls $cubemx_sources 1> /dev/null 2>&1; then
        echo "" >> "$sources_file"  # Add a newline for separation
        echo "set(STM32CUBEMX_SOURCES" >> "$sources_file"
        for file in $cubemx_sources; do
            echo "    $file" >> "$sources_file"
        done
        echo ")" >> "$sources_file"
    fi

else
    echo $source_dir " is not a cubeMX project"
fi