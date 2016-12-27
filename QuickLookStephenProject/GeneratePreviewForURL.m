#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h>
#include <QuickLook/QuickLook.h>

#import <Foundation/Foundation.h>

#import "QLSFileAttributes.h"

#define DEFAULT_MAX_FILE_SIZE 1024 * 100
#define DEFAULT_FONT_SIZE "11px"
#define DEFAULT_LINE_HEIGHT "20px"
#define DEFAULT_FONT_FAMILY "Monaco"
#define QUOTE(...) #__VA_ARGS__
NSString *const kHTMLTemplate = @QUOTE(
  <html>
  <head>
    <title>%@</title>
    <style>
      body {
        font: normal normal %@/%@ '%@', monospace;
        white-space: pre-wrap;
      }
    </style>
  </head>
  <body>%@</body>
  </html>
);

// Generate a preview for the document with the given url
OSStatus GeneratePreviewForURL(void *thisInterface,
                               QLPreviewRequestRef request,
                               CFURLRef url,
                               CFStringRef contentTypeUTI,
                               CFDictionaryRef options) {
  @autoreleasepool {
    if (QLPreviewRequestIsCancelled(request))
      return noErr;

    QLSFileAttributes *magicAttributes =
        [QLSFileAttributes attributesForItemAtURL:(__bridge NSURL *)url];

    if (!magicAttributes) {
      NSLog(@"QLStephen: Could not determine attribtues of file %@", url);
      return noErr;
    }

    if (!magicAttributes.isTextFile) {
      return noErr;
    }

    if (magicAttributes.fileEncoding == kCFStringEncodingInvalidId) {
      NSLog(@"QLStephen: Could not determine encoding of file %@", url);
      return noErr;
    }

    NSDictionary *previewProperties = @{
      (NSString *)kQLPreviewPropertyStringEncodingKey : @( magicAttributes.fileEncoding ),
      (NSString *)kQLPreviewPropertyWidthKey      : @700,
      (NSString *)kQLPreviewPropertyHeightKey     : @800,
      (NSString *)kQLPreviewPropertyMIMETypeKey   : @"text/html",
    };

    // Get size of current File
    NSFileManager *man = [NSFileManager defaultManager];
    NSURL *file_url = (__bridge NSURL *)(url);
    NSDictionary *attrs = [man attributesOfItemAtPath: [file_url path] error: NULL];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    // the plugin is running as com.apple.quicklook.satellite therefore we need to load our own settings
    NSDictionary *defaults = [userDefaults persistentDomainForName:@"com.whomwah.quicklookstephen"];

    long long maxFileSizeSetting = [[defaults valueForKey:@"maxFileSize"] longLongValue];
    unsigned long long maxFileSize = DEFAULT_MAX_FILE_SIZE;
    if(maxFileSizeSetting > 0) {
      maxFileSize = maxFileSizeSetting;
    }
    
    NSString *body;
    
    // Display less data, if file is too big
    if(attrs.fileSize > maxFileSize) {
      NSFileHandle *myFile= [NSFileHandle fileHandleForReadingAtPath:[file_url path]];
      if(!myFile) {
        return noErr;
      }

      NSData *bodyData = [myFile readDataOfLength:maxFileSize];
      [myFile closeFile];
      body = [NSString stringWithUTF8String:[bodyData bytes]];
    } else {
      NSError *error;
      body = [[NSString alloc] initWithContentsOfURL:file_url
                                            encoding:magicAttributes.fileEncoding
                                               error:&error];
      
      if (body == nil) {
        NSLog(@"Error reading file at %@\n%@", file_url, [error localizedFailureReason]);
        return noErr;
      }
    }
    
    NSString *fontSize = defaults[@"fontSize"];
    if (fontSize == nil) {
      fontSize = @DEFAULT_FONT_SIZE;
    }
    NSString *lineHeight = defaults[@"lineHeight"];
    if (lineHeight == nil) {
      lineHeight = @DEFAULT_LINE_HEIGHT;
    }
    NSString *fontFamily = defaults[@"fontFamily"];
    if (fontFamily == nil) {
      fontFamily = @DEFAULT_FONT_FAMILY;
    }


    NSString *html = [NSString stringWithFormat: kHTMLTemplate,
                      [file_url lastPathComponent],
                      fontSize,
                      lineHeight,
                      fontFamily,
                      body];
    
    QLPreviewRequestSetDataRepresentation(request,
                                          (__bridge CFDataRef) [html dataUsingEncoding: NSUTF8StringEncoding],
                                          kUTTypeHTML,
                                          (__bridge CFDictionaryRef) previewProperties);

    return noErr;
  }
}

void CancelPreviewGeneration(void* thisInterface, QLPreviewRequestRef preview) {
  // implement only if supported
}
