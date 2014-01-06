//
//  AppDelegate.m
//  coinmonitor
//
//  Created by funland on 13-12-3.
//  Copyright (c) 2013年 funland. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize statusItem,ltcokcoin,btcokcoin,btcchina,ltcbtce,mtgox,bitstamp,okcoinapi,showimg,money,PriceSetting;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [self.statusItem setMenu:self.statusMenu];
    
    [self.statusItem setHighlightMode:YES];
    
    okcoinapi =@"https://data.btcchina.com/data/ticker";//@"https://www.okcoin.com/api/ticker.do?symbol=ltc_cny";
    showimg =[NSImage imageNamed:@"bitcoin"];
    money=@"￥";
    [[NSUserDefaults standardUserDefaults] setObject:@"BTCCHINA BTC" forKey:@"currentMarket"];
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"updateMarket" object:nil];
//    NSTimer *timer;
//    
//    timer = [NSTimer scheduledTimerWithTimeInterval: 2
//                                             target: self
//                                           selector: @selector(handleTimer:)
//                                           userInfo: nil
//                                            repeats: YES];
   // NSString* someObj = @"Some Arbitrary Object";
    [self resetValue];
    //[btcstatus setRepresentedObject:someObj];
    //[ltcokcoin setAction:@selector(showbtc:)];
/*    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *URL = [NSURL URLWithString:@"https://data.btcchina.com/data/ticker"];
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:URL]
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
         {
             if (data && !error) {
                 NSDictionary *entries = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                 
                 
                 NSDictionary* ticker =[entries objectForKey:@"ticker"]; //2
                 [self.statusItem setTitle:  [NSString stringWithFormat:@"%@%@",money ,[ticker objectForKey:@"last"]]];
                 
                 NSLog(@"mulity!");
                 [statusItem setImage: showimg];
             } else {
                 NSLog(@"Error: %@", [error localizedDescription]);
             }
         }];
    });*/
    NSLog(@"主线程 %@", [NSThread currentThread]);
    
    //间隔还是2秒
    
    uint64_t interval = 2 * NSEC_PER_SEC;
    
    //创建一个专门执行timer回调的GCD队列
    
    dispatch_queue_t queue = dispatch_queue_create("com.xiguazhi.CoinMonitor", 0);
    
    //创建Timer
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //使用dispatch_source_set_timer函数设置timer参数
    
    dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, 0), interval, 0);
    
    //设置回调
    
    dispatch_source_set_event_handler(_timer, ^()
                                      
    {
        // dispatch_async(dispatch_get_main_queue())
        //NSLog(@"Timer %@", [NSThread currentThread]);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //设置界面的按钮显示 根据自己需求设置
            
            [self handleTimerMulti];
            //[self handleTimeMultiBySite:@"https://www.okcoin.com/api/ticker.do?symbol=ltc_cny"];
            //[self handleTimeMultiBySite:@"https://btc-e.com/api/2/ltc_usd/ticker"];
            
        });
        
        
    });
    
    //dispatch_source默认是Suspended状态，通过dispatch_resume函数开始它
    
    dispatch_resume(_timer);
    
}

- (IBAction)pricesetting:(id)sender
{
    //if (!PriceSetting) {
        PriceSetting = [[PriceSettingController alloc] init];
    //}
    
    [self.PriceSetting showWindowWithCompletionHandler:^(NSURLCredential *credential){
        //[[KMFeedbinCredentialStorage sharedCredentialStorage] setCredential:credential];
        //[self getUnreadEntries:self];
        //[self setupMenu];
    }];
    [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];

}

//-(void)goldchange
//{
//    goldamount = [[[NSUserDefaults standardUserDefaults] objectForKey:@"gold"] intValue];
//    [goldnum setText:[NSString stringWithFormat:@"%d",goldamount]];
//}

- (IBAction)showbtc:(id)sender
{
    [self resetValue];
    //NSLog(@"The menu item's object is %@",[sender representedObject]);
    //https://data.btcchina.com/data/ticker
//    if([sender.title isEqualToString:@"BTC on OKCOIN"]){
//    okcoinapi =@"https://www.okcoin.com/api/ticker.do";
//    showimg =[NSImage imageNamed:@"bitcoin_black"];
//        btcstatus.title = @"LTC on OKCOIN";
//    }
//    else{
//        okcoinapi =@"https://www.okcoin.com/api/ticker.do?symbol=ltc_cny";
//       showimg =[NSImage imageNamed:@"bitcoin_black"];
//        btcstatus.title=@"BTC on OKCOIN";
//    }
   
    NSLog (@" high is %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"valuehigh"]);
    NSLog (@" low is %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"valuelow"]);
    // [[NSNotificationCenter defaultCenter] postNotificationName:@"goldupdate" object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goldchange) name:@"goldupdate" object:nil];
    
    if(sender==ltcokcoin){
        okcoinapi =@"https://www.okcoin.com/api/ticker.do?symbol=ltc_cny";
         showimg =[NSImage imageNamed:@"litecoin"];
         money=@"￥";

        [[NSUserDefaults standardUserDefaults] setObject:@"LTC OKCOIN" forKey:@"currentMarket"];
        // [[NSUserDefaults standardUserDefaults] setObject:@"forward" forKey:@"turn"]
        //[[[NSUserDefaults standardUserDefaults] objectForKey:@"reviewid"] intValue]
       // [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:qnum] forKey:@"reviewid"];
    }
    else if(sender==btcokcoin){
        okcoinapi =@"https://www.okcoin.com/api/ticker.do";
        showimg =[NSImage imageNamed:@"bitcoin"];
         money=@"￥";
        [[NSUserDefaults standardUserDefaults] setObject:@"BTC OKCOIN" forKey:@"currentMarket"];
    }
    else if(sender==btcchina){
        okcoinapi =@"https://data.btcchina.com/data/ticker";
        showimg =[NSImage imageNamed:@"bitcoin"];
         money=@"￥";
        [[NSUserDefaults standardUserDefaults] setObject:@"BTCCHINA BTC" forKey:@"currentMarket"];
    }
    else if(sender==ltcbtce){
        okcoinapi =@"https://btc-e.com/api/2/ltc_usd/ticker";
         showimg =[NSImage imageNamed:@"litecoin"];
         money=@"＄";
        [[NSUserDefaults standardUserDefaults] setObject:@"LTC BTC-E" forKey:@"currentMarket"];
    }
    else if(sender==mtgox){
        okcoinapi =@"https://data.mtgox.com/api/2/BTCUSD/money/ticker_fast";
        showimg =[NSImage imageNamed:@"bitcoin"];
        money=@"＄";
        [[NSUserDefaults standardUserDefaults] setObject:@"MTGOX BTC" forKey:@"currentMarket"];
    }
    else if(sender==bitstamp){
        okcoinapi =@"https://www.bitstamp.net/api/ticker";
        showimg =[NSImage imageNamed:@"bitcoin"];
        money=@"＄";
        [[NSUserDefaults standardUserDefaults] setObject:@"BITSTAMP" forKey:@"currentMarket"];
    }
     [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMarket" object:nil];
    
   // NSURL *url =[NSURL URLWithString:okcoinapi];
  //  NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
  //  NSURLConnection *connnection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //NSString *user = [self URLEncodedString:self.credential.user];
    //NSString *password = [self URLEncodedString:self.credential.password];
    //NSString *string = [NSString stringWithFormat:@"https://%@:%@@api.feedbin.me/v2/unread_entries.json", user, password];
    NSURL *URL = [NSURL URLWithString:okcoinapi];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:URL]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (data && !error) {
             NSDictionary *entries = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
             
             if(sender==mtgox){
                 NSDictionary* ticker =[entries objectForKey:@"data"]; //2
                 NSDictionary* ticker2=[ticker objectForKey:@"last_local"];
                 //NSLog(@"%@",[ticker objectForKey:@"last_local"]);
                 [self.statusItem setTitle:  [NSString stringWithFormat:@"%@",[ticker2 objectForKey:@"display_short"]]];
                 
             }
             else{
             NSDictionary* ticker =[entries objectForKey:@"ticker"]; //2
            [self.statusItem setTitle:  [NSString stringWithFormat:@"%@%@",money ,[ticker objectForKey:@"last"]]];

        }
             
             [statusItem setImage: showimg];
         } else {
             NSLog(@"Error: %@", [error localizedDescription]);
         }
     }];
}


-(void) handleTimeMultiBySite :(NSString *) site
{
    NSURL *URL = [NSURL URLWithString:site];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:URL]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (data && !error) {
             NSDictionary *entries = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
             //completionHandler(entries, error);
             NSDictionary* ticker =[entries objectForKey:@"ticker"]; //2
             //NSLog(@"ticker: %@", [ticker objectForKey:@"last"]); //3
             if(ticker){
                 //[self.statusItem setTitle:  [NSString stringWithFormat:@"%@%@",money ,[ticker objectForKey:@"last"]]];
                 //[statusItem setImage: showimg];
                 
                 NSLog(@"%f ",[[ticker objectForKey:@"last"] floatValue]);
 
                 
                 
             }
             
         } else {
             NSLog(@"Error: %@", [error localizedDescription]);
         }
     }];
    
}


-(void) handleTimerMulti
{
    //NSLog(@"get data!");
    //在这里进行处理
    // NSString *okcoinapi=@"https://www.okcoin.com/api/ticker.do";
    //dispatch_async(dispatch_get_main_queue())
    // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSURL *URL = [NSURL URLWithString:okcoinapi];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:URL]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (data && !error) {
             NSDictionary *entries = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
             //completionHandler(entries, error);
             NSDictionary* ticker =[entries objectForKey:@"ticker"]; //2
             //NSLog(@"ticker: %@", [ticker objectForKey:@"last"]); //3
             if(ticker){
                 [self.statusItem setTitle:  [NSString stringWithFormat:@"%@%@",money ,[ticker objectForKey:@"last"]]];
                 [statusItem setImage: showimg];
                 
                 //NSLog(@"%f %f",[[ticker objectForKey:@"last"] floatValue], [[[NSUserDefaults standardUserDefaults] objectForKey:@"btchigh"] floatValue]);
                 
                 if([[ticker objectForKey:@"last"] floatValue]> [[[NSUserDefaults standardUserDefaults] objectForKey:@"valuehigh"] floatValue])
                 {
                     
                     NSLog(@"big");
                     //Initalize new notification
                     [self ValueNotice:YES];
                     
                 }
                 
                 if([[ticker objectForKey:@"last"] floatValue]< [[[NSUserDefaults standardUserDefaults] objectForKey:@"valuelow"] floatValue])
                 {
                     NSLog(@"small");
                     [self ValueNotice:NO];
                 }
                 
                 
             }
             else if ([okcoinapi isEqualToString:@"https://www.bitstamp.net/api/ticker"])
             {
                 [self.statusItem setTitle:  [NSString stringWithFormat:@"%@%@",money ,[entries objectForKey:@"last"]]];
             }
             else if ([okcoinapi isEqualToString:@"https://data.mtgox.com/api/2/BTCUSD/money/ticker_fast"])
             {  //https://data.mtgox.com/api/2/BTCUSD/money/ticker
                 ticker =[entries objectForKey:@"data"]; //2
                 NSDictionary* ticker2=[ticker objectForKey:@"last_local"];
                 NSLog(@"%@", [NSString stringWithFormat:@"%@",[ticker2 objectForKey:@"value"]]);
                 [self.statusItem setTitle:  [NSString stringWithFormat:@"%@%@",money,[ticker2 objectForKey:@"value"]]];
                 
                 
                 if([[ticker2 objectForKey:@"value"] floatValue]> [[[NSUserDefaults standardUserDefaults] objectForKey:@"valuehigh"] floatValue])
                 {
                     
                     NSLog(@"big");
                     //Initalize new notification
                     [self ValueNotice:YES];
                     
                 }
                 
                 if([[ticker2 objectForKey:@"value"] floatValue]< [[[NSUserDefaults standardUserDefaults] objectForKey:@"valuelow"] floatValue])
                 {
                     NSLog(@"small");
                     [self ValueNotice:NO];
                 }
             }
             
         } else {
             NSLog(@"Error: %@", [error localizedDescription]);
         }
     }];
    
    // });

}

- (void) handleTimer: (NSTimer *) timer
{
    //在这里进行处理
    // NSString *okcoinapi=@"https://www.okcoin.com/api/ticker.do";
    
   // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *URL = [NSURL URLWithString:okcoinapi];
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:URL]
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
         {
             if (data && !error) {
                 NSDictionary *entries = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                 //completionHandler(entries, error);
                 NSDictionary* ticker =[entries objectForKey:@"ticker"]; //2
                 //NSLog(@"ticker: %@", [ticker objectForKey:@"last"]); //3
                 if(ticker){
                     [self.statusItem setTitle:  [NSString stringWithFormat:@"%@%@",money ,[ticker objectForKey:@"last"]]];
                     [statusItem setImage: showimg];
                     
                     //NSLog(@"%f %f",[[ticker objectForKey:@"last"] floatValue], [[[NSUserDefaults standardUserDefaults] objectForKey:@"btchigh"] floatValue]);
                     
                     if([[ticker objectForKey:@"last"] floatValue]> [[[NSUserDefaults standardUserDefaults] objectForKey:@"valuehigh"] floatValue])
                     {
                         
                         NSLog(@"big");
                         //Initalize new notification
                         [self ValueNotice:YES];
                         
                     }
                     
                     if([[ticker objectForKey:@"last"] floatValue]< [[[NSUserDefaults standardUserDefaults] objectForKey:@"valuelow"] floatValue])
                     {
                         NSLog(@"small");
                         [self ValueNotice:NO];
                     }
                     
                     
                 }
                 else if ([okcoinapi isEqualToString:@"https://www.bitstamp.net/api/ticker"])
                 {
                     [self.statusItem setTitle:  [NSString stringWithFormat:@"%@%@",money ,[entries objectForKey:@"last"]]];
                 }
                 else if ([okcoinapi isEqualToString:@"https://data.mtgox.com/api/2/BTCUSD/money/ticker_fast"])
                 {  //https://data.mtgox.com/api/2/BTCUSD/money/ticker
                     ticker =[entries objectForKey:@"data"]; //2
                     NSDictionary* ticker2=[ticker objectForKey:@"last_local"];
                     NSLog(@"%@", [NSString stringWithFormat:@"%@",[ticker2 objectForKey:@"value"]]);
                     [self.statusItem setTitle:  [NSString stringWithFormat:@"%@%@",money,[ticker2 objectForKey:@"value"]]];
                     
                     
                     if([[ticker2 objectForKey:@"value"] floatValue]> [[[NSUserDefaults standardUserDefaults] objectForKey:@"valuehigh"] floatValue])
                     {
                         
                         NSLog(@"big");
                         //Initalize new notification
                         [self ValueNotice:YES];
                         
                     }
                     
                     if([[ticker2 objectForKey:@"value"] floatValue]< [[[NSUserDefaults standardUserDefaults] objectForKey:@"valuelow"] floatValue])
                     {
                         NSLog(@"small");
                         [self ValueNotice:NO];
                     }
                 }
                 
             } else {
                 NSLog(@"Error: %@", [error localizedDescription]);
             }
         }];

   // });
    
  
    
}

-(void) resetValue
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:999999.00] forKey:@"valuehigh"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:0.00] forKey:@"valuelow"];
    //[valueHigh  setStringValue:@"999999.00"];
    //[valueLow setStringValue:@"0.00"];
    
}

-(void) ValueNotice :(BOOL) status
{
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    //Set the title of the notification
    
    if(status){
    [notification setTitle:@"⚠注意⬆️⬆️⬆️"];
    //Set the text of the notification
        [notification setContentImage:[NSImage imageNamed:@"up-icon"]];
    [notification setInformativeText:[NSString stringWithFormat:@"已经突破您设置的预警价 %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"valuehigh"]] ];//[[[NSUserDefaults standardUserDefaults] objectForKey:@"valuehigh"]
        
    }
    else{
        [notification setTitle:@"⚠注意⬇️⬇️⬇️"];
        //Set the text of the notification
        [notification setContentImage:[NSImage imageNamed:@"down-icon"]];//[[[NSUserDefaults standardUserDefaults] objectForKey:@"valuehigh"]

        [notification setInformativeText:[NSString stringWithFormat:@"已经跌穿您设置的预警价 %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"valuelow"]] ];
        
    }
    //Set the time and date on which the nofication will be deliverd (for example 20 secons later than the current date and time)
    //[notification setDeliveryDate:[NSDate dateWithTimeInterval:20 sinceDate:[NSDate date]]];
    //Set the sound, this can be either nil for no sound, NSUserNotificationDefaultSoundName for the default sound (tri-tone) and a string of a .caf file that is in the bundle (filname and extension)
    [notification setSoundName:NSUserNotificationDefaultSoundName];
    
    //Get the default notification center
    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    //Scheldule our NSUserNotification
    [center scheduleNotification:notification];
}


@end
