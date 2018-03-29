xlnk kernel module
==================

"xlnk" is Xilinx APF Accelerator driver.

This repository provides an environment for building "xlnk" as a kernel module.

## How to make ./build directory

set XLNK_KERNEL_MODULE_PATH to this repository path.

### Get source files from git://github.com/xilinx/linux-xlnk

```console
shell$ git clone git://github.com/xilinx/linux-xlnk
shell$ cd linux-xlnk
shell$ git checkout ebb848efc1cf6a6d63565e09888e56d9928965f6
shell$ cp drivers/staging/apf/*  $(XLNK_KERNEL_MODULE_PATH)/build/
shell$ cd $(XLNK_KERNEL_MODULE_PATH)
shell$ git add build/*
shell$ git commit -m "[add] source files from git://github.com/xilinx/linux-xlnk.git (commit=ebb848e)"
```

### Replace Makefile and Add arch_setup_dma_ops.c

```console
shell$ cd $(XLNK_KERNEL_MODULE_PATH)
shell$ cp ./files/arch_setup_dma_ops.c ./build
shell$ git add ./build/arch_setup_dma_ops.c
shell$ git commit -m "[add] build/arch_setup_dma_ops.c"
shell$ cp ./files/Makefile ./build
shell$ git add build/Makefile
shell$ git commit -m "[replace] build/Makefile"
```

### git add source files

```console
shell$ cd $(XLNK_KERNEL_MODULE_PATH)
shell$ git add ./build/Kconfig ./build/Makefile ./build/*.[ch]
shell$ git commit -m "[add] xlnk source files."
```

## Build kernel modules

### Self compile

```console
shell$ cd $(XLNK_KERNEL_MODULE_PATH)/build
shell$ make
```

### Cross compile

```console
shell$ cd $(XLNK_KERNEL_MODULE_PATH)/build
shell$ export ARCH=arm
shell$ export CROSS_COMPILE=arm-linux-gnueabihf-
shell$ export KERNEL_SRC_DIR=<kernel-source-direcotory>
shell$ make
```

## Debian Package for FPGA-SoC-Linux

https://github.com/ikwzm/FPGA-SoC-Linux

### Build Debian Package 

#### Self Compile

```console
shell$ cd $(XLNK_KERNEL_MODULE_PATH)/build
shell$ sudo debian/rules binary 
```

#### Cross Compile

```console
shell$ cd $(XLNK_KERNEL_MODULE_PATH)/build
shell$ sudo debian/rules KERNEL_SRC_DIR=<kernel-source-direcotory> binary 
```

### Install Debian Package

```console
shell$ dpkg -i xlnk-kernel-module-4.14.21-armv7-fpga_0.0.1-1_arm.deb
(Reading database ... 94083 files and directories currently installed.)
Preparing to unpack xlnk-kernel-module-4.14.21-armv7-fpga_0.0.1-1_armhf.deb ...
Unpacking xlnk-kernel-module-4.14.21-armv7-fpga (0.0.1-1) over (0.0.1-1) ...
Setting up xlnk-kernel-module-4.14.21-armv7-fpga (0.0.1-1) ...
Created symlink /etc/systemd/system/multi-user.target.wants/xilinx-apf-driver.service → /etc/systemd/system/xilinx-apf-driver.service.

shell$ lsmod
Module                  Size  Used by
xlnk_apf              135168  0
xlnk_dma               20480  1 xlnk_apf
xlnk_eng               16384  0

shell$ systemctl status xilinx-apf-driver.service
● xilinx-apf-driver.service - Xilinx APF Driver Service.
   Loaded: loaded (/etc/systemd/system/xilinx-apf-driver.service; enabled; vendo
   Active: active (exited) since Thu 2018-03-29 01:11:17 JST; 45s ago
  Process: 4212 ExecStart=/sbin/modprobe xlnk-apf (code=exited, status=0/SUCCESS
  Process: 4208 ExecStart=/sbin/modprobe xlnk-dma (code=exited, status=0/SUCCESS
  Process: 4204 ExecStart=/sbin/modprobe xlnk-eng (code=exited, status=0/SUCCESS
 Main PID: 4212 (code=exited, status=0/SUCCESS)

Mar 29 01:11:17 ikwzm-zybo-z7 systemd[1]: Starting Xilinx APF Driver Service....
Mar 29 01:11:17 ikwzm-zybo-z7 systemd[1]: Started Xilinx APF Driver Service..
```

### Remove Debian Package

```console
shell$ dpkg -r xlnk-kernel-module-4.14.21-armv7-fpga
(Reading database ... 94083 files and directories currently installed.)
Removing xlnk-kernel-module-4.14.21-armv7-fpga (0.0.1-1) ...
Removed /etc/systemd/system/multi-user.target.wants/xilinx-apf-driver.service.
```

