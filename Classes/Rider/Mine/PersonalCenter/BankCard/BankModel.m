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
}

@end
