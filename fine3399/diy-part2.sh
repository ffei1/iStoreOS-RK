#!/bin/bash
#===============================================
# Description: DIY script
# File name: diy-script.sh
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#===============================================


#移植设备
# linux/rockchip/image/armv8.mk添加fnet-3399设备型号
sed -i 's/include legacy\.mk/define Device\/rumu3f_fine-3399\n  DEVICE_VENDOR := RUMU3F\n  DEVICE_MODEL := FINE 3399\n  SOC := rk3399\n  DEVICE_PACKAGES := kmod-usb-net-rtl8152\n  DEVICE_DTS_DIR := \.\.\/dts\n  DEVICE_DTS = rk3399\/rk3399-fine-3399\n  KERNEL = kernel-bin | lzma | fit lzma \$\$(KDIR)\/image-rk3399-fine-3399\.dtb\nendef\nTARGET_DEVICES += rumu3f_fine-3399\n\ninclude legacy\.mk/' target/linux/rockchip/image/armv8.mk

# 复制修改好的uboot/Makefile到对应目录
cp -f $GITHUB_WORKSPACE/fine3399/uboot-rockchip/fine-3399-rk3399_defconfig package/boot/uboot-rockchip/src/configs/fine-3399-rk3399_defconfig

cp -f $GITHUB_WORKSPACE/fine3399/uboot-rockchip/Makefile package/boot/uboot-rockchip/Makefile

cp -f $GITHUB_WORKSPACE/fine3399/uboot-rockchip/rk3399-fine-3399.dts package/boot/uboot-rockchip/src/dts/upstream/src/arm64/rockchip/rk3399-fine-3399.dts

cp -f $GITHUB_WORKSPACE/fine3399/uboot-rockchip/rk3399-fine-3399-u-boot.dtsi package/boot/uboot-rockchip/src/arch/arm/dts/rk3399-fine-3399-u-boot.dtsi

# 复制patch到对应的目录
cp -f $GITHUB_WORKSPACE/fine3399/kernel-rockchip/init.sh target/linux/rockchip/armv8/base-files/lib/board/init.sh

cp -f $GITHUB_WORKSPACE/fine3399/kernel-rockchip/Makefile target/linux/rockchip/image/Makefile

cp -f $GITHUB_WORKSPACE/fine3399/kernel-rockchip/02_network target/linux/rockchip/armv8/base-files/etc/board.d/02_network

cp -f $GITHUB_WORKSPACE/fine3399/kernel-rockchip/rk3399-fine-3399.dts target/linux/rockchip/dts/rk3399/rk3399-fine-3399.dts


