#
# Makefile for i9100
#

# The original zip file, MUST be specified by each product
local-zip-file     := stockrom.zip

# The output zip file of MIUI rom, the default is porting_miui.zip if not specified
local-out-zip-file := MIUI_t320e.zip

# the location for local-ota to save target-file
local-previous-target-dir := ~/workspace/ota_base/i9100

# All apps from original ZIP, but has smali files chanded
local-modified-apps :=  Gallery2

local-modified-jars :=

# All apks from MIUI
local-miui-removed-apps := MediaProvider Stk

local-miui-modified-apps := MiuiHome Settings Phone Mms ThemeManager

# Config density for co-developers to use the aaps with HDPI or XHDPI resource,
# Default configrations are HDPI for ics branch and XHDPI for jellybean branch
local-density := HDPI

include phoneapps.mk

# To include the local targets before and after zip the final ZIP file, 
# and the local-targets should:
# (1) be defined after including porting.mk if using any global variable(see porting.mk)
# (2) the name should be leaded with local- to prevent any conflict with global targets
local-pre-zip := local-pre-zip-misc
local-after-zip:= local-put-to-phone

# The local targets after the zip file is generated, could include 'zip2sd' to 
# deliver the zip file to phone, or to customize other actions

include $(PORT_BUILD)/porting.mk

#myota: target_files
#	@echo ">>> To build out target file: myota.zip ..."
#	$(BUILD_TARGET_FILES) $(INCLUDE_THIRDPART_APP) miui_HOV_$(BUILD_NUMBER).zip
#	@echo "<<< build target file completed!"

# To define any local-target
updater := $(ZIP_DIR)/META-INF/com/google/android/updater-script
pre_install_data_packages := $(TMP_DIR)/pre_install_apk_pkgname.txt
local-pre-zip-misc:
	@echo Update boot image
	cp other/boot.img $(ZIP_DIR)/boot.img
#	@echo Add Cusettings
#	cp other/Cusettings.apk $(ZIP_DIR)/system/app/Cusettings.apk
#	@echo Add USB_switcher
#	cp other/GalaxyS2Settings.apk $(ZIP_DIR)/system/app/
#	cp other/Gallery2.apk $(ZIP_DIR)/system/app/
#	cp other/OriginalSettings.apk $(ZIP_DIR)/system/app/
#	cp -rf other/system_etc/* $(ZIP_DIR)/system/etc/
#	cp -rf other/system_lib/* $(ZIP_DIR)/system/lib/
#	cp other/platform.xml $(ZIP_DIR)/system/etc/permissions/platform.xml
#	cp other/javax.btobex.jar $(ZIP_DIR)/system/framework/javax.btobex.jar
#	cp other/Generic.kl $(ZIP_DIR)/system/usr/keylayout/
	cp other/spn-conf.xml $(ZIP_DIR)/system/etc/spn-conf.xml
	cp other/build.prop $(ZIP_DIR)/system/build.prop
	rm -rf $(pre_install_data_packages)
	for apk in $(ZIP_DIR)/data/media/preinstall_apps/*.apk; do\
		$(AAPT) d --values resources $$apk | grep 'id=127 packageCount' | sed -e "s/^.*name=//" >> $(pre_install_data_packages);\
	done
	more $(pre_install_data_packages) | wc -l > $(ZIP_DIR)/system/etc/enforcecopyinglibpackages.txt
	more $(pre_install_data_packages) >> $(ZIP_DIR)/system/etc/enforcecopyinglibpackages.txt

out/framework2.jar : out/framework.jar

%.phone : out/%.jar
	@echo push -- to --- phone
	adb remount
	adb push $< /system/framework
	adb shell chmod 644 /system/framework/$*.jar
	#adb shell stop
	#adb shell start
	#adb reboot

%.sign-plat : out/%
	java -jar $(TOOL_DIR)/signapk.jar $(PORT_ROOT)/build/security/platform.x509.pem $(PORT_ROOT)/build/security/platform.pk8  $< $<.signed
	@echo push -- to --- phone
	adb remount
	adb push $<.signed /system/app/$*
	adb shell chmod 644 /system/app/$*
