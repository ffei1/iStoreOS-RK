#!/bin/bash
#===============================================
# Description: DIY script
# File name: diy-script.sh
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#===============================================


#移植设备linux/rockchip/image/legacy.mk添加设备型号
sed -i 's/TARGET_DEVICES += cyber_cyber3588-aib/TARGET_DEVICES += cyber_cyber3588-aib\n\ndefine Device\/embedfire_lubancat-5\n\$(call Device\/Legacy\/rk3588,\$(1))\n  DEVICE_VENDOR := Embedfire\n  DEVICE_MODEL := LubanCat 5\n  UBOOT_DEVICE_NAME := lubancat-5-rk3588\n  DEVICE_PACKAGES += kmod-ata-ahci-dwc kmod-nvme\nendef\nTARGET_DEVICES += embedfire_lubancat-5/' target/linux/rockchip/image/legacy.mk

#修改target/linux/rockchip/image/Makefile打包方式
# sed -i 's/dd if="\$(STAGING_DIR_IMAGE)"\/\$(UBOOT_DEVICE_NAME)-u-boot-rockchip\.bin of="\$\@" seek=64 conv=notrunc/dd if="$(STAGING_DIR_IMAGE)"\/$(UBOOT_DEVICE_NAME)-idbloader.img of="$@" seek=64 conv=notrunc\n    dd if="$(STAGING_DIR_IMAGE)"\/$(UBOOT_DEVICE_NAME)-u-boot.itb of="$@" seek=16384 conv=notrunc/' target/linux/rockchip/image/Makefile

#修改package/boot/uboot-rockchip/Makefile添加uboot设备
sed -i '\#define U-Boot/sige7-rk3588# {
    :a; N; \#endef#!ba;
    s#endef#endef\n\ndefine U-Boot/lubancat-5-rk3588\n  $(U-Boot/rk3588/Default)\n  NAME:=LubanCat 5\n  BUILD_DEVICES:= \\\n    embedfire_lubancat-5\nendef#
}' package/boot/uboot-rockchip/Makefile
sed -i '/sige7-rk3588 \\/a\  lubancat-5-rk3588 \\' package/boot/uboot-rockchip/Makefile

#修改target/linux/rockchip/armv8/base-files/etc/board.d/02_network添加双网口
sed -i 's/radxa,e25|\\/radxa,e25|\\\n\tembedfire,lubancat-5|\\/' target/linux/rockchip/armv8/base-files/etc/board.d/02_network

#修改target/linux/rockchip/armv8/base-files/lib/board/init.sh添加中断
sed -i '/friendlyarm,nanopi-r4s-enterprise)/,/;;/ {
    /;;/ {
        a\	embedfire,lubancat-5)\
\		set_iface_cpumask 4 "eth0"\
\		set_iface_cpumask 8 "eth1"\
\		;;
    }
}' target/linux/rockchip/armv8/base-files/lib/board/init.sh

# 复制修改好的uboot/Makefile到对应目录
cp -f $GITHUB_WORKSPACE/lubancat-5/uboot-rockchip/lubancat-5-rk3588_defconfig package/boot/uboot-rockchip/src/configs/lubancat-5-rk3588_defconfig
cp -f $GITHUB_WORKSPACE/lubancat-5/uboot-rockchip/rk3588-lubancat-5.dts package/boot/uboot-rockchip/src/dts/upstream/src/arm64/rockchip/rk3588-lubancat-5.dts
cp -f $GITHUB_WORKSPACE/lubancat-5/uboot-rockchip/rk3588-lubancat-5-u-boot.dtsi package/boot/uboot-rockchip/src/arch/arm/dts/rk3588-lubancat-5-u-boot.dtsi

#cp -f $GITHUB_WORKSPACE/lubancat-5/uboot-rockchip/Makefile package/boot/uboot-rockchip/Makefile

# 复制dts和补丁到对应的目录
cp -f $GITHUB_WORKSPACE/lubancat-5/kernel-rockchip/813-ethernet-stmmac-Add-property-to-disable-VLAN-hw-filter.patch target/linux/rockchip/patches-6.6/813-ethernet-stmmac-Add-property-to-disable-VLAN-hw-filter.patch
cp -f $GITHUB_WORKSPACE/lubancat-5/kernel-rockchip/rk3588-lubancat-5.dts target/linux/rockchip/dts/rk3588/rk3588-lubancat-5.dts
cp -f $GITHUB_WORKSPACE/lubancat-5/kernel-rockchip/pwmfan target/linux/rockchip/armv8/base-files/etc/init.d/pwmfan
chmod 755 target/linux/rockchip/armv8/base-files/etc/init.d/pwmfan

mkdir -p target/linux/rockchip/armv8/base-files/usr/sbin
cp -f $GITHUB_WORKSPACE/lubancat-5/kernel-rockchip/dhcp-watchdog target/linux/rockchip/armv8/base-files/usr/sbin/dhcp-watchdog
cp -f $GITHUB_WORKSPACE/lubancat-5/kernel-rockchip/02-setup-cron target/linux/rockchip/armv8/base-files/etc/uci-defaults/02-setup-cron
chmod 755 target/linux/rockchip/armv8/base-files/usr/sbin/dhcp-watchdog
chmod 755 target/linux/rockchip/armv8/base-files/etc/uci-defaults/02-setup-cron
#cp -f $GITHUB_WORKSPACE/lubancat-5/kernel-rockchip/init.sh target/linux/rockchip/armv8/base-files/lib/board/init.sh
#cp -f $GITHUB_WORKSPACE/lubancat-5/kernel-rockchip/02_network target/linux/rockchip/armv8/base-files/etc/board.d/02_network
