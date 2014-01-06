//
//  AppDelegate.h
//  coinmonitor
//
//  Created by funland on 13-12-3.
//  Copyright (c) 2013年 funland. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import "PriceSettingController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
     dispatch_source_t _timer;
}

@property (assign) IBOutlet NSWindow *window;
@property (strong, nonatomic) IBOutlet NSMenu *statusMenu;
@property (strong, nonatomic) NSStatusItem *statusItem;
@property (strong, nonatomic) IBOutlet NSMenuItem *ltcokcoin;
@property (strong, nonatomic) IBOutlet NSMenuItem *btcokcoin;
@property (strong, nonatomic) IBOutlet NSMenuItem *btcchina;
@property (strong, nonatomic) IBOutlet NSMenuItem *ltcbtce;
@property (strong, nonatomic) IBOutlet NSMenuItem *mtgox;
@property (strong, nonatomic) IBOutlet NSMenuItem *bitstamp;
@property (strong, nonatomic) NSString *okcoinapi;
@property (strong, nonatomic) NSImage *showimg;
@property (strong, nonatomic) NSString *money;
@property (strong, nonatomic) PriceSettingController *PriceSetting;
- (IBAction)showbtc:(id)sender;
- (IBAction)pricesetting:(id)sender;
@end
