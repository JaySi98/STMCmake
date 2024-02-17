cmake_minimum_required(VERSION 3.15 FATAL_ERROR)

project(
    "STMCmake" 
    VERSION 0.1.0 
)

# Prevention from building in the source directory
if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(FATAL_ERROR "In-source builds not allowed. Please make a build directory and run CMake from there.\n")
endif()

# ===========================
# Project options
# ===========================
include(cmake/sources.cmake)
include(cmake/functions.cmake)

message(STATUS "Started CMake for ${PROJECT_NAME} v${PROJECT_VERSION}\n")

# Set the compiler options
enable_language(C CXX ASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)

# ===========================
# adding exec/lib
# ===========================
add_executable(${PROJECT_NAME}  
    ${STM32CUBEMX_SOURCES}
    ${SOURCES}
    ${STARTUP_SCRIPT}
)

# ===========================
# Project properties
# ===========================
target_compile_definitions(${PROJECT_NAME} PRIVATE
    ${MCU_MODEL}
    USE_HAL_DRIVER
)

target_include_directories(
    ${PROJECT_NAME}
    PUBLIC
    $<INSTALL_INTERFACE:include>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${STM32CUBEMX_INCLUDE_DIRECTORIES}
)

target_compile_options(${PROJECT_NAME} PRIVATE
    ${CPU_PARAMETERS}
    $<$<CONFIG:Debug>:-Og -g3 -ggdb>
    $<$<CONFIG:Release>:-Og -g0>
)

target_link_options(${PROJECT_NAME} PRIVATE
    -T${MCU_LINKER_SCRIPT}
    ${CPU_PARAMETERS}
    -Wl,-Map=${CMAKE_PROJECT_NAME}.map
    --specs=nosys.specs
    -Wl,--start-group
    -lc
    -lm
    -lstdc++
    -Wl,--end-group
    -Wl,--print-memory-usage
)

# Add linker flags for the math library (-lm) and the standard C library (-lc)
target_link_libraries(${PROJECT_NAME} m c)

message(STATUS "Added all header and source files.\n")

# ===========================
# Project standard and warnings
# ===========================
set_project_warnings(${PROJECT_NAME})
message(STATUS "Applied compiler warnings. Using standard C${CMAKE_C_STANDARD}.\n")

# ===========================
# Custom commands 
# ===========================
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${PROJECT_NAME}>)

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O ihex $<TARGET_FILE:${PROJECT_NAME}>
    ${PROJECT_NAME}.hex
    COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${PROJECT_NAME}>
    ${PROJECT_NAME}.bin)
