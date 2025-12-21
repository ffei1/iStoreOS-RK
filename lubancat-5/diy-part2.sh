#!/bin/bash
#===============================================
# Description: DIY script
# File name: diy-script.sh
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#===============================================


#移植设备
# linux/rockchip/image/legacy.mk添加设备型号
echo -e '\ndefine Device/embedfire_lubancat-5\n$(call Device/Legacy/rk3588,$(1))\n  DEVICE_VENDOR := Embedfire\n  DEVICE_MODEL := LubanCat 5\n  UBOOT_DEVICE_NAME := lubancat-5-rk3588\n  DEVICE_PACKAGES += kmod-ata-ahci-dwc kmod-nvme\nendef\nTARGET_DEVICES += embedfire_lubancat-5' >> target/linux/rockchip/image/legacy.mk

# 复制修改好的uboot/Makefile到对应目录
cp -f $GITHUB_WORKSPACE/lubancat-5/uboot-rockchip/lubancat-5-rk3588_defconfig package/boot/uboot-rockchip/src/configs/lubancat-5-rk3588_defconfig

cp -f $GITHUB_WORKSPACE/lubancat-5/uboot-rockchip/Makefile package/boot/uboot-rockchip/Makefile

cp -f $GITHUB_WORKSPACE/lubancat-5/uboot-rockchip/rk3588-lubancat-5.dts package/boot/uboot-rockchip/src/dts/upstream/src/arm64/rockchip/rk3588-lubancat-5.dts

cp -f $GITHUB_WORKSPACE/lubancat-5/uboot-rockchip/rk3588-lubancat-5-u-boot.dtsi package/boot/uboot-rockchip/src/arch/arm/dts/rk3588-lubancat-5-u-boot.dtsi

# 复制patch到对应的目录
cp -f $GITHUB_WORKSPACE/lubancat-5/kernel-rockchip/init.sh target/linux/rockchip/armv8/base-files/lib/board/init.sh

cp -f $GITHUB_WORKSPACE/lubancat-5/kernel-rockchip/Makefile target/linux/rockchip/image/Makefile

cp -f $GITHUB_WORKSPACE/lubancat-5/kernel-rockchip/02_network target/linux/rockchip/armv8/base-files/etc/board.d/02_network

cp -f $GITHUB_WORKSPACE/lubancat-5/kernel-rockchip/813-ethernet-stmmac-Add-property-to-disable-VLAN-hw-filter.patch target/linux/rockchip/patches-6.6/813-ethernet-stmmac-Add-property-to-disable-VLAN-hw-filter.patch

cp -f $GITHUB_WORKSPACE/lubancat-5/kernel-rockchip/rk3588-lubancat-5.dts target/linux/rockchip/dts/rk3588/rk3588-lubancat-5.dts
