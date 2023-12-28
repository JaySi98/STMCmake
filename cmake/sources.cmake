# changes regarding MCU
set(MCU_FAMILY )
set(MCU_MODEL )
set(CPU_PARAMETERS
    -mcpu=cortex-m4
    -mthumb
    -mfpu=fpv4-sp-d16
    -mfloat-abi=hard
)

set(STARTUP_SCRIPT      ${CMAKE_CURRENT_SOURCE_DIR}/cubeMX/Startup/)
set(MCU_LINKER_SCRIPT   ${CMAKE_CURRENT_SOURCE_DIR}/cubeMX/Startup/) 

set(HEADERS
)

set(SOURCES

)

set(STM32CUBEMX_INCLUDE_DIRECTORIES
    ${CMAKE_CURRENT_SOURCE_DIR}/cubeMX/${MCU_FAMILY}_HAL_Driver/Inc
    ${CMAKE_CURRENT_SOURCE_DIR}/cubeMX/${MCU_FAMILY}_HAL_Driver/Inc/Legacy
    ${CMAKE_CURRENT_SOURCE_DIR}/cubeMX/CMSIS/Device/ST/${MCU_FAMILY}/Include
    ${CMAKE_CURRENT_SOURCE_DIR}/cubeMX/CMSIS/Include
)


set(STM32CUBEMX_SOURCES
)
