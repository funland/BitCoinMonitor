//
//  PriceSettingController.h
//  CoinMonitor
//
//  Created by funland on 13-12-12.
//  Copyright (c) 2013年 funland. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PriceSettingController : NSWindowController
- (void)showWindowWithCompletionHandler:(void (^)(NSURLCredential *credential))completionHandler;
-(IBAction)saveandclose:(id)sender;
-(IBAction)resetValue:(id)sender;

@property (weak, nonatomic) IBOutlet NSTextField *valueHigh;
@property (weak, nonatomic) IBOutlet NSTextField *valueLow;
@property (weak, nonatomic) IBOutlet NSTextField *currentmarket;
@property (weak, nonatomic) IBOutlet NSTextField *setcomplete;

@end
