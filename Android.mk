# Android.mk.  Manually derived by running 'configure' using options
#     --enable-pcsc --prefix=/system --sysconfdir=/etc
# on Ubuntu 10.04 and capturing the actions taken by make.
#

# Copyright (C) 2010  Free Software Foundation, Inc.
# This Android.mk is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.

LOCAL_MODULE := opensc
LOCAL_PATH   := $(call my-dir)


common_cflags := \
	-DANDROID \
	-DHAVE_CONFIG_H \
	-Wall -fno-common -g -O2


#-fvisibility=hidden - ToDo: restrict to explicitely exported functions


common_c_includes := \
	$(LOCAL_PATH) \
	$(LOCAL_PATH)/src/common \
	$(LOCAL_PATH)/src/libopensc \
	$(LOCAL_PATH)/src/pkcs11 \
	$(LOCAL_PATH)/src/pkcs15init \
	$(LOCAL_PATH)/src/scconf \
	$(LOCAL_PATH)/src/signer \
	$(LOCAL_PATH)/src/signer/npinclude \
	$(LOCAL_PATH)/src/tests \
	$(LOCAL_PATH)/src/tools \
	$(LOCAL_PATH)/src/include \
	external/openssl/include \
	external/pcsc/pcsc-lite/src/PCSC


# ============ copy opensc.conf and some profiles ===================
include $(CLEAR_VARS)
PRODUCT_COPY_FILES +=$(LOCAL_PATH)/etc/opensc.conf:system/etc/opensc.conf
PRODUCT_COPY_FILES +=$(LOCAL_PATH)/src/pkcs15init/muscle.profile:system/etc/muscle.profile
PRODUCT_COPY_FILES +=$(LOCAL_PATH)/src/pkcs15init/pkcs15.profile:system/etc/pkcs15.profile
PRODUCT_COPY_FILES +=$(LOCAL_PATH)/src/pkcs15init/jcop.profile:system/etc/jcop.profile
PRODUCT_COPY_FILES +=$(LOCAL_PATH)/src/pkcs15init/oberthur.profile:system/etc/oberthur
PRODUCT_COPY_FILES +=$(LOCAL_PATH)/src/pkcs15init/cyberflex.profile:system/etc/cyberflex

# ============ build libcompat.a ====================================

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	src/common/compat_dummy.c \
	src/common/compat_strlcpy.c \
	src/common/compat_getpass.c \
	src/common/compat_getopt.c 

LOCAL_CFLAGS		:= $(common_cflags) \
	-DANDROID_TARGET

LOCAL_C_INCLUDES	:= $(common_c_includes)
LOCAL_PRELINK_MODULE	:= false
LOCAL_MODULE		:= libcompat

include $(BUILD_STATIC_LIBRARY)


# ============ build libscconf.a ====================================

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	src/scconf/scconf.c \
	src/scconf/parse.c \
	src/scconf/write.c \
	src/scconf/sclex.c \
	src/common/compat_dummy.c \
	src/common/compat_getopt.c  \
	src/common/compat_strlcpy.c \
	src/common/compat_getpass.c 


LOCAL_CFLAGS		:= $(common_cflags) \
	-DANDROID_TARGET

LOCAL_C_INCLUDES	:= $(common_c_includes)
LOCAL_PRELINK_MODULE	:= false
LOCAL_MODULE		:= libscconf

include $(BUILD_STATIC_LIBRARY)


# ============ build libopensc.a ====================================

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	src/libopensc/sc.c \
	src/libopensc/card-rutoken.c \
	src/libopensc/card-incrypto34.c \
	src/libopensc/card-piv.c \
	src/libopensc/pkcs15-piv.c \
	src/libopensc/card-belpic.c \
	src/libopensc/pkcs15-cache.c \
	src/libopensc/pkcs15-tcos.c \
	src/libopensc/log.c \
	src/libopensc/pkcs15.c \
	src/libopensc/card-muscle.c \
	src/libopensc/card-jcop.c \
	src/libopensc/p15card-helper.c \
	src/libopensc/errors.c \
	src/libopensc/pkcs15-gemsafeV1.c \
	src/libopensc/pkcs15-gemsafeGPK.c \
	src/libopensc/pkcs15-algo.c \
	src/libopensc/ui.c \
	src/libopensc/ctx.c \
	src/libopensc/compression.c \
	src/libopensc/pkcs15-tccardos.c \
	src/libopensc/card-openpgp.c \
	src/libopensc/pkcs15-esteid.c \
	src/libopensc/muscle.c \
	src/libopensc/pkcs15-actalis.c \
	src/libopensc/card-default.c \
	src/libopensc/pkcs15-syn.c \
	src/libopensc/padding.c \
	src/libopensc/sec.c \
	src/libopensc/muscle-filesystem.c \
	src/libopensc/card.c \
	src/libopensc/ctbcs.c \
	src/libopensc/card-tcos.c \
	src/libopensc/card-myeid.c \
	src/libopensc/pkcs15-openpgp.c \
	src/libopensc/card-asepcos.c \
	src/libopensc/card-akis.c \
	src/libopensc/pkcs15-data.c \
	src/libopensc/iso7816.c \
	src/libopensc/pkcs15-postecert.c \
	src/libopensc/asn1.c \
	src/libopensc/pkcs15-cert.c \
	src/libopensc/card-westcos.c \
	src/libopensc/pkcs15-starcert.c \
	src/libopensc/pkcs15-sec.c \
	src/libopensc/emv.c \
	src/libopensc/reader-pcsc.c \
	src/libopensc/base64.c \
	src/libopensc/card-gemsafeV1.c \
	src/libopensc/reader-openct.c \
	src/libopensc/pkcs15-prkey.c \
	src/libopensc/pkcs15-atrust-acos.c \
	src/libopensc/reader-ctapi.c \
	src/libopensc/dir.c \
	src/libopensc/card-mcrd.c \
	src/libopensc/card-setcos.c \
	src/libopensc/apdu.c \
	src/libopensc/pkcs15-pin.c \
	src/libopensc/card-rtecp.c \
	src/libopensc/card-flex.c \
	src/libopensc/pkcs15-esinit.c \
	src/libopensc/card-entersafe.c \
	src/libopensc/card-atrust-acos.c \
	src/libopensc/card-oberthur.c \
	src/libopensc/pkcs15-infocamere.c \
	src/libopensc/card-emv.c \
	src/libopensc/card-acos5.c \
	src/libopensc/card-starcos.c \
	src/libopensc/pkcs15-wrap.c \
	src/libopensc/card-gpk.c \
	src/libopensc/pkcs15-pubkey.c \
	src/libopensc/card-cardos.c \
	src/libopensc/p15emu-westcos.c \
	src/libopensc/card-miocos.c \
	src/common/compat_dummy.c \
	src/common/compat_getopt.c  \
	src/common/compat_strlcpy.c \
	src/common/compat_getpass.c 




LOCAL_CFLAGS		:= $(common_cflags) \
	-DOPENSC_CONF_PATH=\"/etc/opensc.conf\" \
	-DANDROID_TARGET

LOCAL_C_INCLUDES	:= $(common_c_includes)
LOCAL_PRELINK_MODULE	:= false
LOCAL_STATIC_LIBRARIES	:= libpcsclite
LOCAL_MODULE		:= libopensc

include $(BUILD_STATIC_LIBRARY)

# ============ build libpkcs15init.a ====================================

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	src/pkcs15init/pkcs15-lib.c \
	src/pkcs15init/pkcs15-cardos.c \
	src/pkcs15init/pkcs15-jcop.c \
	src/pkcs15init/pkcs15-muscle.c \
	src/pkcs15init/keycache.c \
	src/pkcs15init/pkcs15-starcos.c \
	src/pkcs15init/profile.c \
	src/pkcs15init/pkcs15-asepcos.c \
	src/pkcs15init/pkcs15-westcos.c \
	src/pkcs15init/pkcs15-miocos.c \
	src/pkcs15init/pkcs15-gpk.c \
	src/pkcs15init/pkcs15-incrypto34.c \
	src/pkcs15init/pkcs15-cflex.c \
	src/pkcs15init/pkcs15-myeid.c \
	src/pkcs15init/pkcs15-oberthur.c \
	src/pkcs15init/pkcs15-setcos.c \
	src/pkcs15init/pkcs15-rutoken.c \
	src/pkcs15init/pkcs15-entersafe.c \
	src/pkcs15init/pkcs15-rtecp.c \
	src/common/compat_dummy.c \
	src/common/compat_getopt.c  \
	src/common/compat_strlcpy.c \
	src/common/compat_getpass.c 


LOCAL_CFLAGS		:= $(common_cflags) \
	-DSC_PKCS15_PROFILE_DIRECTORY=\"/usr/share/opensc\" \
	-DANDROID_TARGET

LOCAL_C_INCLUDES	:= $(common_c_includes)
LOCAL_PRELINK_MODULE	:= false
LOCAL_MODULE		:= libpkcs15init

include $(BUILD_STATIC_LIBRARY)


# ============ build libpkcs11.a ====================================

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	src/pkcs11/libpkcs11.c \

LOCAL_C_INCLUDES	:= $(common_c_includes)	
LOCAL_PRELINK_MODULE	:= false
LOCAL_CFLAGS		:= $(common_cflags) 
LOCAL_MODULE		:= libpkcs11  
include $(BUILD_STATIC_LIBRARY)


# ============ build opensc-pkcs11.so ====================================

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	src/pkcs11/pkcs11-global.c \
	src/pkcs11/pkcs11-session.c \
	src/pkcs11/pkcs11-object.c \
	src/pkcs11/misc.c \
	src/pkcs11/slot.c \
	src/pkcs11/mechanism.c \
	src/pkcs11/openssl.c \
	src/pkcs11/secretkey.c \
	src/pkcs11/framework-pkcs15.c \
	src/pkcs11/framework-pkcs15init.c \
	src/pkcs11/debug.c \
	src/pkcs11/hack-disabled.c \


LOCAL_C_INCLUDES	:= $(common_c_includes)	
LOCAL_PRELINK_MODULE	:= false
LOCAL_CFLAGS		:= $(common_cflags) 
LOCAL_SHARED_LIBRARIES := libcrypto libc libdl
LOCAL_STATIC_LIBRARIES := \
	libpkcs15init \
	libopensc \
	libscconf \
	libpcsclite 

LOCAL_MODULE		:= opensc-pkcs11  
LOCAL_MODULE_TAGS	:= optional
include $(BUILD_SHARED_LIBRARY)


# ============ build pkcs11-spy.so ====================================

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	src/pkcs11/pkcs11-spy.c \
	src/pkcs11/pkcs11-display.c 

LOCAL_C_INCLUDES	:= $(common_c_includes)	
LOCAL_PRELINK_MODULE	:= false
LOCAL_CFLAGS		:= $(common_cflags) 
LOCAL_LDLIBS		+= -L$(SYSROOT)/usr/lib -ldl 
LOCAL_SHARED_LIBRARIES :=  libcrypto libc libdl
LOCAL_STATIC_LIBRARIES := libpkcs11 
LOCAL_MODULE		:= pkcs11-spy
LOCAL_MODULE_TAGS	:= optional  
include $(BUILD_SHARED_LIBRARY)

# ============ build opensc-tool ====================================

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	src/tools/opensc-tool.c \
	src/tools/util.c \

LOCAL_C_INCLUDES	:= $(common_c_includes)	
LOCAL_PRELINK_MODULE	:= false
LOCAL_CFLAGS		:= $(common_cflags) 
LOCAL_LDLIBS		:= -ldl
LOCAL_SHARED_LIBRARIES := libc libcrypto libdl
LOCAL_STATIC_LIBRARIES := \
		libcompat \
		libopensc \
		libscconf \
		libpcsclite

LOCAL_MODULE		:= opensc-tool
LOCAL_MODULE_TAGS	:= optional
include $(BUILD_EXECUTABLE)

# ============ build pkcs11-tool ====================================

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	src/tools/pkcs11-tool.c \
	src/tools/util.c

LOCAL_C_INCLUDES	:= $(common_c_includes)	
LOCAL_PRELINK_MODULE	:= false
LOCAL_CFLAGS		:= $(common_cflags) 
LOCAL_SHARED_LIBRARIES := libc libcrypto libdl
LOCAL_STATIC_LIBRARIES := \
		libcompat \
		libopensc \
		libscconf \
		libpkcs11 \
		libpcsclite

LOCAL_MODULE		:= pkcs11-tool
LOCAL_MODULE_TAGS	:= optional
include $(BUILD_EXECUTABLE)


# ============ build pkcs15-tool ====================================

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	src/tools/pkcs15-tool.c \
	src/tools/util.c

LOCAL_C_INCLUDES	:= $(common_c_includes)	
LOCAL_PRELINK_MODULE	:= false
LOCAL_CFLAGS		:= $(common_cflags) 
LOCAL_SHARED_LIBRARIES := libc libcrypto libdl
LOCAL_STATIC_LIBRARIES := \
		libcompat \
		libopensc \
		libscconf \
		libpcsclite

LOCAL_MODULE		:= pkcs15-tool
LOCAL_MODULE_TAGS	:= optional
include $(BUILD_EXECUTABLE)


# ============ build pkcs15-init ====================================

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	src/tools/pkcs15-init.c \
	src/tools/util.c

LOCAL_C_INCLUDES	:= $(common_c_includes)	
LOCAL_PRELINK_MODULE	:= false
LOCAL_CFLAGS		:= $(common_cflags) 
LOCAL_SHARED_LIBRARIES := libc libcrypto libdl
LOCAL_STATIC_LIBRARIES := \
		libcompat \
		libopensc \
		libscconf \
		libpkcs15init \
		libpcsclite 

LOCAL_MODULE		:= pkcs15-init
LOCAL_MODULE_TAGS	:= optional
include $(BUILD_EXECUTABLE)

