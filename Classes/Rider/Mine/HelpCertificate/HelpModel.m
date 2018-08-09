//
//  HelpModel.m
//  RiderIOS
//
//  Created by Han on 2018/7/24.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "HelpModel.h"

#define CATEID                            @"cate_id"
#define CATENAME                          @"catename"
#define CATETIME                          @"create_time"


@implementation HelpModel

- (void)parseFromDictionary:(NSDictionary *)dic
{
    if ([dic objectForKey:CATEID] == nil ||
        [dic objectForKey:CATEID] == [NSNull null])
    {
        self.cate_id = @"";
    }
    else
    {
        self.cate_id = [NSString stringWithFormat:@"%@",[dic objectForKey:CATEID]];
    }
    
    if ([dic objectForKey:CATENAME] == nil ||
        [dic objectForKey:CATENAME] == [NSNull null])
    {
        self.catename = @"";
    }
    else
    {
        self.catename = [NSString stringWithFormat:@"%@",[dic objectForKey:CATENAME]];
    }
    
    if ([dic objectForKey:CATETIME] == nil ||
        [dic objectForKey:CATETIME] == [NSNull null])
    {
        self.create_time = @"";
    }
    else
    {
        self.create_time = [NSString stringWithFormat:@"%@",[dic objectForKey:CATETIME]];
    }
}
@end
