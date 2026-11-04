#import <Foundation/Foundation.h>

#define OUT @"/var/mobile/Documents/device_token.txt"

static void dump(NSString *t) {
    if (!t.length) return;
    [t writeToFile:OUT atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"[LocketTok] saved len=%lu", (unsigned long)t.length);
}

%hook DCAppAttestService
- (BOOL)isSupported { return NO; }
+ (BOOL)isSupported { return NO; }
%end

%hook FIRAppAttestProvider
+ (BOOL)isSupported { return NO; }
%end

%hook DCDevice
- (void)generateTokenWithCompletionHandler:(void (^)(NSData *, NSError *))h {
    void (^w)(NSData *, NSError *) = ^(NSData *tok, NSError *err) {
        if (tok) dump([tok base64EncodedStringWithOptions:0]);
        if (h) h(tok, err);
    };
    %orig(w);
}
%end
