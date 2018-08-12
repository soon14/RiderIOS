//
//  OrderDetailMode.m
//  RiderIOS
//
//  Created by Han on 2018/6/6.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "OrderDetailMode.h"

#define ORDERPRICE                           @"price"
#define ORDERTITLE                           @"title"
#define ORDERTOTAL                           @"total"
#define ORDERALLPRICE                        @"allprice"

@implementation OrderDetailMode
@synthesize name,money,num;

- (void)parseFromDictionary:(NSDictionary *)dic
{
    if ([dic objectForKey:ORDERPRICE] == nil ||
        [dic objectForKey:ORDERPRICE] == [NSNull null])
    {
        self.price = @"";
    }
    else
    {
        self.price = [NSString stringWithFormat:@"%@",[dic objectForKey:ORDERPRICE]];
    }
    
    if ([dic objectForKey:ORDERTITLE] == nil ||
        [dic objectForKey:ORDERTITLE] == [NSNull null])
    {
        self.title = @"";
    }
    else
    {
        self.title = [NSString stringWithFormat:@"%@",[dic objectForKey:ORDERTITLE]];
    }
    
    if ([dic objectForKey:ORDERTOTAL] == nil ||
        [dic objectForKey:ORDERTOTAL] == [NSNull null])
    {
        self.total = @"";
    }
    else
    {
        self.total = [NSString stringWithFormat:@"%@",[dic objectForKey:ORDERTOTAL]];
    }
    
    if ([dic objectForKey:ORDERALLPRICE] == nil ||
        [dic objectForKey:ORDERALLPRICE] == [NSNull null])
    {
        self.allprice = @"";
    }
    else
    {
        self.allprice = [NSString stringWithFormat:@"%@",[dic objectForKey:ORDERALLPRICE]];
    }
}
@end
