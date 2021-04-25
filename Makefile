.PHONY: QuickLookStephen debug clean

QuickLookStephen:
	xcodebuild SYMROOT=../build -project QuickLookStephenProject/QuickLookStephen.xcodeproj -configuration "Release" $(XC_OPTIONS) build

debug:
	xcodebuild SYMROOT=../build -project QuickLookStephenProject/QuickLookStephen.xcodeproj -configuration "Debug" $(XC_OPTIONS) build

install:
	@if [ -d  "./build/Release/QLStephen.qlgenerator" ]; then \
		rm -rf ~/Library/QuickLook/QLStephen.qlgenerator ; \
		mkdir -p ~/Library/QuickLook ; \
		cp -r ./build/Release/QLStephen.qlgenerator ~/Library/QuickLook/ ; \
		qlmanage -r ; \
	else \
		echo "Sorry, nothing to install. You might want to build it first. ;-)"; \
	fi

package:
	@if [ -d  "./build/Release/QLStephen.qlgenerator" ]; then \
		rm -rf "./build/Release/packaged" ; \
		mkdir "build/Release/packaged" ; \
		cd "build/Release" ; \
		zip -rX "./packaged/QLStephen.qlgenerator.VERSION.zip" "./QLStephen.qlgenerator" ; \
		sha256sum "./packaged/QLStephen.qlgenerator.VERSION.zip" ; \
	else \
		echo "Sorry, nothing to package. You might want to build it first. ;-)"; \
	fi

clean:
	@rm -rf ./build
