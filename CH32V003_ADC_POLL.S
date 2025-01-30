
# list of ADC pins on CH32V003 CHIP
#PA2 = A0
#PA1 = A1
#PC4 = A2
#PD2 = A3
#PD3 = A4
#PD5 = A5
#PD6 = A6
#PD4 = A7
#l Rule group: consists of up to 16 conversions. The rule channels and their conversion order are set in the
#ADC_RSQRx register. The total number of conversions in the rule group should be written to RLEN[3:0]
#in the ADC_RSQR1 register.
#l Injection group: consists of up to 4 conversions. The injection channels and the order of their conversions
#are set in the ADC_ISQR register. The total number of conversions in the injection group should be
#written in ILEN[1:0] of the ADC_ISQR register.
#Initialize the calibration register by writing RSTCAL position 1 of ADC_CTLR2 register and wait for
#RSTCALhardware to clear 0 to indicate the completion of initialization
#Assembler commands GNU
#riscv32-unknown-elf-as -g CH32V003_ADC_POLL.S -o CH32V003_ADC_POLL.o
#riscv32-unknown-elf-ld -T CH32V003.ld -Map=final.map CH32V003_ADC_POLL.O
#riscv32-unknown-elf-objcopy -O ihex a.out CH32V003_ADC_POLL.hex
#
#
#
#PD0 LED pin ,connect led with resistor 300ohm for 3.3v, flahes based on the position of potentiometer. max delay 10 seconds and minimum delay is 10ms 
#PD5 UART TX to see values of ADC in terminal use putty , realterm ,terraterm etc with a serial to usb converter
#PD4 connected to potentiometer signal pin and other 2 ends of the potentiometer connected to ground and power 3.3v




# TESTED AND FOUND WORKING




#register address
#-----------------------
.equ SRAM_start, 0x20000000
.equ SRAM_end, 0x20000800
.equ STACK, 0x20000800


.equ TIM2_BASE, 0x40000000
.equ W_WDG_BASE, 0x40002C00
.equ I_WDG_BASE, 0x40003000
.equ I2C_BASE, 0x40005400
.equ PWR_BASE, 0x40007000
.equ AFIO_BASE, 0x40010000
.equ EXTI_BASE, 0x40010400
.equ PORTA_BASE, 0x40010800
.equ PORTC_BASE, 0x40011000
.equ PORTD_BASE, 0x40011400
.equ ADC_BASE, 0x40012400
.equ TIM1_BASE, 0x40012C00
.equ SPI_BASE, 0x40013000
.equ USART_BASE, 0x40013800
.equ DMA_BASE, 0x40020000
.equ RCC_BASE, 0x40021000
.equ FLASH_INTERFACE_BASE, 0x40022000
.equ EXTENDED_MEM_BASE, 0x40023800
.equ CORE_PRIVATE_BASE, 0xE0000000
.equ FLASH_BASE, 0x08000000


.equ R32_PWR_CTLR, 0x40007000 #Power control register
.equ R32_PWR_CSR, 0x40007004 #Power control/status register
.equ R32_PWR_AWUCSR, 0x40007008 #Auto-wakeup control/status register
.equ R32_PWR_AWUWR, 0x4000700C #Auto-wakeup window comparison value register
.equ R32_PWR_AWUPSC, 0x40007010 #Auto-wakeup crossover factor register
.equ R32_RCC_CTLR, 0x40021000 #Clock control register 0x0000xx83
.equ R32_RCC_CFGR0, 0x40021004 #Clock configuration register 0 0x00000000
.equ R32_RCC_INTR, 0x40021008 #Clock interrupt register 0x00000000
.equ R32_RCC_APB2PRSTR, 0x4002100C #APB2 peripheral reset register 0x00000000
.equ R32_RCC_APB1PRSTR, 0x40021010 # APB1 peripheral reset register 0x00000000
.equ R32_RCC_AHBPCENR, 0x40021014 #AHB peripheral clock enable register 0x00000014
.equ R32_RCC_APB2PCENR, 0x40021018 #APB2 peripheral clock enable register 0x00000000
.equ R32_RCC_APB1PCENR, 0x4002101C #APB1 peripheral clock enable register 0x00000000
.equ R32_RCC_RSTSCKR, 0x40021024   #Control/status register

.equ R16_IWDG_CTLR, 0x40003000 #Control register 0x0000
.equ R16_IWDG_PSCR, 0x40003004 #Prescaler register 0x0000
.equ R16_IWDG_RLDR, 0x40003008 #Reload register 0x0FFF
.equ R16_IWDG_STATR, 0x4000300C #Status register

.equ R16_WWDG_CTLR, 0x40002C00 #Control register 0x007F
.equ R16_WWDG_CFGR, 0x40002C04 #Configuration Register 0x007F
.equ R16_WWDG_STATR, 0x40002C08 #Status Register

.equ R32_EXTI_INTENR, 0x40010400 #Interrupt enable register 0x00000000
.equ R32_EXTI_EVENR,  0x40010404 #Event enable register 0x00000000
.equ R32_EXTI_RTENR, 0x40010408 #Rising edge trigger enable register 0x00000000
.equ R32_EXTI_FTENR, 0x4001040C #Falling edge trigger enable register 0x00000000
.equ R32_EXTI_SWIEVR, 0x40010410 #Soft interrupt event register 0x00000000
.equ R32_EXTI_INTFR, 0x40010414 #Interrupt flag register

.equ R32_PFIC_ISR1, 0xE000E000 #PFIC interrupt enable status register 1
.equ R32_PFIC_ISR2, 0xE000E004 #PFIC interrupt enable status register 2 
.equ R32_PFIC_IPR1, 0xE000E020 #PFIC interrupt pending status register 1 
.equ R32_PFIC_IPR2, 0xE000E024 #PFIC interrupt pending status register 2 
.equ R32_PFIC_ITHRESDR, 0xE000E040 #PFIC interrupt priority threshold configuration register
.equ R32_PFIC_CFGR, 0xE000E048 #PFIC interrupt configuration register
.equ R32_PFIC_GISR, 0xE000E04C #PFIC interrupt global status register 
.equ R32_PFIC_VTFIDR, 0xE000E050 #PFIC VTF interrupt ID configuration register
.equ R32_PFIC_VTFADDRR0, 0xE000E060 #PFIC VTF interrupt 0 offset address register
.equ R32_PFIC_VTFADDRR1, 0xE000E064 #PFIC VTF interrupt 1 offset address register
.equ R32_PFIC_IENR1, 0xE000E100 #PFIC interrupt enable setting register 1 
.equ R32_PFIC_IENR2, 0xE000E104 #PFIC interrupt enable setting register 2 
.equ R32_PFIC_IRER1, 0xE000E180 #PFIC interrupt enable clear register 1 
.equ R32_PFIC_IRER2, 0xE000E184 #PFIC interrupt enable clear register 2 
.equ R32_PFIC_IPSR1, 0xE000E200 #PFIC interrupt pending setting register 1 
.equ R32_PFIC_IPSR2, 0xE000E204 #PFIC interrupt pending setting register 2 
.equ R32_PFIC_IPRR1, 0xE000E280 #PFIC interrupt hang clear register 1 
.equ R32_PFIC_IPRR2, 0xE000E284 #PFIC interrupt hang clear register 2 
.equ R32_PFIC_IACTR1, 0xE000E300 #PFIC interrupt activation status register1
.equ R32_PFIC_IACTR2, 0xE000E304 #PFIC interrupt activation status register2
.equ R32_PFIC_IPRIOR1, 0xE000E400 #PFIC interrupt priority configuration register
.equ R32_PFIC_IPRIOR2, 0xE000E401 #PFIC interrupt priority configuration register
.equ R32_PFIC_SCTLR, 0xE000ED10 #PFIC system control register

.equ INTSYSCR, 0x804 #Interrupt System Control Register
.equ MTVEC, 0x305 #Exception Entry Base Address Register
.equ DBGMCU_CR, 0x7C0   #Debug MCU Configuration Register (CSR)
 
.equ R32_STK_CTLR, 0xE000F000 #System count control register 
.equ R32_STK_SR, 0xE000F004 #System count status register 
.equ R32_STK_CNTR, 0xE000F008 # System counter low register 
.equ R32_STK_CMPR, 0xE000F010 #Counting comparison low register


.equ R32_GPIOA_CFGLR, 0x40010800 #PA port configuration register low 0x44444444
.equ R32_GPIOC_CFGLR, 0x40011000 #PC port configuration register low 0x44444444
.equ R32_GPIOD_CFGLR, 0x40011400 #PD port configuration register low 0x44444444
.equ R32_GPIOA_INDR, 0x40010808 #PA port input data register 0x0000XXXX
.equ R32_GPIOC_INDR, 0x40011008 #PC port input data register 0x0000XXXX
.equ R32_GPIOD_INDR, 0x40011408 #PD port input data register 0x0000XXXX
.equ R32_GPIOA_OUTDR, 0x4001080C #PA port output data register 0x00000000
.equ R32_GPIOC_OUTDR, 0x4001100C #PC port output data register 0x00000000
.equ R32_GPIOD_OUTDR, 0x4001140C #PD port output data register 0x00000000
.equ R32_GPIOA_BSHR, 0x40010810 #PA port set/reset register 0x00000000
.equ R32_GPIOC_BSHR, 0x40011010 #PC port set/reset register 0x00000000
.equ R32_GPIOD_BSHR, 0x40011410 #PD port set/reset register 0x00000000
.equ R32_GPIOA_BCR, 0x40010814 #PA port reset register 0x00000000
.equ R32_GPIOC_BCR, 0x40011014 #PC port reset register
.equ R32_GPIOD_BCR, 0x40011414 #PD port reset register 0x00000000
.equ R32_GPIOA_LCKR, 0x40010818 #PA port configuration lock register 0x00000000
.equ R32_GPIOC_LCKR, 0x40011018 #PC port configuration lock register 0x00000000
.equ R32_GPIOD_LCKR, 0x40011418 #PD port configuration lock register 
.equ R32_AFIO_PCFR1, 0x40010004 #AFIO Remap Register 1
.equ R32_AFIO_EXTICR, 0x40010008 #External interrupt configuration register 1

.equ R32_DMA_INTFR, 0x40020000 #DMA interrupt status register 0x00000000
.equ R32_DMA_INTFCR, 0x40020004 #DMA interrupt flag clear register 0x00000000
.equ R32_DMA_CFGR1, 0x40020008 #DMA channel 1 configuration register 0x00000000
.equ R32_DMA_CNTR1, 0x4002000C #DMA channel 1 number of data register
.equ R32_DMA_PADDR1, 0x40020010 #DMA channel 1 peripheral address register 0x00000000
.equ R32_DMA_MADDR1, 0x40020014 #DMA channel 1 memory address register 0x00000000
.equ R32_DMA_CFGR2, 0x4002001C #DMA channel 2 configuration register 0x00000000
.equ R32_DMA_CNTR2, 0x40020020 #DMA channel 2 number of data register 0x00000000
.equ R32_DMA_PADDR2, 0x40020024 #DMA channel 2 peripheral address register 0x00000000
.equ R32_DMA_MADDR2, 0x40020028 #DMA channel 2 memory address register 0x00000000
.equ R32_DMA_CFGR3, 0x40020030 #DMA channel 3 configuration register 0x00000000
.equ R32_DMA_CNTR3, 0x40020034 #DMA channel 3 number of data register 0x00000000
.equ R32_DMA_PADDR3, 0x40020038 #DMA channel 3 peripheral address register 0x00000000
.equ R32_DMA_MADDR3, 0x4002003C #DMA channel 3 memory address register 0x00000000
.equ R32_DMA_CFGR4, 0x40020044 #DMA channel 4 configuration register 0x00000000
.equ R32_DMA_CNTR4, 0x40020048 #DMA channel 4 number of data register 0x00000000
.equ R32_DMA_PADDR4, 0x4002004C #DMA channel 4 peripheral address register 0x00000000
.equ R32_DMA_MADDR4, 0x40020050 #DMA channel 4 memory address register 0x00000000
.equ R32_DMA_CFGR5, 0x40020058 #DMA channel 5 configuration register 0x00000000
.equ R32_DMA_CNTR5, 0x4002005C #DMA channel 5 number of data register 0x00000000
.equ R32_DMA_PADDR5, 0x40020060 #DMA channel 5 peripheral address register 0x00000000
.equ R32_DMA_MADDR5, 0x40020064 #DMA channel 5 memory address register 0x00000000
.equ R32_DMA_CFGR6, 0x4002006C #DMA channel 6 configuration register 0x00000000
.equ R32_DMA_CNTR6, 0x40020070 #DMA channel 6 number of data register 0x00000000
.equ R32_DMA_PADDR6, 0x40020074 #DMA channel 6 peripheral address register 0x00000000
.equ R32_DMA_MADDR6, 0x40020078 #DMA channel 6 memory address register 0x00000000
.equ R32_DMA_CFGR7, 0x40020080 #DMA channel 7 configuration register 0x00000000
.equ R32_DMA_CNTR7, 0x40020084 #DMA channel 7 number of data register 0x00000000
.equ R32_DMA_PADDR7, 0x40020088 #DMA channel 7 peripheral address register 0x00000000
.equ R32_DMA_MADDR7, 0x4002008C #DMA channel 7 memory address register


.equ R32_ADC_STATR, 0x40012400 #ADC status register 0x00000000
.equ R32_ADC_CTLR1, 0x40012404 #ADC control register 1 0x00000000
.equ R32_ADC_CTLR2, 0x40012408 #ADC control register 2 0x00000000
.equ R32_ADC_SAMPTR1, 0x4001240C #ADC sample time register 1 0x00000000
.equ R32_ADC_SAMPTR2, 0x40012410 #ADC sample time register 2 0x00000000
.equ R32_ADC_IOFR1, 0x40012414 #ADC injected channel data offset register 1 0x00000000
.equ R32_ADC_IOFR2, 0x40012418 #ADC injected channel data offset register 2 0x00000000
.equ R32_ADC_IOFR3, 0x4001241C #ADC injected channel data offset register 3 0x00000000
.equ R32_ADC_IOFR4, 0x40012420 #ADC injected channel data offset register 4 0x00000000
.equ R32_ADC_WDHTR, 0x40012424 #ADC watchdog high threshold register 0x00000000
.equ R32_ADC_WDLTR, 0x40012428 #ADC watchdog low threshold register 0x00000000
.equ R32_ADC_RSQR1, 0x4001242C #ADC regular sequence register 1 0x00000000
.equ R32_ADC_RSQR2, 0x40012430 #ADC regular sequence register 2 0x00000000
.equ R32_ADC_RSQR3, 0x40012434 #ADC regular sequence register 3 0x00000000
.equ R32_ADC_ISQR, 0x40012438 #ADC injected sequence register 0x00000000
.equ R32_ADC_IDATAR1, 0x4001243C #ADC injected data register 1 0x00000000
.equ R32_ADC_IDATAR2, 0x40012440 #ADC injected data register 2 0x00000000
.equ R32_ADC_IDATAR3, 0x40012444 #ADC injected data register 3 0x00000000
.equ R32_ADC_IDATAR4, 0x40012448 #ADC injected data register 4 0x00000000
.equ R32_ADC_RDATAR, 0x4001244C #ADC regular data register 0x00000000
.equ R32_ADC_DLYR, 0x40012450 #ADC delayed data register


.equ R16_TIM1_CTLR1, 0x40012C00 #Control register 1 0x0000
.equ R16_TIM1_CTLR2, 0x40012C04 #Control register 2 0x0000
.equ R16_TIM1_SMCFGR, 0x40012C08 #Slave mode control register 0x0000
.equ R16_TIM1_DMAINTENR, 0x40012C0C #DMA/interrupt enable register 0x0000
.equ R16_TIM1_INTFR, 0x40012C10 #Interrupt status register 0x0000
.equ R16_TIM1_SWEVGR, 0x40012C14 #Event generation register 0x0000
.equ R16_TIM1_CHCTLR1, 0x40012C18 #Compare/capture control register 1 0x0000
.equ R16_TIM1_CHCTLR2, 0x40012C1C #Compare/capture control register 2 0x0000
.equ R16_TIM1_CCER, 0x40012C20 #Compare/capture enable register 0x0000
.equ R16_TIM1_CNT, 0x40012C24 #Counters 0x0000
.equ R16_TIM1_PSC, 0x40012C28 #Counting clock prescaler 0x0000
.equ R16_TIM1_ATRLR, 0x40012C2C #Auto-reload value register 0x0000
.equ R16_TIM1_RPTCR, 0x40012C30 #Recurring count value register 0x0000
.equ R16_TIM1_CH1CVR, 0x40012C34 #Compare/capture register 1 0x0000
.equ R16_TIM1_CH2CVR, 0x40012C38 #Compare/capture register 2 0x0000
.equ R16_TIM1_CH3CVR, 0x40012C3C #Compare/capture register 3 0x0000
.equ R16_TIM1_CH4CVR, 0x40012C40 #Compare/capture register 4 0x0000
.equ R16_TIM1_BDTR, 0x40012C44 #Brake and deadband registers 0x0000
.equ R16_TIM1_DMACFGR, 0x40012C48 #DMA control register 0x0000
.equ R16_TIM1_DMAADR, 0x40012C4C #DMA address register for continuous mode


.equ R16_TIM2_CTLR1, 0x40000000 #TIM2 control register1 0x0000
.equ R16_TIM2_CTLR2, 0x40000004 #TIM2 control register2 0x0000
.equ R16_TIM2_SMCFGR, 0x40000008 #TIM2 Slave mode control register 0x0000
.equ R16_TIM2_DMAINTENR, 0x4000000C #TIM2 DMA/interrupt enable register
.equ R16_TIM2_INTFR, 0x40000010 #TIM2 interrupt status register 0x0000
.equ R16_TIM2_SWEVGR, 0x40000014 #TIM2 event generation register 0x0000
.equ R16_TIM2_CHCTLR1, 0x40000018 #TIM2 compare/capture control register1 0x0000
.equ R16_TIM2_CHCTLR2, 0x4000001C #TIM2 compare/capture control register2 0x0000
.equ R16_TIM2_CCER, 0x40000020 #TIM2 compare/capture enable register 0x0000
.equ R16_TIM2_CNT, 0x40000024 #TIM2 counter 0x0000
.equ R16_TIM2_PSC, 0x40000028 #TIM2 count clock prescaler 0x0000
.equ R16_TIM2_ATRLR, 0x4000002C #TIM2 auto-reload register 0x0000
.equ R16_TIM2_CH1CVR, 0x40000034 #TIM2 compare/capture register1 0x0000
.equ R16_TIM2_CH2CVR, 0x40000038 #TIM2 compare/capture register2 0x0000
.equ R16_TIM2_CH3CVR, 0x4000003C #TIM2 compare/capture register3 0x0000
.equ R16_TIM2_CH4CVR, 0x40000040 #TIM2 compare/capture register4 0x0000
.equ R16_TIM2_DMACFGR, 0x40000048 #TIM2 DMA control register 0x0000
.equ R16_TIM2_DMAADR, 0x4000004C #TIM2 DMA address register in continuous mode
  

.equ R32_USART_STATR, 0x40013800 #UASRT status register 0x000000C0
.equ R32_USART_DATAR, 0x40013804 #UASRT data register 0x000000XX
.equ R32_USART_BRR, 0x40013808 #UASRT baud rate register 0x00000000
.equ R32_USART_CTLR1, 0x4001380C #UASRT control register 1 0x00000000
.equ R32_USART_CTLR2, 0x40013810 #UASRT control register 2 0x00000000
.equ R32_USART_CTLR3, 0x40013814 #UASRT control register 3 0x00000000
.equ R32_USART_GPR, 0x40013818 #UASRT protection time and prescaler register


.equ R16_I2C_CTLR1, 0x40005400 #I2C control register 1 0x0000
.equ R16_I2C_CTLR2, 0x40005404 #I2C control register 2 0x0000
.equ R16_I2C_OADDR1, 0x40005408 #I2C address register 1 0x0000
.equ R16_I2C_OADDR2, 0x4000540C #I2C address register 2 0x0000
.equ R16_I2C_DATAR,  0x40005410 #I2C data register 0x0000
.equ R16_I2C_STAR1,  0x40005414 #I2C status register 1 0x0000
.equ R16_I2C_STAR2,  0x40005418 #I2C status register 2 0x0000
.equ R16_I2C_CKCFGR, 0x4000541C #I2C clock register

.equ R16_SPI_CTLR1, 0x40013000 #SPI Control register1 0x0000
.equ R16_SPI_CTLR2, 0x40013004 #SPI Control register2 0x0000
.equ R16_SPI_STATR, 0x40013008 #SPI Status register 0x0002
.equ R16_SPI_DATAR, 0x4001300C #SPI Data register 0x0000
.equ R16_SPI_CRCR,  0x40013010 #SPI Polynomial register 0x0007
.equ R16_SPI_RCRCR, 0x40013014 #SPI Receive CRC register 0x0000
.equ R16_SPI_TCRCR, 0x40013018 #SPI Transmit CRC register 0x0000
.equ R16_SPI_HSCR,  0x40013024 #SPI High-speed control register

.equ R16_ESIG_FLACAP, 0x1FFFF7E0 #Flash capacity register 0xXXXX
.equ R32_ESIG_UNIID1, 0x1FFFF7E8 #UID register 1 0xXXXXXXXX
.equ R32_ESIG_UNIID2, 0x1FFFF7EC #UID register 2 0xXXXXXXXX
.equ R32_ESIG_UNIID3,  0x1FFFF7F0 #UID register 3 

.equ R32_FLASH_ACTLR, 0x40022000 #Control register
.equ R32_FLASH_KEYR,  0x40022004 #FPEC key register X
.equ R32_FLASH_OBKEYR, 0x40022008 #OBKEY register X
.equ R32_FLASH_STATR, 0x4002200C #Status register 0x00008000
.equ R32_FLASH_CTLR,  0x40022010 #Configuration register 0x00008080
.equ R32_FLASH_ADDR, 0x40022014 #Address register X
.equ R32_FLASH_OBR,  0x4002201C #Select word register 0x03FFFFFE
.equ R32_FLASH_WPR,  0x40022020 #Write protection register 0xFFFFFFF
.equ R32_FLASH_MODEKEYR,0x40022024 #Extended key register X
.equ R32_FLASH_BOOT_MODEKEYR,0x40022028 #Unlock BOOT key register

.equ R32_EXTEN_CTR, 0x40023800 #Configure extended control registers

.equ PFIC_KEY1, 0xFA050000
.equ PFIC_KEY2, 0xBCAF0000
.equ PFIC_KEY3, 0xBEEF0000
.equ mstatus, 0x300
.equ mtvec, 0x305
.equ intsyscr, 0x804
.equ mepc, 0x341

.equ  SYSTICK_SR_CNTIF, (1<<0)
.equ  SYSTICK_CTLR_STE , (1<<0)
.equ  SYSTICK_CTLR_STIE, (1<<1)
.equ  SYSTICK_CTLR_STCLK, (1<<2)
.equ  SYSTICK_CTLR_STRE,  (1<<3)
.equ  SYSTICK_CTLR_SWIE, (1<<31) 


########
.equ fclk,  24000000   	# 24Mhz RCO internal , AHB =8Mhz by default
.equ state, 0x2000000C 	# located in SRAM
.equ result1, 0x20000010 	# 0x20000010 to 0x20000018 is used for storing result in decimal format
.equ scratch, 0x20000020
.equ mem, 0x20000024
##########

.align 2
.text
.global start
start:

sp_init:
    	li sp, STACK			# initialize stack pointer


#Enable GPIO clocks & AFIO in APB2 clock register
        
    	la x10,R32_RCC_APB2PCENR	# load address of APB2PCENR register to x10 ,for enabling GPIO A,D,C peripherals
	lw x11,0(x10)			# load contents from peripheral register R32_RCC_APB2PCENR pointed by x10
	li x7,((1<<2)|(1<<4)|(1<<5)|(1<<0)|(1<<14))|(1<<9)	# 1<<IOPA_EN,1<<IOPC_EN,1<<IOPD_EN,1<<AFIOEN,1<<USART ,1<<ADC enable port A,C,D and AFIO functions
	or x11,x11,x7			# or values 
	sw x11,0(x10)			# store modified enable values in R32_RCC_APB2PCENR


#Enable ADC prescaler in clock configuration register
	la x10,R32_RCC_CFGR0
	lw x11,0(x10)
	li x7,((8<<11))			# 0b01000 ADC prescalar ahb/4 = 8/4 = 2mhz
	or x11,x11,x7
	sw x11,0(x10)

#configure GPIO 
	la x10,R32_GPIOD_CFGLR		# load pointer x10 with address of R32_GPIOD_CFGLR , GPIO configuration register
	lw x11,0(x10)			# load contents from register pointed by x10
	li x7,~((0xf<<20)|(0xf<<24)|(0xf<<16)|(0xf<<0))	#clear pd6,pd5,pd4,pd0. we need to setup PD5 & PD6 for usart tx and rx and pd4 for ADC7,pd0 for led flash
	and x11,x11,x7			# clear pd4,pd5,pd6 mode and cnf bits for selected pin D4,D5,D6,d0
	li x7,((0x8<<24)|(0xB<<20)|(0x3<<0))	# pd6 = input with PU/PD,pd5= multiplex pushpull output 50mhz,pd4 analog input for ADC 0b0000,pd0 pushpull 0b0011
	or x11,x11,x7			# OR value to register
	sw x11,0(x10)			# store in R32_GPIOD_CFGLR


#configure USART baud
	la x10,R32_USART_BRR		# USART BAUD setting
	lw x11,0(x10)			# copy R32_USART_BRR to x11
	li x7,((52<<4)|(1<<0))		# 52.1 in BRR =9600
	or x11,x11,x7			# or registers
	sw x11,0(x10)			# store in R32_USART_BRR

#setup UART control and enable	
	la x10,R32_USART_CTLR1		# load x10 with R32_USART_CTLR1 address
	lw x11,0(x10)			# load to x11 contents
	li x7,(1<<13)|(1<<3)|(1<<2)	# enable USART UE, TX,RX bits		# UE 
	or x11,x11,x7
	sw x11,0(x10)			# store back new values



#disable ADC before configuration
	la x10,R32_ADC_CTLR2
	lw x11,0(x10)
	li x7,0xfffffffe		#disable ADON bit , 0 written in 0bit
	and x11,x11,x7
	sw x11,0(x10)

#set sequence of conversion channel
	la x10,R32_ADC_RSQR3		# sequence register, if multiple sensors used we can determine the order of conversion
	lw x11,0(x10)
	li x7,(7<<0)			# AIN7 adc channel is written to sequence 1 (only one channel in this project)	
	or x11,x11,x7
	sw x11,0(x10)

#set sampling cycles
	la x10,R32_ADC_SAMPTR2		# takes sampling cycles for each measurement
	lw x11,0(x10)
	li x7,(7<<21)			# 0b111/0x7 is 241 cycles	
	or x11,x11,x7
	sw x11,0(x10)

#enable adc in control register2
	la x10,R32_ADC_CTLR2
	lw x11,0(x10)
	li x7,((7<<17)|(1<<0))		# SWSTART trigger for ADC and ADON
	or x11,x11,x7
	sw x11,0(x10)

#reset calibrate ADC
	la x10,R32_ADC_CTLR2
	lw x11,0(x10)
	li x7,(1<<3)			# reset calibration	
	or x11,x11,x7
	sw x11,0(x10)
check1:
	la x10,R32_ADC_CTLR2
	lw x11,0(x10)
	andi x11,x11,(1<<3)
	bnez x11,check1

# calibrate ADC
	la x10,R32_ADC_CTLR2
	lw x11,0(x10)
	li x7,(1<<2)			# start calibration	
	or x11,x11,x7
	sw x11,0(x10)
check2:
	la x10,R32_ADC_CTLR2
	lw x11,0(x10)
	andi x11,x11,(1<<2)
	bnez x11,check2


#main endless loop for uart transmit
example:

	la x10,name			# load address of label "name" to x10, string to be transmitted
string_loop:
	lb x8,0(x10)			# load 1 byte from 0 offset of "name"
	beqz x8,sfinish			# if byte in x8 null branch to label "finish"
	call USART_TX			# call subroutine USART_TX to transmit byte
	addi x10,x10,1			# increase pointer by 1 byte
	j string_loop			# jump back to label string_loop until null is encountered
sfinish:		
	
# ADC measure
here:

	call measure

	call show_adc_count

PD4_ON:
	la x10,R32_GPIOD_BSHR		# R32_GPIOD_BSHR register sets and resets GPIOD pins, load address into pointer x10
	lw x11,0(x10)			# load contents to x11
	li x7,(1<<0)			# set pd0 by shifting 1 to bit position 4
	or x11,x11,x7			# OR with x11
	sw x11,0(x10)			# store x11 to R32_GPIOD_BSHR


	call delay			# delay subroutine

PD4_OFF:
	la x10,R32_GPIOD_BSHR		# R32_GPIOD_BSHR register sets and resets GPIOD pins, load address into pointer x10
	lw x11,0(x10)			# load contents to x11
	li x7,1<<16			# reset pd0 by shifting 1 into bit position 16 of R32_GPIOD_BSHR
	or x11,x11,x7			# OR with x11
	sw x11,0(x10)			# store x11 to R32_GPIOD_BSHR

	call delay			# delay subroutine

	j here			# jump to label PD4_ON and loop



measure:
	addi sp,sp,-12
	sw ra,0(sp)
	sw x10,4(sp)
	sw x11,8(sp)
	la x10,R32_ADC_CTLR2
	lw x11,0(x10)
	li x7,(1<<22)			# (1<<SWSTART) start conversion
	ori x11,x11,1
	sw x11,0(x10)
checkflag:
	la x10,R32_ADC_STATR		# adc status register
	lw x11,0(x10)
	andi x11,x11,2			# adc conversion finish flag mask
	beqz x11,checkflag		# wait till bit 1 is set
	la x10,R32_ADC_RDATAR		# ADC data register
	lw x11,0(x10)			# copy data register
	la x10,result1			# load address of result1 variable in SRAM
	sw x11,0(x10)			# store ADC result in result1
	lw x11,8(sp)
	lw x10,4(sp)
	lw ra,0(sp)
	addi sp,sp,12
	ret
	


show_adc_count:
	addi sp,sp,-4
	sw ra,0(sp)
	la x10,result1	
	call D_ASCII			# procedure to convert result to ASCII , subroutine called with x10 pointing to result1 in SRAM
	call print			# prints result in USART
	li x8,' '			# load space (0x20) , print space
	call USART_TX			# call uart
	li x8,0x0d			# line feed	
	call USART_TX			# call uart
	li x8,0x0a			# carriage feed
	call USART_TX			# call uart
blank_line:
	li x8,' '
	call USART_TX			# call uart
	li x8,0x0d			# line feed
	call USART_TX			# call uart
	li x8,0x0a			# carriage feed
	call USART_TX			# call uart
	lw ra,0(sp)
	addi sp,sp,4
	ret
	
	
#####################################################################
# SUBROUTINES
#####################################################################	
	
USART_TX:
	addi sp,sp,-16			# add space in stack
	sw ra,0(sp)			# push ra
	sw x7,4(sp)			# push x7
	sw x10,8(sp)			# push x10
	sw x11,12(sp)			# push x11

	la x10,R32_USART_STATR		# load address of usart status register
	lw x11,0(x10)			# load contents of status register in x11
	andi x11,x11,(1<<7)		# mask out 7th bit, transmit buffer empty flag
	beqz x11,USART_TX		# if 0 transmit buffer full, wait until bit is set
	#li x8,0x30
	mv x7,x8			# move byte in x8 to x7
	la x10,R32_USART_DATAR		# x10 has the address of data register
	sb x7,0(x10)			#store byte in x7 to data register
TC_check:
	la x10,R32_USART_STATR		# get contents of status register again
	lw x11,0(x10)
	andi x11,x11,(1<<6)		# check transmit complete bit
	beqz x11,TC_check		# wait if bit is 0 , when transmit complete = 1
		
	lw x11,12(sp)			# pop x11
	lw x10,8(sp)			# pop x10
	lw x7,4(sp)			# pop x7
	lw ra,0(sp)			# pop ra
	addi sp,sp,16			# set SP back 16 bytes
	ret				# return to caller

########################################

###################################################
delay:	
	addi sp,sp,-20			# move sp 2 words
	sw ra,0(sp)			# push ra
	sw x6,4(sp)			# push x6
	sw x7,8(sp)
	sw x5,12(sp)
	sw x10,16(sp)
	la x10,result1
	lw x6,0(x10)
	bnez x6,notzero
	li x6,1
notzero:
	li x7,20100			# count needed for 10ms delay
	mv x5,x6
	xor x6,x6,x6
multiplyADC:
	add x6,x6,x7
	addi x5,x5,-1
	bnez x5,multiplyADC		
dloop:
	addi x6,x6,-1			# subtract 1 from t1
	bne x6,zero,dloop		# if t1 not equal to 0 branch to label loop
	lw x10,16(sp)
	lw x5,12(sp)
	lw x7,8(sp)
	lw x6,4(sp)			# pop x6
	lw ra,0(sp)			# pop ra
	addi sp,sp,20			# sp back 2 words
	ret				# return to caller

#==========================================
delay10S: 
	addi sp,sp,-8 # push RA
	sw ra,0(sp) # push RA
	sw t1,4(sp)
	li t1,20100101 # load an arbitarary value 20000000 to t1 register 
loop10S:
	addi t1,t1,-1 # subtract 1 from t1
	bne t1,zero,loop10S # if t1 not equal to 0 branch to label loop
	lw t1,4(sp)
	lw ra,0(sp) # POP RA
	addi sp,sp,8 # pop RA
	ret 

delay1S: 
	addi sp,sp,-8 # push RA
	sw ra,0(sp) # push RA
	sw t1,4(sp)
	li t1,2010010 # load an arbitarary value 20000000 to t1 register 
loop1s:
	addi t1,t1,-1 # subtract 1 from t1
	bne t1,zero,loop1s # if t1 not equal to 0 branch to label loop
	lw t1,4(sp)
	lw ra,0(sp) # POP RA
	addi sp,sp,8 # pop RA
	ret 

delay1ms:
	addi sp,sp,-8 # push RA
	sw ra,0(sp) # push RA
	sw t1,4(sp) 
	li t1,2010 # load an arbitarary value 20000000 to t1 register 
loop1ms:
	addi t1,t1,-1 # subtract 1 from t1
	bne t1,zero,loop1ms # if t1 not equal to 0 branch to label loop
	lw t1,4(sp)
	lw ra,0(sp) # POP RA
	addi sp,sp,8 # pop RA 
	ret 

delay10ms:
	addi sp,sp,-8 # push RA
	sw ra,0(sp) # push RA
	sw t1,4(sp) 
	li t1,20100 # load an arbitarary value 20000000 to t1 register 
loop10ms:
	addi t1,t1,-1 # subtract 1 from t1
	bne t1,zero,loop10ms # if t1 not equal to 0 branch to label loop
	lw t1,4(sp)
	lw ra,0(sp) # POP RA
	addi sp,sp,8 # pop RA
	ret

delay50ms:
	addi sp,sp,-8 # push RA
	sw ra,0(sp) # push RA
	sw t1,4(sp) 
	li t1,100500 # load an arbitrary value 20000000 to t1 register 
loop50ms:
	addi t1,t1,-1 # subtract 1 from t1
	bne t1,zero,loop50ms # if t1 not equal to 0 branch to label loop
	lw t1,4(sp)
	lw ra,0(sp) # POP RA
	addi sp,sp,8 # pop RA
	ret 
##############################################################################
###########################################################


##########################################################################################################
# converts 1 byte into ASCII represented hexadecimal value
##########################################################################################################
bin_to_ascii:
	addi sp,sp,-4
	sw ra,0(sp)
	mv a3,t2
	andi a3,a3,0xf0
	srli a3,a3,4
	slti a4,a3,10			# set a4 to 1 if a3 is less than 10 ,10and higher a4=0
	beqz a4 ,letter1
	ori a3,a3,0x30
	#mv a0,a3
	mv x8,a3
	call USART_TX
	j low_nibble
letter1:
	addi a3,a3,0x37
	#mv a0,a3
	mv x8,a3
	call USART_TX
low_nibble:
	mv a3,t2
	andi a3,a3,0x0f
	slti a4,a3,10			# set a4 to 1 if a3 is less than 10 ,10and higher a4=0
	beqz a4 ,letter2
	ori a3,a3,0x30
	#mv a0,a3
	mv x8,a3
	call USART_TX
	j exit_bin_to_ascii
letter2:
	addi a3,a3,0x37
	#mv a0,a3
	mv x8,a3
	call USART_TX
exit_bin_to_ascii:
	lw ra,0(sp)
	addi sp,sp,4
	ret
#######################################################################################################

#########################################################################################################################################
# D_ASCII subroutine for converting binary in result1 to DECIMAL (ASCII), point with x10 to register with value to be converted
#########################################################################################################################################

D_ASCII:			
	addi sp,sp,-32		# adjust stack pointer
	sw ra,28(sp)		# PUSH
	sw x15,24(sp)		# PUSH
	sw x11,20(sp)		# PUSH
	sw x8,16(sp)		# PUSH
	sw x7,12(sp)		# PUSH
	sw x5,8(sp)		# PUSH
	sw x4,4(sp)		# PUSH
	sw t1,0(sp)		# PUSH
	li x4,0			# clear register
	li x5,0			# clear register
	li x7,0			# clear register
	li x8,0			# clear register
	li x15,0		# clear register
	
#	li x10,0x20000010	# result1 (point address of value that has to be converted with x10)
	lw x4,0(x10)		# copy value from memory pointed by x10 to x4,this routine to be called after pointing to register with required value
#	li x4,0xffffffff	# 32bit word to be converted into ascii chars
	li x7,1000000000	# divisor
Y1:
	sub x8,x4,x7		# subtract divisor from word to be converted
	sltu x5,x4,x7		# if result negative set x5 to indicate cannot be divided
	bnez x5,X1		# if result negative(not divisible) branch to X1
	mv x4,x8		# else move remainder to x4 for further division/subtraction
	addi x15,x15,1		# increase result by 1
	j Y1			# jump to label Y1 till not divisible
X1:
	addi x15,x15,0x30	# add ascii 0 to result to convert to ASCII char
	la x10,mem		# set pointer x10 to SRAM register mem to store the byte
	sb x15,0(x10)		# store byte in mem+0
	li x15,0		# clear result
	li x7,100000000		# load x7 with new divisor
Y2:
	sub x8,x4,x7		# subtract divisor from word to be converted
	sltu x5,x4,x7		# if result negative set x5 to indicate cannot be divided
	bnez x5,X2		# if result negative(not divisible) branch to X2
	mv x4,x8		# else move remainder to x4 for further division/subtraction
	addi x15,x15,1		# increase result by 1
	j Y2			# jump to label Y2 till not divisible
X2:
	addi x15,x15,0x30	# add ascii 0 to result to convert to ASCII char
	addi x10,x10,1		# set pointer x10 to SRAM register mem+1 to store the byte
	sb x15,0(x10)		# store byte in mem+1
	li x15,0		# clear result
	li x7,10000000		# load x7 with new divisor
Y3:
	sub x8,x4,x7		# subtract divisor from word to be converted
	sltu x5,x4,x7		# if result negative set x5 to indicate cannot be divided
	bnez x5,X3		# if result negative(not divisible) branch to X3
	mv x4,x8		# else move remainder to x4 for further division/subtraction
	addi x15,x15,1		# increase result by 1
	j Y3			# jump to label Y3 till not divisible
X3:
	addi x15,x15,0x30	# add ascii 0 to result to convert to ASCII char
	addi x10,x10,1		# set pointer x10 to SRAM register mem+2 to store the byte
	sb x15,0(x10)		# store byte in mem+2
	li x15,0		# clear result
	li x7,1000000		# load x7 with new divisor
Y4:
	sub x8,x4,x7		# subtract divisor from word to be converted
	sltu x5,x4,x7		# if result negative set x5 to indicate cannot be divided
	bnez x5,X4		# if result negative(not divisible) branch to X4
	mv x4,x8		# else move remainder to x4 for further division/subtraction
	addi x15,x15,1		# increase result by 1
	j Y4			# jump to label Y4 till not divisible
X4:
	addi x15,x15,0x30	# add ascii 0 to result to convert to ASCII char
	addi x10,x10,1		# set pointer x10 to SRAM register mem+3		
	sb x15,0(x10)		# store byte in mem+3
	li x15,0		# clear result
	li x7,100000		# load x7 with new divisor
Y5:
	sub x8,x4,x7		# subtract divisor from word to be converted
	sltu x5,x4,x7		# if result negative set x5 to indicate cannot be divided
	bnez x5,X5		# if result negative(not divisible) branch to X5
	mv x4,x8		# else move remainder to x4 for further division/subtraction
	addi x15,x15,1		# increase result by 1
	j Y5			# jump to label Y5 till not divisible
X5:
	addi x15,x15,0x30	# add ascii 0 to result to convert to ASCII char
	addi x10,x10,1		# set pointer x10 to SRAM register mem+4 to store the byte
	sb x15,0(x10)		# store byte in mem+4
	li x15,0		# clear result
	li x7,10000		# load x7 with new divisor
Y6:
	sub x8,x4,x7		# subtract divisor from word to be converted
	sltu x5,x4,x7		# if result negative set x5 to indicate cannot be divided
	bnez x5,X6		# if result negative(not divisible) branch to X6
	mv x4,x8		# else move remainder to x4 for further division/subtraction
	addi x15,x15,1		# increase result by 1
	j Y6			# jump to label Y6 till not divisible
X6:
	addi x15,x15,0x30	# add ascii 0 to result to convert to ASCII char
	addi x10,x10,1		# set pointer x10 to SRAM register mem+5 to store the byte
	sb x15,0(x10)		# store byte in mem+5
	li x15,0		# clear result
	li x7,1000		# load x7 with new divisor
Y7:
	sub x8,x4,x7		# subtract divisor from word to be converted
	sltu x5,x4,x7		# if result negative set x5 to indicate cannot be divided
	bnez x5,X7		# if result negative(not divisible) branch to X7
	mv x4,x8		# else move remainder to x4 for further division/subtraction
	addi x15,x15,1		# increase result by 1
	j Y7			# jump to label Y7 till not divisible
X7:
	addi x15,x15,0x30	# add ascii 0 to result to convert to ASCII char
	addi x10,x10,1		# set pointer x10 to SRAM register mem+6 to store the byte
	sb x15,0(x10)		# store byte in mem+6
	li x15,0		# clear result
	li x7,100		# load x7 with new divisor
Y8:
	sub x8,x4,x7		# subtract divisor from word to be converted
	sltu x5,x4,x7		# if result negative set x5 to indicate cannot be divided
	bnez x5,X8		# if result negative(not divisible) branch to X8
	mv x4,x8		# else move remainder to x4 for further division/subtraction
	addi x15,x15,1		# increase result by 1
	j Y8			# jump to label Y8 till not divisible
X8:
	addi x15,x15,0x30	# add ascii 0 to result to convert to ASCII char
	addi x10,x10,1		# set pointer x10 to SRAM register mem+7 to store the byte
	sb x15,0(x10)		# store byte in mem+7
	li x15,0		# clear result
	li x7,10		# load x7 with new divisor
Y9:
	sub x8,x4,x7		# subtract divisor from word to be converted
	sltu x5,x4,x7		# if result negative set x5 to indicate cannot be divided
	bnez x5,X9		# if result negative(not divisible) branch to X9
	mv x4,x8		# else move remainder to x4 for further division/subtraction
	addi x15,x15,1		# increase result by 1
	j Y9			# jump to label Y9 till not divisible
X9:
	addi x15,x15,0x30	# add ascii 0 to result to convert to ASCII char
	addi x10,x10,1		# set pointer x10 to SRAM register mem+8 to store the byte
	sb x15,0(x10)		# store byte in mem+8
	li x15,0		# clear result
	mv x15,x4
X10:
	addi x15,x15,0x30	# add ascii 0 to result to convert to ASCII char
	addi x10,x10,1		# set pointer x10 to SRAM register mem+9 to store the byte	
	sb x15,0(x10)		# store byte in mem+9

	lw t1,0(sp)		# POP
	lw x4,4(sp)		# POP
	lw x5,8(sp)		# POP
	lw x7,12(sp)		# POP
	lw x8,16(sp)		# POP
	lw x11,20(sp)		# POP
	lw x15,24(sp)		# POP
	lw ra,28(sp)		# POP
	addi sp,sp,32		# adjust stack pointer
	ret			# return to caller
######################################################

################################################################################
# Prints 10 bytes from result1 to USART with lead 0 suppress, values to be stored in mem0-mem9
################################################################################
print:
	addi sp,sp,-20		# adjust stack pointer
	sw ra,16(sp)		# PUSH
	sw x11,12(sp)		# PUSH
	sw x10,8(sp)		# PUSH
	sw x8,4(sp)		# PUSH
	sw t1,0(sp)		# PUSH

	la x11,scratch		# point x11 to scratch register in SRAM
	sw zero,0(x11)		# clear scratch register

	la x10,mem		# point to address mem ,top byte stored in mem0 lowest byte in mem+9, need to print top byte 1st
	li t1,0			# byte counter loaded with 10 , total 10 bytes to be printed
	li x15,10		# max count of 10bytes in x15

Z:
	lb x8,0(x10)		# load byte from result1, msb to lsb
	
	li x4,0x30		# load ascii 0 in x4
	beq x8,x4,supress0	# if result1 byte in x8 is equal to ascii 0 in x4 branch to suppress0 label
	la x11,scratch		# point x11 to scratch if x8 is not 0,that means we have found the 1st byte that is not 0, all leading 0s finished
	li x5,1			# load x5 with 1
	sw x5,0(x11)		# store in scratch register in sram , used as a flag to indicate all leading 0s are finished

print1:
	addi x10,x10,1		# increase the address by 1 byte
	addi t1,t1,1		# increase the byte counter once
	call USART_TX		# call uart
	bne t1,x15,Z		# if t1 not equal to 10 as loaded in x15 loop back to print1 till al 10 bytes are transmitted via usart
	lw t1,0(sp)		# POP
	lw x8,4(sp)		# POP
	lw x10,8(sp)		# POP
	lw x11,12(sp)		# POP
	lw ra,16(sp)		# POP
	addi sp,sp,20		# adjust stack pointer
	ret			# return to caller
supress0:
	la x11,scratch		# point x11 to scratch	
	lw x5,0(x11)		# copy value of scratch to x5
	bnez x5,no_more_supress	# if x5 is not 0 branch to label "no_more_supress"
	li x8,0x20		# if x5 is 0 load x8 with space/blank	
	li x4,9			# load x4 with value 9, suppose the whole value is 0, we dont want to display blank space, test this is 9th byte 2nd last byte
	beq t1,x4,last0is0	# if t1 equals 9 in x4 branch to label "last0is0" which will keep last 0 as 0 on screen
no_more_supress:
	J print1		# no 0 suppression jump to print1	
last0is0:
	li x8,0x30		# load ascii 0 for last 0
	J print1		# jump to print1


.align 4

.section .rodata
.global name

name: .asciz "SAJEEV SANKARAN CH32V003 UART"









