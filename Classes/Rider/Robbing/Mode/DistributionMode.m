//
//  DistributionMode.m
//  RiderDemo
//
//  Created by mac on 2018/1/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "DistributionMode.h"

#define APPSTATUS                           @"status"
#define APPSHOPNAME                         @"shop_name"
#define APPADDRESS                          @"addr"
#define APPUSERDIS                          @"d"
#define APPSHOPRDIS                         @"d1"
#define APPPRICE                            @"logistics_price"
#define APPORDERID                          @"order_id"


@implementation DistributionMode

- (void)parseFromDictionary:(NSDictionary *)dic
{
    if ([dic objectForKey:APPSTATUS] == nil ||
        [dic objectForKey:APPSTATUS] == [NSNull null])
    {
        self.status = @"";
    }
    else
    {
        self.status = [NSString stringWithFormat:@"%@",[dic objectForKey:APPSTATUS]];
    }
    
    if ([dic objectForKey:APPSHOPNAME] == nil ||
        [dic objectForKey:APPSHOPNAME] == [NSNull null])
    {
        self.shop_name = @"";
    }
    else
    {
        self.shop_name = [NSString stringWithFormat:@"%@",[dic objectForKey:APPSHOPNAME]];
    }
    
    if ([dic objectForKey:APPADDRESS] == nil ||
        [dic objectForKey:APPADDRESS] == [NSNull null])
    {
        self.addrmerch = @"";
    }
    else
    {
        self.addrmerch = [NSString stringWithFormat:@"%@",[dic objectForKey:APPADDRESS]];
    }
    
    if ([dic objectForKey:APPUSERDIS] == nil ||
        [dic objectForKey:APPUSERDIS] == [NSNull null])
    {
        self.userDis = @"";
    }
    else
    {
        self.userDis = [NSString stringWithFormat:@"%@",[dic objectForKey:APPUSERDIS]];
    }
    
    if ([dic objectForKey:APPSHOPRDIS] == nil ||
        [dic objectForKey:APPSHOPRDIS] == [NSNull null])
    {
        self.shopDis = @"";
    }
    else
    {
        self.shopDis = [NSString stringWithFormat:@"%@",[dic objectForKey:APPSHOPRDIS]];
    }
    
    if ([dic objectForKey:APPPRICE] == nil ||
        [dic objectForKey:APPPRICE] == [NSNull null])
    {
        self.price = @"";
    }
    else
    {
        self.price = [NSString stringWithFormat:@"%@",[dic objectForKey:APPPRICE]];
    }
    
    if ([dic objectForKey:APPORDERID] == nil ||
        [dic objectForKey:APPORDERID] == [NSNull null])
    {
        self.orderID = @"";
    }
    else
    {
        self.orderID = [NSString stringWithFormat:@"%@",[dic objectForKey:APPORDERID]];
    }
}
@end
