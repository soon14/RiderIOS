//
//  RankingListMode.m
//  RiderDemo
//
//  Created by mac on 2018/2/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RankingListMode.h"

#define APPRANK                              @"rank"
#define APPCOUNT                             @"count"
#define APPDISTANCE                          @"distance"
#define APPNAME                              @"nickname"

@implementation RankingListMode
@synthesize ranking,rankImage,name,num,distance;

- (void)parseFromDictionary:(NSDictionary *)dic
{
    if ([dic objectForKey:APPRANK] == nil ||
        [dic objectForKey:APPRANK] == [NSNull null])
    {
        self.ranking = @"";
    }
    else
    {
        self.ranking = [NSString stringWithFormat:@"%@",[dic objectForKey:APPRANK]];
    }
    
    if ([dic objectForKey:APPCOUNT] == nil ||
        [dic objectForKey:APPCOUNT] == [NSNull null])
    {
        self.num = @"";
    }
    else
    {
        self.num = [NSString stringWithFormat:@"%@",[dic objectForKey:APPCOUNT]];
    }
    
    if ([dic objectForKey:APPDISTANCE] == nil ||
        [dic objectForKey:APPDISTANCE] == [NSNull null])
    {
        self.distance = @"";
    }
    else
    {
        self.distance = [NSString stringWithFormat:@"%@",[dic objectForKey:APPDISTANCE]];
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
}
@end
