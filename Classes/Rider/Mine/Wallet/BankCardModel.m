//
//  BankCardModel.m
//  RiderIOS
//
//  Created by Han on 2018/8/7.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "BankCardModel.h"
#define APPID                             @"id"
#define APPCARDID                         @"cardid"
#define APPNAME                           @"name"
#define APPBANK                           @"bankname"
#define APPOPEN                           @"openingbank"

@implementation BankCardModel

- (void)parseFromDictionary:(NSDictionary *)dic
{
    if ([dic objectForKey:APPID] == nil ||
        [dic objectForKey:APPID] == [NSNull null])
    {
        self.cardId = @"";
    }
    else
    {
        self.cardId = [NSString stringWithFormat:@"%@",[dic objectForKey:APPID]];
    }
    
    if ([dic objectForKey:APPCARDID] == nil ||
        [dic objectForKey:APPCARDID] == [NSNull null])
    {
        self.cardCode = @"";
    }
    else
    {
        self.cardCode = [NSString stringWithFormat:@"%@",[dic objectForKey:APPCARDID]];
    }
    
    if ([dic objectForKey:APPNAME] == nil ||
        [dic objectForKey:APPNAME] == [NSNull null])
    {
        self.name = @"";
    }
    else
    {
        self.name = [NSString stringWithFormat:@"%@",[dic objectForKey:APPNAME]];
    }
    
    if ([dic objectForKey:APPBANK] == nil ||
        [dic objectForKey:APPBANK] == [NSNull null])
    {
        self.bankname = @"";
    }
    else
    {
        self.bankname = [NSString stringWithFormat:@"%@",[dic objectForKey:APPBANK]];
    }
    
    if ([dic objectForKey:APPOPEN] == nil ||
        [dic objectForKey:APPOPEN] == [NSNull null])
    {
        self.openingbank = @"";
    }
    else
    {
        self.openingbank = [NSString stringWithFormat:@"%@",[dic objectForKey:APPOPEN]];
    }
}

@end
