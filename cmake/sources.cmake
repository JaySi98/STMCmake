# changes regarding MCU
set(MCU_FAMILY STM32F4xx)
set(MCU_MODEL STM32F411xE)
set(CPU_PARAMETERS
    -mcpu=cortex-m4
    -mthumb
    -mfpu=fpv4-sp-d16
    -mfloat-abi=hard
)

set(HEADERS
)

set(SOURCES
    src/main.c
)

set(CUBEMX_INCLUDE_DIRECTORIES
    ${CMAKE_CURRENT_SOURCE_DIR}/cubeMX/Core/Inc
    ${CMAKE_CURRENT_SOURCE_DIR}/cubeMX/Drivers/${MCU_FAMILY}_HAL_Driver/Inc
    ${CMAKE_CURRENT_SOURCE_DIR}/cubeMX/Drivers/${MCU_FAMILY}_HAL_Driver/Inc/Legacy
    ${CMAKE_CURRENT_SOURCE_DIR}/cubeMX/Drivers/CMSIS/Device/ST/${MCU_FAMILY}/Include
    ${CMAKE_CURRENT_SOURCE_DIR}/cubeMX/Drivers/CMSIS/Include
)

set(STARTUP_SCRIPT      ${CMAKE_CURRENT_SOURCE_DIR}/cubeMX/Core/Startup/startup_stm32f411retx.s)
set(MCU_LINKER_SCRIPT   ${CMAKE_CURRENT_SOURCE_DIR}/cubeMX/Core/Startup/STM32F411RETX_FLASH.ld) 

set(STM32CUBEMX_SOURCES
    # cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_msp_template.c
    # cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_timebase_rtc_alarm_template.c
    # cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_timebase_rtc_wakeup_template.c
    # cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_timebase_tim_template.c

    cubeMX/Core/Src/stm32f4xx_it.c
    cubeMX/Core/Src/sysmem.c
    cubeMX/Core/Src/stm32f4xx_hal_msp.c
    cubeMX/Core/Src/syscalls.c
    cubeMX/Core/Src/system_stm32f4xx.c

    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_adc.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_adc_ex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_can.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cec.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cortex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_crc.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cryp.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cryp_ex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dac.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dac_ex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dcmi.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dcmi_ex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dfsdm.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma2d.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma_ex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dsi.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_eth.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_exti.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash_ex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash_ramfunc.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_fmpi2c.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_fmpi2c_ex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_fmpsmbus.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_gpio.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_hash.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_hash_ex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_hcd.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_i2c.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_i2c_ex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_i2s.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_i2s_ex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_irda.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_iwdg.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_lptim.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_ltdc.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_ltdc_ex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_mmc.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_nand.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_nor.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pccard.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pcd.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pcd_ex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr_ex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_qspi.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc_ex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rng.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rtc.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rtc_ex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_sai.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_sai_ex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_sd.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_sdram.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_smartcard.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_smbus.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_spdifrx.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_spi.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_sram.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_tim.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_tim_ex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_uart.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_usart.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_wwdg.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_adc.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_crc.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_dac.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_dma2d.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_dma.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_exti.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_fmc.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_fmpi2c.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_fsmc.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_gpio.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_i2c.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_lptim.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_pwr.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_rcc.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_rng.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_rtc.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_sdmmc.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_spi.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_tim.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_usart.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_usb.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_utils.c
)
