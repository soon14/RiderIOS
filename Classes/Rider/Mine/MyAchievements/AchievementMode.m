//
//  AchievementMode.m
//  RiderIOS
//
//  Created by Han on 2018/8/8.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "AchievementMode.h"

#define ACHCOUNT                            @"count"
#define ACHDIS                              @"distance"

@implementation AchievementMode

- (void)parseFromDictionary:(NSDictionary *)dic
{
    if ([dic objectForKey:ACHCOUNT] == nil ||
        [dic objectForKey:ACHCOUNT] == [NSNull null])
    {
        self.count = @"";
    }
    else
    {
        self.count = [NSString stringWithFormat:@"%@",[dic objectForKey:ACHCOUNT]];
    }
    
    if ([dic objectForKey:ACHDIS] == nil ||
        [dic objectForKey:ACHDIS] == [NSNull null])
    {
        self.distance = @"";
    }
    else
    {
        self.distance = [NSString stringWithFormat:@"%@",[dic objectForKey:ACHDIS]];
    }
}
@end
