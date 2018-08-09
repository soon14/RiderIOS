//
//  AppealModel.m
//  RiderIOS
//
//  Created by Han on 2018/7/26.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "AppealModel.h"

#define APPEALID                          @"order_id"
#define APPEALNAME                        @"shop_name"
#define APPEALTIME                        @"create_time"
#define APPEAADDR                         @"addr"
#define APPEAADDR                         @"addr"
#define APPEALTYPE                        @"type_order_id"

@implementation AppealModel

- (void)parseFromDictionary:(NSDictionary *)dic
{
    if ([dic objectForKey:APPEALID] == nil ||
        [dic objectForKey:APPEALID] == [NSNull null])
    {
        self.order_id = @"";
    }
    else
    {
        self.order_id = [NSString stringWithFormat:@"%@",[dic objectForKey:APPEALID]];
    }
    
    if ([dic objectForKey:APPEALNAME] == nil ||
        [dic objectForKey:APPEALNAME] == [NSNull null])
    {
        self.shop_name = @"";
    }
    else
    {
        self.shop_name = [NSString stringWithFormat:@"%@",[dic objectForKey:APPEALNAME]];
    }
    
    if ([dic objectForKey:APPEALTIME] == nil ||
        [dic objectForKey:APPEALTIME] == [NSNull null])
    {
        self.create_time = @"";
    }
    else
    {
        self.create_time = [NSString stringWithFormat:@"%@",[dic objectForKey:APPEALTIME]];
    }
    
    if ([dic objectForKey:APPEAADDR] == nil ||
        [dic objectForKey:APPEAADDR] == [NSNull null])
    {
        self.addr = @"";
    }
    else
    {
        self.addr = [NSString stringWithFormat:@"%@",[dic objectForKey:APPEAADDR]];
    }
    
    if ([dic objectForKey:APPEALTYPE] == nil ||
        [dic objectForKey:APPEALTYPE] == [NSNull null])
    {
        self.type_order_id = @"";
    }
    else
    {
        self.type_order_id = [NSString stringWithFormat:@"%@",[dic objectForKey:APPEALTYPE]];
    }
}

@end
