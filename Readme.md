xlnk kernel module
==================

"xlnk" is Xilinx APF Accelerator driver.

This repository provides an environment for building "xlnk" as a kernel module.


Build and Install in self environment of FPGA-SoC-Linux(4.14.21-armv7-fpga)
---------------------------------------------------------------------------

https://github.com/ikwzm/FPGA-SoC-Linux

### Download repository

```console
shell$ git clone git://github.com/ikwzm/xlnk-kernel-module
shell$ cd xlnk-kernel-module
```

### Checkout 4.14.21-armv7-fpga

```console
shell$ git checkout 4.14.21-armv7-fpga
```

### Build

```console
shell$ make
cd ./build ; make ARCH=arm KERNEL_SRC_DIR=/lib/modules/4.14.21-armv7-fpga/build all   ; cd /root/work/xlnk-kernel-module
make[1]: Entering directory '/root/work/xlnk-kernel-module/build'
make -C /lib/modules/4.14.21-armv7-fpga/build ARCH=arm CROSS_COMPILE= M=/root/work/xlnk-kernel-module/build modules
make[2]: Entering directory '/usr/src/linux-headers-4.14.21-armv7-fpga'
  CC [M]  /root/work/xlnk-kernel-module/build/xlnk.o
  CC [M]  /root/work/xlnk-kernel-module/build/xlnk-config.o
  LD [M]  /root/work/xlnk-kernel-module/build/xlnk-apf.o
  CC [M]  /root/work/xlnk-kernel-module/build/xlnk-eng.o
  CC [M]  /root/work/xlnk-kernel-module/build/xilinx-dma-apf.o
  CC [M]  /root/work/xlnk-kernel-module/build/arch_setup_dma_ops.o
  LD [M]  /root/work/xlnk-kernel-module/build/xlnk-dma.o
  Building modules, stage 2.
  MODPOST 3 modules
  CC      /root/work/xlnk-kernel-module/build/xlnk-apf.mod.o
  LD [M]  /root/work/xlnk-kernel-module/build/xlnk-apf.ko
  CC      /root/work/xlnk-kernel-module/build/xlnk-dma.mod.o
  LD [M]  /root/work/xlnk-kernel-module/build/xlnk-dma.ko
  CC      /root/work/xlnk-kernel-module/build/xlnk-eng.mod.o
  LD [M]  /root/work/xlnk-kernel-module/build/xlnk-eng.ko
make[2]: Leaving directory '/usr/src/linux-headers-4.14.21-armv7-fpga'
make[1]: Leaving directory '/root/work/xlnk-kernel-module/build'
```

### Install

```console
shell$ sudo make install
cd ./build ; make ARCH=arm KERNEL_SRC_DIR=/lib/modules/4.14.21-armv7-fpga/build all   ; cd /root/work/xlnk-kernel-module
make[1]: Entering directory '/root/work/xlnk-kernel-module/build'
make -C /lib/modules/4.14.21-armv7-fpga/build ARCH=arm CROSS_COMPILE= M=/root/work/xlnk-kernel-module/build modules
make[2]: Entering directory '/usr/src/linux-headers-4.14.21-armv7-fpga'
  Building modules, stage 2.
  MODPOST 3 modules
make[2]: Leaving directory '/usr/src/linux-headers-4.14.21-armv7-fpga'
make[1]: Leaving directory '/root/work/xlnk-kernel-module/build'
install -d /lib/modules/4.14.21-armv7-fpga/xilinx
for ko in build/xlnk-apf.ko build/xlnk-dma.ko build/xlnk-eng.ko; do install -m 0644 $ko /lib/modules/4.14.21-armv7-fpga/xilinx ; done
install -d /etc/systemd/system
install -m 0644 systemd/xilinx-apf-driver.service /etc/systemd/system/

shell$ sudo depmod
shell$ sudo systemctl start  xilinx-apf-driver.service
shell$ sudo systemctl enable xilinx-apf-driver.service
Created symlink /etc/systemd/system/multi-user.target.wants/xilinx-apf-driver.service → /etc/systemd/system/xilinx-apf-driver.service.
```

### Uninstall

```console
shell$ sudo systemctl stop    xilinx-apf-driver.service
shell$ sudo systemctl disable xilinx-apf-driver.service
Removed /etc/systemd/system/multi-user.target.wants/xilinx-apf-driver.service.
shell$ sudo rmmod xlnk-apf
shell$ sudo rmmod xlnk-dma
shell$ sudo rmmod xlnk-eng
shell$ sudo rm /lib/modules/4.14.21-armv7-fpga/xilinx/xlnk-apf
shell$ sudo rm /lib/modules/4.14.21-armv7-fpga/xilinx/xlnk-dma
shell$ sudo rm /lib/modules/4.14.21-armv7-fpga/xilinx/xlnk-eng
```

Debian Package for FPGA-SoC-Linux
---------------------------------------------------------------------------

https://github.com/ikwzm/FPGA-SoC-Linux

### Download repository

```console
shell$ git clone git://github.com/ikwzm/xlnk-kernel-module
shell$ cd xlnk-kernel-module
```

### Checkout 4.14.21-armv7-fpga

```console
shell$ git checkout 4.14.21-armv7-fpga
```

### Build Debian Package 

#### Build in self environment

```console
shell$ sudo debian/rules binary 
```

#### Build in cross environment

```console
shell$ sudo debian/rules KERNEL_SRC_DIR=<kernel-source-direcotory> binary 
```

### Install Debian Package

```console
shell$ cd ..
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

How to make ./build directory
---------------------------------------------------------------------------

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

