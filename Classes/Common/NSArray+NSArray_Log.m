//
//  NSArray+NSArray_Log.m
//  RiderIOS
//
//  Created by Han on 2018/7/24.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "NSArray+NSArray_Log.h"

@implementation NSArray (NSArray_Log)

- (NSString *)description
{
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]])
        {
            [strM appendFormat:@"\t\t%@,\n", obj];
        }
        else
        {
            [strM appendFormat:@"\t\t%@,\n", [obj description]];
        }
    }];
    [strM appendString:@"\t\t)"];
    return strM;
}
@end
