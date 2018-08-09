//
//  CustomerModel.m
//  RiderIOS
//
//  Created by Han on 2018/7/30.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "CustomerModel.h"

#define CUSREASON                           @"reason"
#define CUSID                               @"order_id"
#define CUSTIME                             @"create_time"
#define CUSYES                              @"yes"
#define CUSNO                               @"no"
#define CUSALL                              @"all"
#define CUSYES_NO                           @"yes_no"

@implementation CustomerModel
- (void)parseFromDictionary:(NSDictionary *)dic
{
    if ([dic objectForKey:CUSREASON] == nil ||
        [dic objectForKey:CUSREASON] == [NSNull null])
    {
        self.reason = @"";
    }
    else
    {
        self.reason = [NSString stringWithFormat:@"%@",[dic objectForKey:CUSREASON]];
    }
    
    if ([dic objectForKey:CUSID] == nil ||
        [dic objectForKey:CUSID] == [NSNull null])
    {
        self.order_id = @"";
    }
    else
    {
        self.order_id = [NSString stringWithFormat:@"%@",[dic objectForKey:CUSID]];
    }
    
    if ([dic objectForKey:CUSTIME] == nil ||
        [dic objectForKey:CUSTIME] == [NSNull null])
    {
        self.create_time = @"";
    }
    else
    {
        self.create_time = [NSString stringWithFormat:@"%@",[dic objectForKey:CUSTIME]];
    }
    
    if ([dic objectForKey:CUSYES_NO] == nil ||
        [dic objectForKey:CUSYES_NO] == [NSNull null])
    {
        self.yes_no = @"";
    }
    else
    {
        self.yes_no = [NSString stringWithFormat:@"%@",[dic objectForKey:CUSYES_NO]];
    }
    
//    if ([dic objectForKey:CUSYES] == nil ||
//        [dic objectForKey:CUSYES] == [NSNull null])
//    {
//        self.yesNum = @"";
//    }
//    else
//    {
//        self.yesNum = [NSString stringWithFormat:@"%@",[dic objectForKey:CUSYES]];
//    }
//
//    if ([dic objectForKey:CUSNO] == nil ||
//        [dic objectForKey:CUSNO] == [NSNull null])
//    {
//        self.noNum = @"";
//    }
//    else
//    {
//        self.noNum = [NSString stringWithFormat:@"%@",[dic objectForKey:CUSNO]];
//    }
//
//    if ([dic objectForKey:CUSALL] == nil ||
//        [dic objectForKey:CUSALL] == [NSNull null])
//    {
//        self.allNum = @"";
//    }
//    else
//    {
//        self.allNum = [NSString stringWithFormat:@"%@",[dic objectForKey:CUSALL]];
//    }
}
@end
