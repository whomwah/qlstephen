//
//  URLChecker
//  QuickLookStephen
//
//  Created by Guillermo Enriquez on 5/24/12.
//  Copyright (c) 2012 nacho4d. All rights reserved.
//

#import "URLChecker.h"
#import <Foundation/Foundation.h>

bool shouldProcessItem(CFURLRef itemURL, CFBundleRef bundle)
{
	NSURL *url = (NSURL *)itemURL;

	// Allow these files always, no matter what
	NSURL *whiteListURL = (NSURL *)CFBundleCopyResourceURL(bundle, CFSTR("QLStephenWhiteList"), CFSTR("plist"), NULL);
	NSArray *whiteList = [NSArray arrayWithContentsOfURL:whiteListURL];
	[whiteListURL release];
	if ([whiteList containsObject:[url lastPathComponent]]) {
		return true;
	}

	NSString *extension = [url pathExtension];

	// Filter file with certain extensions
	NSURL *extBlackListURL = (NSURL *)CFBundleCopyResourceURL(bundle, CFSTR("QLStephenExtensionsBlackList"), CFSTR("plist"), NULL);
	NSArray *extBlackList = [NSArray arrayWithContentsOfURL:extBlackListURL];
	[extBlackListURL release];
	if ([extBlackList containsObject:extension]) {
		return false;
	}

	// Filter files inside folders with certain names
	NSArray *components = [[url path] pathComponents];
	if (components.count > 1) {
		NSURL *dirBlackListURL = (NSURL *)CFBundleCopyResourceURL(bundle, CFSTR("QLStephenDirectoriesBlackList"), CFSTR("plist"), NULL);
		NSArray *dirBlackList = [NSArray arrayWithContentsOfURL:dirBlackListURL];
		[dirBlackListURL release];
		NSString *folder = [components objectAtIndex:components.count - 2];
		if ([dirBlackList containsObject:folder]) {
			return false;
		}
	}

	// For all other files do it!
	return true;
}