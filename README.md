# ModernCppTemplate 

### About 
This project is an attempt to create template for C/C++ projects using modern cmake. It's designed to suit my personal requirements, but it might be useful for other developers too. 

## Requirements 
In order to be able to work with this template, you will need: 

* CMake - version 3.15 and above 

* GCC Compiler 

* arm-none-eabi-gcc compiler
    https://askubuntu.com/questions/1243252/how-to-install-arm-none-eabi-gdb-on-ubuntu-20-04-lts-focal-fossa
    https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads
    https://askubuntu.com/questions/1031103/how-can-i-install-gdb-arm-none-eabi-on-ubuntu-18-04-bionic-beaver

* stlink-tools
    sudo apt install stlink-tools

* minicom for uart comunnication
    sudo apt-get install minicom

## Getting Started 
1. Change project name in CmakeLists.txt
2. If used on different MCU: change all files inside cubeMX folder by files and add appropiate changes inside cmake/sources.cmake
3. Add new header and source files to cmake/sources.cmake
4. Compile, build and run

## Commands 
how to: 

* upload to board
    st-flash write build/<project name>.bin 0x8000000

* probe board
    st-info --probe

* read binary from board
    st-flash read dummy.bin 0 0xFFFF

* listen to uart
    sudo minicom -b <baud rate> -o -D /dev/<device>(ttyACM0)