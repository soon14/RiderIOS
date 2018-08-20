//
//  BankModel.m
//  RiderIOS
//
//  Created by Han on 2018/8/7.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "BankModel.h"

#define CARDNAME                          @"name"
#define CARDLOGO                          @"logogram"
#define CARDID1                           @"cardid"
#define CARDID2                           @"id"
#define CARDBANK                           @"bank"
#define CARDBANKNAME                           @"bankname"


@implementation BankModel

- (void)parseFromDictionary:(NSDictionary *)dic
{
    if ([dic objectForKey:CARDNAME] == nil ||
        [dic objectForKey:CARDNAME] == [NSNull null])
    {
        self.name= @"";
    }
    else
    {
        self.name = [NSString stringWithFormat:@"%@",[dic objectForKey:CARDNAME]];
    }
    
    if ([dic objectForKey:CARDLOGO] == nil ||
        [dic objectForKey:CARDLOGO] == [NSNull null])
    {
        self.logogram= @"";
    }
    else
    {
        self.logogram = [NSString stringWithFormat:@"%@",[dic objectForKey:CARDLOGO]];
    }
    
    if ([dic objectForKey:CARDID1] == nil ||
        [dic objectForKey:CARDID1] == [NSNull null])
    {
        self.cardID= @"";
    }
    else
    {
        self.cardID = [NSString stringWithFormat:@"%@",[dic objectForKey:CARDID1]];
    }
    
    if ([dic objectForKey:CARDID2] == nil ||
        [dic objectForKey:CARDID2] == [NSNull null])
    {
        self.bankID= @"";
    }
    else
    {
        self.bankID = [NSString stringWithFormat:@"%@",[dic objectForKey:CARDID2]];
    }
    
    if ([dic objectForKey:CARDBANK] == nil ||
        [dic objectForKey:CARDBANK] == [NSNull null])
    {
        self.bank= @"";
    }
    else
    {
        self.bank = [NSString stringWithFormat:@"%@",[dic objectForKey:CARDBANK]];
    }
    
    if ([dic objectForKey:CARDBANKNAME] == nil ||
        [dic objectForKey:CARDBANKNAME] == [NSNull null])
    {
        self.bankname= @"";
    }
    else
    {
        self.bankname = [NSString stringWithFormat:@"%@",[dic objectForKey:CARDBANKNAME]];
    }
    
    
}

@end
