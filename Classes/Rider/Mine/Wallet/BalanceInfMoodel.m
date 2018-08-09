//
//  BalanceInfMoodel.m
//  RiderIOS
//
//  Created by Han on 2018/7/31.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "BalanceInfMoodel.h"

#define INFODES                           @"describtion"
#define INFOTIME                          @"create_time"
#define INFOTYPE                          @"type"
#define INFOMONEY                         @"money"

@implementation BalanceInfMoodel

- (void)parseFromDictionary:(NSDictionary *)dic
{
    if ([dic objectForKey:INFODES] == nil ||
        [dic objectForKey:INFODES] == [NSNull null])
    {
        self.description1 = @"";
    }
    else
    {
        self.description1 = [NSString stringWithFormat:@"%@",[dic objectForKey:INFODES]];
    }
    
    if ([dic objectForKey:INFOTIME] == nil ||
        [dic objectForKey:INFOTIME] == [NSNull null])
    {
        self.create_time = @"";
    }
    else
    {
        self.create_time = [NSString stringWithFormat:@"%@",[dic objectForKey:INFOTIME]];
    }
    
    if ([dic objectForKey:INFOTYPE] == nil ||
        [dic objectForKey:INFOTYPE] == [NSNull null])
    {
        self.type = @"";
    }
    else
    {
        self.type = [NSString stringWithFormat:@"%@",[dic objectForKey:INFOTYPE]];
    }
    
    if ([dic objectForKey:INFOMONEY] == nil ||
        [dic objectForKey:INFOMONEY] == [NSNull null])
    {
        self.money = @"";
    }
    else
    {
        self.money = [NSString stringWithFormat:@"%@",[dic objectForKey:INFOMONEY]];
    }
}
@end
