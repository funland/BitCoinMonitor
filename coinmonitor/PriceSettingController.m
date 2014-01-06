//
//  PriceSettingController.m
//  CoinMonitor
//
//  Created by funland on 13-12-12.
//  Copyright (c) 2013年 funland. All rights reserved.
//

#import "PriceSettingController.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/QuartzCore.h>

@interface NSTextField (AnimatedSetString)

- (void) setAnimatedStringValue:(NSString *)aString;

@end

@implementation NSTextField (AnimatedSetString)

- (void) setAnimatedStringValue:(NSString *)aString
{
    if ([[self stringValue] isEqual: aString])
    {
        return;
    }
    
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        [context setDuration: 1.0];
        [context setTimingFunction: [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut]];
        [self.animator setAlphaValue: 1.0];
    }
                        completionHandler:^{
                            [self setStringValue: aString];
                            [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
                                [context setDuration: 0.0];
                                [context setTimingFunction: [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn]];
                                [self.animator setAlphaValue: 0.0];
                            } completionHandler: ^{}];
                        }];
}

@end

@interface PriceSettingController ()

@property (copy, nonatomic) void (^completionHandler)(NSURLCredential *credential);
@property (strong, nonatomic) PriceSettingController *PriceSetting;

@end

@implementation PriceSettingController
@synthesize  valueHigh,valueLow,currentmarket,setcomplete;
- (id)init
{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CurrentMarketLbChange) name:@"updateMarket" object:nil];
    // [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMarket" object:nil];
    //[self resetValue:nil];

    return [self initWithWindowNibName:@"PriceSettingController" owner:self];
        // currentmarket.stringValue=@"BTCCHINA";//[[NSUserDefaults standardUserDefaults] objectForKey:@"currentMarket"];

}

- (void)showWindowWithCompletionHandler:(void (^)(NSURLCredential *))completionHandler
{

    [self showWindow:nil];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMarket" object:nil];
    [setcomplete setHidden:YES];
    //[setcomplete.animator setAlphaValue: 0.0];
    self.completionHandler = completionHandler;
}

-(IBAction)saveandclose: (id)sender
{
    //[super close];
    NSLog(@"roger that~");
   // NSLog(@"%@,%@,%@,%@",btchigh.stringValue,btclow.stringValue,ltchigh.stringValue,ltclow.stringValue);
   // NSLog(@"%@,%@,%@,%@",btcsel.stringValue,ltcsel.stringValue,setmusic.stringValue,setbeep.stringValue);
    //if (self.completionHandler) {
        //self.completionHandler(credential);
    //    [self close];
    //}
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:[valueHigh.stringValue floatValue]] forKey:@"valuehigh"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:[valueLow.stringValue floatValue]] forKey:@"valuelow"];
    [self.setcomplete setHidden:NO];
     //[self.setcomplete setAnimatedStringValue:@"设置完成✅"];
    
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        [context setDuration: 1.0];
        [context setTimingFunction: [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut]];
        [setcomplete.animator setAlphaValue: 1.0];
    }
                        completionHandler:^{
                            //[setcomplete setStringValue: aString];
                            [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
                                [context setDuration: 1.0];
                                [context setTimingFunction: [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn]];
                                [setcomplete.animator setAlphaValue: 0.0];
                            } completionHandler: ^{}];
                        }];
    

}

-(IBAction)resetValue:(id)sender //bug?无法停止相应
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:999999.00] forKey:@"valuehigh"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:0.00] forKey:@"valuelow"];
    [valueHigh  setStringValue:@"999999.00"];
    [valueLow setStringValue:@"0.00"];
}

-(void)CurrentMarketLbChange
{
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"currentMarket"]);
    currentmarket.stringValue=[[NSUserDefaults standardUserDefaults] objectForKey:@"currentMarket"];
    //[self resetValue:Nil];
    [valueHigh  setStringValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"valuehigh"]];
    [valueLow setStringValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"valuelow"]];
    NSLog(@"I 'm here");
}

@end
