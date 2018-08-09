//
//  NSDictionary+NSDictionary_Log.m
//  RiderIOS
//
//  Created by Han on 2018/7/24.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "NSDictionary+NSDictionary_Log.h"

@implementation NSDictionary (NSDictionary_Log)

- (NSString *)description
{
    NSMutableString *strM = [NSMutableString stringWithString:@"\n{"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]])
        {
            [strM appendFormat:@" %@ = %@\n", key, obj];
        }
        else
        {
            [strM appendFormat:@" %@ = %@\n", key, [obj description]];
        }
    }];
    [strM appendString:@"}"];
    return strM;
}

@end
