static:
	cd vendor/tidy-html5
	# build mac
	cmake --build . --config Release --target tidy-static
	# setup ios
	cmake -S . -B _builds -GXcode \                            
		-DCMAKE_SYSTEM_NAME=iOS -DCMAKE_XCODE_ATTRIBUTE_DEVELOPMENT_TEAM="" \
    	"-DCMAKE_OSX_ARCHITECTURES=armv7;armv7s;arm64;i386;x86_64" \
    	-DCMAKE_OSX_DEPLOYMENT_TARGET=9.3 \
    	-DCMAKE_INSTALL_PREFIX=`pwd`/_install \
    	-DCMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH=NO \
    	-DCMAKE_IOS_INSTALL_COMBINED=YES
	# build ios
	cmake --build _builds --config Release --target tidy-static
	# build ios simulator
	cmake --build _builds --config Release --target tidy-static -- -sdk iphonesimulator 
	# copy custom module map
	cp ../module.modulemap include
	# create xcframework
	xcodebuild -create-xcframework \
		-library _builds/Release-iphoneos/libtidys.a \
		-headers include \
		-library _builds/Release-iphonesimulator/libtidys.a \
		-headers include \
		-library build/cmake/libtidys.a \
		-headers include \
		-output ../Tidy.xcframework
