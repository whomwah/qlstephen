.PHONY: QuickLookStephen debug clean

QuickLookStephen:
	xcodebuild SYMROOT=../build -project QuickLookStephenProject/QuickLookStephen.xcodeproj -configuration "Release" $(XC_OPTIONS) build

debug:
	xcodebuild SYMROOT=../build -project QuickLookStephenProject/QuickLookStephen.xcodeproj -configuration "Debug" $(XC_OPTIONS) build

install:
	@if [ -d  "./build/Release/QLStephen.qlgenerator" ]; then \
		rm -rf ~/Library/QuickLook/QLStephen.qlgenerator ; \
		cp -r ./build/Release/QLStephen.qlgenerator ~/Library/QuickLook/ ; \
		qlmanage -r ; \
	else \
		echo "Sorry, nothing to install. You might want to build it first. ;-)"; \
	fi

clean:
	@rm -rf ./build
