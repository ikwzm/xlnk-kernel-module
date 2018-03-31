prefix         ?= 
curr_dir       ?= $(shell pwd)
kernel_release ?= $(shell uname -r)
lib_dir        ?= $(prefix)/lib/modules/$(kernel_release)/xilinx
arch           ?= arm
kernel_src_dir ?= /lib/modules/$(kernel_release)/build

kmod_objects   += build/xlnk-apf.ko
kmod_objects   += build/xlnk-dma.ko
kmod_objects   += build/xlnk-eng.ko

.PHONY: all install

all:
	cd ./build ; $(MAKE) ARCH=$(arch) KERNEL_SRC_DIR=$(kernel_src_dir) all   ; cd $(curr_dir)

clean:
	cd ./build ; $(MAKE) ARCH=$(arch) KERNEL_SRC_DIR=$(kernel_src_dir) clean ; cd $(curr_dir) 

install: all
	install -d $(lib_dir)
	for ko in $(kmod_objects); do install -m 0644 $$ko $(lib_dir) ; done
	install -d $(prefix)/etc/systemd/system
	install -m 0644 systemd/xilinx-apf-driver.service $(prefix)/etc/systemd/system/

