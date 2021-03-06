# make file for new hardware from 
#
LOCAL_PATH := $(call my-dir)
#
# this is here to use the pre-built kernel
#ifeq ($(TARGET_PREBUILT_KERNEL),true)
#TARGET_PREBUILT_KERNEL := $(LOCAL_PATH)/zImage.sv886x.bin
#endif

file := $(INSTALLED_KERNEL_TARGET)
ALL_PREBUILT += $(file)
$(file): $(TARGET_PREBUILT_KERNEL) | $(ACP)
	$(transform-prebuilt-to-target)


#
# copy keypad define
file := $(TARGET_OUT_KEYLAYOUT)/sk2852-ir.kl
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/sk2852-ir.kl | $(ACP)
	$(transform-prebuilt-to-target)

#move to below:  copy qwerty files:
#file := $(TARGET_OUT_KEYLAYOUT)/qwerty.kl
#ALL_PREBUILT += $(file)
#$(file) : $(LOCAL_PATH)/qwerty.kl | $(ACP)
#	$(transform-prebuilt-to-target)

#file := $(TARGET_OUT_KEYLAYOUT)/AVRCP.kl
#ALL_PREBUILT += $(file)
#$(file) : $(LOCAL_PATH)/AVRCP.kl | $(ACP)
#	$(transform-prebuilt-to-target)


#
# hardware specified init script
file := $(TARGET_ROOT_OUT)/init.skyviia.rc
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/init.skyviia.rc | $(ACP)
	$(transform-prebuilt-to-target)

# old style log file!
#file := $(TARGET_ROOT_OUT)/logo.rle
#ALL_PREBUILT += $(file)
#$(file) : $(LOCAL_PATH)/logo.rle | $(ACP)
#	$(transform-prebuilt-to-target)



# build the architecture specific stuff, and the board specific stuff
#-include vendor/qct/hgl/Android.mk

#
# no boot loader, so we don't need any of that stuff..  

include $(CLEAR_VARS)
LOCAL_SRC_FILES := sk2852-ir.kcm
include $(BUILD_KEY_CHAR_MAP)

#
# This will install the file in /system/etc
#include $(CLEAR_VARS)
#LOCAL_MODULE_CLASS := ETC
#LOCAL_MODULE := AudioFilter.csv
#LOCAL_SRC_FILES := $(LOCAL_MODULE)
#include $(BUILD_PREBUILT)

#include $(CLEAR_VARS)
#LOCAL_MODULE_CLASS := ETC
#LOCAL_MODULE := AudioPreProcess.csv
#LOCAL_SRC_FILES := $(LOCAL_MODULE)
#include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE := vold.fstab
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

# copy Tuxera NTFS kernel module 
include $(CLEAR_VARS)
LOCAL_MODULE := tntfs.ko
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT)/lib/modules
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

# copy paragon NTFS kernel module 
#include $(CLEAR_VARS)
#LOCAL_MODULE := ufsd.ko
#LOCAL_MODULE_CLASS := ETC
#LOCAL_MODULE_PATH := $(TARGET_OUT)/lib/modules
#LOCAL_SRC_FILES := $(LOCAL_MODULE)
#include $(BUILD_PREBUILT)

# copy RT3370 wifi kernel module
include $(CLEAR_VARS)
LOCAL_MODULE := rt3370sta.ko
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT)/lib/modules
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

# copy RT3572 wifi kernel module
include $(CLEAR_VARS)
LOCAL_MODULE := rt3572sta.ko
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT)/lib/modules
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

# copy USB gadget module
#include $(CLEAR_VARS)
#LOCAL_MODULE := g_file_storage.ko
#LOCAL_MODULE_CLASS := ETC
#LOCAL_MODULE_PATH := $(TARGET_OUT)/lib/modules
#LOCAL_SRC_FILES := $(LOCAL_MODULE)
#include $(BUILD_PREBUILT)

# copy USB gadget module
#include $(CLEAR_VARS)
#LOCAL_MODULE := sv886x-udc2-modules.ko
#LOCAL_MODULE_CLASS := ETC
#LOCAL_MODULE_PATH := $(TARGET_OUT)/lib/modules
#LOCAL_SRC_FILES := $(LOCAL_MODULE)
#include $(BUILD_PREBUILT)

# sjlin, copy USB gadget test file
include $(CLEAR_VARS)
LOCAL_MODULE := test.img
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT)/lib/modules
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

#
# build hardware modules
#include device/skyviia/sv886x/*****/Android.mk

#
include $(CLEAR_VARS)
# copy Wi-Fi & Networking related files:
# NOTE: system/etc/wifi/wpa_supplicant.conf is the template conf file for supplicant!
PRODUCT_COPY_FILES += \
    device/skyviia/sv8860-common/system/etc/dhcpcd/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
    device/skyviia/sv8860-common/system/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    device/skyviia/sv8860-common/RT2870STA.dat:system/etc/wifi/RT2870STA.dat \
    device/skyviia/sv8860-common/RT3572STA.dat:system/etc/wifi/RT3572STA.dat \
    device/skyviia/sv8860-common/data/system/wpa_supplicant/wpa_supplicant.conf:data/system/wpa_supplicant/wpa_supplicant.conf

# copy keylayout files:
PRODUCT_COPY_FILES += \
    device/skyviia/sv8860-common/qwerty.kl:system/usr/keylayout/qwerty.kl \
    device/skyviia/sv8860-common/system/usr/keylayout/qwertz102de.kl:system/usr/keylayout/default.kl \
    device/skyviia/sv8860-common/system/usr/keychars/qwertz102de.kcm.bin:system/usr/keychars/default.kcm.bin

# copy DMC related files:
PRODUCT_COPY_FILES += \
    device/skyviia/sv8860-common/system/bin/skyDMC:system/bin/skyDMC
    
# ifdef VOOLE_SUPPORT update mplayer	
ifeq ($(VOOLE_SUPPORT),true)
#    PRODUCT_COPY_FILES += \
#        device/skyviia/sv8860-common/codecs.conf.skdtshd2:system/etc/mplayer/codecs.conf
     PRODUCT_COPY_FILES += \
         device/skyviia/sv8860-common/system/bin/mplayer_voole:system/bin/mplayer \
		 device/skyviia/sv8860-common/system/shared_lib/libvooletv.so:system/lib/libvooletv.so
endif
    
# copy MPlayer related files:
PRODUCT_COPY_FILES += \
    device/skyviia/sv8860-common/system/bin/mplayer:system/bin/mplayer \
    device/skyviia/sv8860-common/system/bin/tsplayer:system/bin/tsplayer \
    device/skyviia/sv8860-common/system/bin/tsserver:system/bin/tsserver \
    device/skyviia/sv8860-common/system/bin/pvrserver:system/bin/pvrserver \
    device/skyviia/sv8860-common/system/bin/svsd:system/bin/svsd \
    device/skyviia/sv8860-common/system/bin/audio_server:system/bin/audio_server \
    device/skyviia/sv8860-common/system/bin/audio_server2:system/bin/audio_server2 \
    device/skyviia/sv8860-common/system/etc/mplayer/channels.conf:system/etc/mplayer/channels.conf \
    device/skyviia/sv8860-common/system/bin/mpserver:system/bin/mpserver \
    device/skyviia/sv8860-common/system/etc/record.conf:system/etc/record.conf \
    device/skyviia/sv8860-common/system/etc/nextrec.conf:system/etc/nextrec.conf \
    device/skyviia/sv8860-common/system/etc/timezone:system/etc/timezone \

# copy GUN-LibC related .so files:
PRODUCT_COPY_FILES += \
    device/skyviia/sv8860-common/system/shared_lib/ld-2.7.so:system/shared_lib/ld-2.7.so \
    device/skyviia/sv8860-common/system/shared_lib/libc-2.7.so:system/shared_lib/libc-2.7.so \
    device/skyviia/sv8860-common/system/shared_lib/libdl-2.7.so:system/shared_lib/libdl-2.7.so \
    device/skyviia/sv8860-common/system/shared_lib/libgcc_s.so.1:system/shared_lib/libgcc_s.so.1 \
    device/skyviia/sv8860-common/system/shared_lib/libm-2.7.so:system/shared_lib/libm-2.7.so \
    device/skyviia/sv8860-common/system/shared_lib/libpthread-2.7.so:system/shared_lib/libpthread-2.7.so \
    device/skyviia/sv8860-common/system/shared_lib/libcrypt-2.7.so:system/shared_lib/libcrypt-2.7.so \
    device/skyviia/sv8860-common/system/shared_lib/libnsl-2.7.so:system/shared_lib/libnsl-2.7.so \
    device/skyviia/sv8860-common/system/shared_lib/libnss_dns-2.7.so:system/shared_lib/libnss_dns-2.7.so \
    device/skyviia/sv8860-common/system/shared_lib/libnss_files-2.7.so:system/shared_lib/libnss_files-2.7.so \
    device/skyviia/sv8860-common/system/shared_lib/libresolv-2.7.so:system/shared_lib/libresolv-2.7.so \
    device/skyviia/sv8860-common/system/shared_lib/libutil-2.7.so:system/shared_lib/libutil-2.7.so \
    device/skyviia/sv8860-common/system/shared_lib/libskmp3_s.so:system/shared_lib/libskmp3_s.so \
    device/skyviia/sv8860-common/system/shared_lib/libstdc++.so.6.0.10:system/shared_lib/libstdc++.so.6.0.10 \
    device/skyviia/sv8860-common/system/shared_lib/librt-2.7.so:system/shared_lib/librt-2.7.so \
    device/skyviia/sv8860-common/system/shared_lib/libz.so.1.2.5:system/shared_lib/libz.so.1.2.5 \
    device/skyviia/sv8860-common/system/shared_lib/libpvr.so.1.0:system/shared_lib/libpvr.so.1.0

# copy work around and misc files!
PRODUCT_COPY_FILES += \
    device/skyviia/sv8860-common/ntp/ntp.conf_TW:system/etc/ntp.conf
#    device/skyviia/sv886x/sys_power/ac_online:root/sys_power/ac_online \
#    device/skyviia/sv886x/sys_power/battery_capacity:root/sys_power/battery_capacity \
#    device/skyviia/sv886x/sys_power/battery_health:root/sys_power/battery_health \
#    device/skyviia/sv886x/sys_power/battery_present:root/sys_power/battery_present \
#    device/skyviia/sv886x/sys_power/battery_status:root/sys_power/battery_status \
#    device/skyviia/sv886x/sys_power/battery_technology:root/sys_power/battery_technology \

# copy samba mount/umount tool.
#PRODUCT_COPY_FILES += \
#    device/skyviia/sv886x/system/bin/nmblookup:system/bin/nmblookup \
#    device/skyviia/sv886x/system/bin/smbtree:system/bin/smbtree \
#    device/skyviia/sv886x/system/bin/mount.cifs:system/bin/mount.cifs \
#    device/skyviia/sv886x/system/bin/umount.cifs:system/bin/umount.cifs

# Copy 3G dialing modem
#PRODUCT_COPY_FILES += \
#        device/skyviia/sv886x/system/bin/3Gcnt.sh:system/bin/3Gcnt.sh \
#        device/skyviia/sv886x/system/bin/chat:system/bin/chat \
#        device/skyviia/sv886x/system/bin/pppd:system/bin/pppd \
#        device/skyviia/sv886x/system/bin/run_3G:system/bin/run_3G \
#        device/skyviia/sv886x/system/etc/chat-isp-pin:system/etc/chat-isp-pin \
#        device/skyviia/sv886x/system/etc/chat-isp:system/etc/chat-isp

# copy fsck.hfs & blkid for vold
PRODUCT_COPY_FILES += \
    device/skyviia/sv8860-common/system/bin/fsck_hfs:system/bin/fsck_hfs \
    device/skyviia/sv8860-common/system/bin/blkid:system/bin/blkid

# copy reg bin file for display tool
PRODUCT_COPY_FILES += \
    device/skyviia/sv8860-common/system/bin/reg:system/bin/reg \
    device/skyviia/sv8860-common/system/bin/testmplayer:system/bin/testmplayer    
    
## copy boot animation file:
#PRODUCT_COPY_FILES += \
#    device/skyviia/sv886x/boot_animation.avi:root/boot_animation.avi

# copy configuration file for firmware packing
#PRODUCT_COPY_FILES += \
#    device/skyviia/sv886x/fw_config.txt:fw_config.txt

# copy not_support image file for PhotoViewer
PRODUCT_COPY_FILES += \
    device/skyviia/sv8860-common/system/etc/not_support.jpg:system/etc/not_support.jpg

# copy samba config file for smbtree
PRODUCT_COPY_FILES += \
    device/skyviia/sv8860-common/system/etc/samba/lib/smb.conf:system/etc/samba/lib/smb.conf

ifeq ($(AUDIO_CERT),true)
#    PRODUCT_COPY_FILES += \
#        device/skyviia/sv8860-common/codecs.conf.skdtshd2:system/etc/mplayer/codecs.conf
     DEVICE_PACKAGE_OVERLAYS += \
         device/skyviia/sv8860-common/audio_cert_overlay
endif

#open set mac address item 
ifeq ($(ETH_MAC),true)
    DEVICE_PACKAGE_OVERLAYS += \
        device/skyviia/sv8860-common/ethnet_macaddress_overlay
endif

# copy new channels.conf !
# Minchay_0026 20110526 !
PRODUCT_COPY_FILES += \
	device/skyviia/sv8860-common/channels.conf:system/etc/channels.conf

# copy debug tools
PRODUCT_COPY_FILES += \
    device/skyviia/sv8860-common/system/bin/skyps:system/bin/skyps \
    device/skyviia/sv8860-common/system/bin/skyvmstat:system/bin/skyvmstat \
    device/skyviia/sv8860-common/system/bin/skypmap:system/bin/skypmap

# copy PPPoE tools
PRODUCT_COPY_FILES += \
    device/skyviia/sv8860-common/system/bin/pppd:system/bin/pppd \
    device/skyviia/sv8860-common/system/bin/pppoe:system/bin/pppoe \
    device/skyviia/sv8860-common/data/system/ppp/options:data/system/ppp/options \
    device/skyviia/sv8860-common/system/etc/ppp/options:system/etc/ppp/options
