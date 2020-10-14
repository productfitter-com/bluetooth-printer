#import "MyCordovaPlugin.h"
#import "PrinterSDK.h"

#import <Cordova/CDVAvailability.h>

@implementation MyCordovaPlugin

- (void)pluginInitialize {
}

- (void)echo:(CDVInvokedUrlCommand *)command {
  NSString* phrase = [command.arguments objectAtIndex:0];
  NSLog(@"%@", phrase);
    [[PrinterSDK defaultPrinterSDK] scanPrintersWithCompletion:^(Printer* printer)
    {
        if (nil == _printerArray){
         _printerArray = [[NSMutableArray alloc] initWithCapacity:1];
        }
        [_printerArray addObject:printer];
        if (_printerArray != nil && [_printerArray count] > 0) {
            [[PrinterSDK defaultPrinterSDK] connectBT:printer];
            double delayInSeconds = 5.0f;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [[PrinterSDK defaultPrinterSDK] printTestPaper];
                NSLog(@"%@",printer.name);
                NSLog(@"%@",printer.UUIDString);
            });
        }
    }];
    NSLog(@"%@", _printerArray);
}

- (void)doPrint:(CDVInvokedUrlCommand *)command {
  NSString* param = [command.arguments objectAtIndex:0];
    NSLog(@"%@", param);
  NSLog(@"%@", @"param");
  [[PrinterSDK defaultPrinterSDK] printText:param];
}


- (void)getDate:(CDVInvokedUrlCommand *)command {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
  [dateFormatter setLocale:enUSPOSIXLocale];
  [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];

  NSDate *now = [NSDate date];
  NSString *iso8601String = [dateFormatter stringFromDate:now];

  CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:iso8601String];
  [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)getPrinters:(CDVInvokedUrlCommand *)command {
    [[PrinterSDK defaultPrinterSDK] scanPrintersWithCompletion:^(Printer* printer)
    {
        if (nil == _printerArray){
         _printerArray = [[NSMutableArray alloc] initWithCapacity:1];
        }
        [_printerArray addObject:printer];
    }];

    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:_printerArray];

    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)getList:(CDVInvokedUrlCommand *)command {
    if (_printerArray && [_printerArray count] > 0) {
        
        NSArray *array = [_printerArray copy];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];

        
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArrayBuffer:data];
        NSLog(@"%@", @"GET printers");
        NSLog(@"%@", result);
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:array];
//        NSLog(@"%@", @"GET printers");
//        NSLog(@"%@", result);
//        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }else{
      CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_IO_EXCEPTION messageAsInt:0];
        NSLog(@"%@", @"GET printers");
        NSLog(@"%@", result);
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }
}

@end