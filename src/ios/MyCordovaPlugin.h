#import <Cordova/CDVPlugin.h>

@interface MyCordovaPlugin : CDVPlugin {
    NSMutableArray* _printerArray;
}

// The hooks for our plugin commands
- (void)echo:(CDVInvokedUrlCommand *)command;
- (void)doPrint:(CDVInvokedUrlCommand *)command;
- (void)getDate:(CDVInvokedUrlCommand *)command;
- (void)getPrinters:(CDVInvokedUrlCommand *)command;
- (void)getList:(CDVInvokedUrlCommand *)command;
@end
