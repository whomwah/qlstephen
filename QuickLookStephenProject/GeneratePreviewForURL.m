#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h>
#include <QuickLook/QuickLook.h>
#import <Foundation/Foundation.h>

#import "URLChecker.h"

// Generate a preview for the document with the given url
OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, 
                               CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options)
{    
    if (QLPreviewRequestIsCancelled(preview))
        return noErr;
    
	CFBundleRef bundle = QLPreviewRequestGetGeneratorBundle(preview);
	if (!shouldProcessItem(url, bundle))
		return noErr;

    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSMutableDictionary *props = [[NSMutableDictionary alloc] init];
    [props setObject:@"text/plain" forKey:(NSString *)kQLPreviewPropertyMIMETypeKey];
    [props setObject:[NSNumber numberWithInt:700] forKey:(NSString *)kQLPreviewPropertyWidthKey];
    [props setObject:[NSNumber numberWithInt:800] forKey:(NSString *)kQLPreviewPropertyHeightKey];
    
    NSStringEncoding encodingUsed;
    NSString *text = [NSString stringWithContentsOfURL:(NSURL *)url
                                          usedEncoding:&encodingUsed 
                                                 error:nil];
    
    // If the encoding could not be determined using usedEncoding, try Latin1
    if (text == nil)
    {
        text = [NSString stringWithContentsOfURL:(NSURL *)url
                                        encoding:NSISOLatin1StringEncoding 
                                           error:nil];
        encodingUsed = NSISOLatin1StringEncoding;
    }
    
    QLPreviewRequestSetDataRepresentation(
                                          preview,
                                          (CFDataRef)[text dataUsingEncoding:encodingUsed],
                                          kUTTypePlainText,
                                          (CFDictionaryRef)props);
    
    
    [pool release];
    
    return noErr;
}

void CancelPreviewGeneration(void* thisInterface, QLPreviewRequestRef preview)
{
    // implement only if supported
}
