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

```
shell$ cd $(XLNK_KERNEL_MODULE_PATH)/build
shell$ export ARCH=arm
shell$ export CROSS_COMPILE=arm-linux-gnueabihf-
shell$ export KERNEL_SRC_DIR=<kernel-source-direcotory>
shell$ make
```

