ZynqMP-FPGA-Ubuntu20.04
====================================================================================

Overview
------------------------------------------------------------------------------------

### Introduction

This Repository provides a Linux Boot Image(U-boot, Kernel, Ubuntu 20.04 Desktop) for Zynq MPSoC.

### Features

* Hardware
  + Ultra96    : Xilinx Zynq UltraScale+ MPSoC development board based on the Linaro 96Boards specification. 
  + Ultra96-V2 : updates and refreshes the Ultra96 product that was released in 2018.
  + KV260      : Kria KV260 Vision AI Startar Kit.
* Boot Loader
  + FSBL(First Stage Boot Loader for ZynqMP)
  + PMU Firmware(Platform Management Unit Firmware)
  + BL31(ARM Trusted Firmware Boot Loader stage 3-1)
  + U-Boot xilinx-v2019.2 (customized)
* Linux Kernel Version v5.10.0
  + [linux-xlnx](https://github.com/Xilinx/linux-xlnx) tag=xilinx-v2021.1
  + Enable Device Tree Overlay with Configuration File System
  + Enable FPGA Manager
  + Enable FPGA Bridge
  + Enable FPGA Reagion
  + Enable ATWILC3000 Linux Driver for Ultra96-V2
  + Enable CIFS (Common Internet File System)
  + Enable Xilinx APF Accelerator driver
  + Enable Xilinx APF DMA engines support
* Ubuntu20.04(focal) Desktop Root File System
  + Installed build-essential
  + Installed ubuntu-desktop
  + Installed lightdm
  + Installed ruby python python3
  + Installed Other package list -> [files/ubuntu20.04-desktop-dpkg-list.txt](files/ubuntu20.04-desktop-dpkg-list.txt)

Install
------------------------------------------------------------------------------------

### Install to SD-Card

* [Ultra96](doc/install/ultra96-desktop.md)
* [Ultra96-V2](doc/install/ultra96v2-desktop.md)
* [KV260](doc/install/kv260-desktop.md)

### Setup Ultra96/Ultra96-V2/KV260 borad

* Put the SD-Card in the slot on Ultra96/Ultra96-V2/Kv260.
* Plug in your Display Port monitor into the Ultra96 using the mini Display Port connector.
* Plug in a USB mouse and USB keyboard into the USB ports of the Ultra96/Ultra96-V2/Kv260.

### Starting Ultra96/Ultra96-V2/KV260 board

* Turn on the Ultra96/Ultra96-V2/KV260.
* After a few seconds, the Ubuntu login screen will appear on the display.
* Your username is "fpga". Password is set to "fpga". Please login.
* The password for administrator rights is "admin".

FAQ
------------------------------------------------------------------------------------

* [Change system console](doc/faq/change_system_console.md)
* [Change boot runlevel](doc/faq/change_boot_runlevel.md)

Build 
------------------------------------------------------------------------------------

* Build Boot Loader
  + [Ultra96](doc/build/ultra96-boot.md)
  + [Ultra96-V2](doc/build/ultra96v2-boot.md)
* [Build Linux Kernel](doc/build/linux-kernel.md)
* [Build Ubuntu 20.04 Desktop RootFS](doc/build/ubuntu20.04-desktop.md)
