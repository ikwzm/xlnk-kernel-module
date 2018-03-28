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
```

### Replace Makefile and Add arch_setup_dma_ops.c

```console
shell$ cd $(XLNK_KERNEL_MODULE_PATH)
shell$ cp ./files/Makefile ./build
shell$ cp ./files/arch_setup_dma_ops.c ./build
```

### git add source files

```console
shell$ cd $(XLNK_KERNEL_MODULE_PATH)
shell$ git add ./build/Kconfig ./build/Makefile ./build/*.[ch]
shell$ git commit -m "[add] xlnk source files."
```

## Build

### Self Compile

```console
shell$ cd $(XLNK_KERNEL_MODULE_PATH)/build
shell$ make
```

### Cross Compile

```
shell$ export ARCH=arm
shell$ export CROSS_COMPILE=arm-linux-gnueabihf-
shell$ export KERNEL_SRC_DIR=<kernel-source-direcotory>
shell$ cd $(XLNK_KERNEL_MODULE_PATH)/build
shell$ make
```

