
CTAGS = /usr/local/bin/ctags
CTAGS_FLAGS = -R --langmap="ObjC:.m .h" --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q

FULL_PATH_TO_DEBUG_APP = "/Users/paulhoffman/Source/Pilates Postural Analysis Checklist/build/Debug-iphoneos/Pilates Postural Analysis Checklist.app"
FULL_PATH_TO_DEBUG_IPA = "/Users/paulhoffman/Source/Pilates Postural Analysis Checklist/build/Debug-iphoneos/Pilates Postural Analysis Checklist.ipa"


FULL_PATH_TO_RELEASE_APP =   "/Users/paulhoffman/Source/Pilates Postural Analysis Checklist/build/Release-iphoneos/Pilates Postural Analysis Checklist.app"
FULL_PATH_TO_RELEASE_IPA =  "/Users/paulhoffman/Source/Pilates Postural Analysis Checklist/build/Release-iphoneos/Pilates Postural Analysis Checklist.ipa"

xxSDKVERSION = iphonesimulator8.1
# xxSDKVERSION = iphonesimulator6.1
# xxSDKVERSION = iphoneos4.2

xxARCHS = i386
xxTARGET = "Pilates Postural Analysis Checklist"

all:
	xcodebuild -sdk $(xxSDKVERSION) -target $(xxTARGET) -configuration Debug

clean:
	xcodebuild -configuration Debug -sdk $(xxSDKVERSION) -target $(xxTARGET) VALID_ARCHS=$(xxARCHS) clean
	xcodebuild -configuration Release -sdk $(xxSDKVERSION) -target $(xxTARGET) VALID_ARCHS=$(xxARCHS) clean
	xcodebuild -configuration Debug -sdk iphoneos8.1 -target $(xxTARGET) clean
	xcodebuild -configuration Release -sdk iphoneos8.1 -target $(xxTARGET) clean
	-rm Classes/*backup.*
	-rm Classes/*backup~
	-rm $(FULL_PATH_TO_DEBUG_APP)
	-rm $(FULL_PATH_TO_DEBUG_IPA)
	-rm $(FULL_PATH_TO_RELEASE_APP)
	-rm $(FULL_PATH_TO_RELEASE_IPA)

pretty:
	uncrustify -c default.cfg -l OC+ --replace Pilates\ Postural\ Analysis\ Checklist/*.m Pilates\ Postural\ Analysis\ Checklist/*.h

ctags:
	$(CTAGS) $(CTAGS_FLAGS)

run: all
	$(IPHONESIM) $(IPHONESIM_FLAGS) $(IPHONESIM_APP_PATH) 


device:
	xcodebuild -sdk iphoneos8.1 -target $(xxTARGET) -configuration Debug 
	/usr/bin/xcrun -sdk iphoneos8.1 PackageApplication -v $(FULL_PATH_TO_DEBUG_APP) -o $(FULL_PATH_TO_DEBUG_IPA)

#	/usr/bin/xcrun -sdk iphoneos8.0 PackageApplication -v "/Users/paulhoffman/Library/Developer/Xcode/DerivedData/MobileSalesMagic-dsvgnobnhlrwvwgewrseoviwoicw/Build/Products/Debug-iphoneos/SalesMagic.app" -o "/Users/paulhoffman/Source/MSM - iPad/MobileSalesMagic/build/Debug-iphoneos/SalesMagic.ipa"

release:
	xcodebuild -sdk iphoneos8.1 -target $(xxTARGET) -configuration Release 
	/usr/bin/xcrun -sdk iphoneos8.1 PackageApplication -v $(FULL_PATH_TO_RELEASE_APP) -o $(FULL_PATH_TO_RELEASE_IPA)

