//
//  MapAddressMode.m
//  RiderDemo
//
//  Created by mac on 2018/1/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MapAddressMode.h"

#define TITLE @"title"
#define DATASIZE @"dataSize"
#define PROGRESS @"progress"
#define LOADSTATE @"loadState"
#define CITYID @"cityID"

@implementation MapAddressMode
@synthesize title,dataSize,progress,loadState,cityID;

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.title forKey:TITLE];
    [aCoder encodeInt:self.dataSize forKey:DATASIZE];
    [aCoder encodeObject:self.progress forKey:PROGRESS];
    [aCoder encodeObject:self.loadState forKey:LOADSTATE];
    [aCoder encodeInt:self.cityID forKey:CITYID];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:TITLE];
        self.dataSize = [aDecoder decodeIntForKey:DATASIZE];
        self.progress = [aDecoder decodeObjectForKey:PROGRESS];
        self.loadState = [aDecoder decodeObjectForKey:LOADSTATE];
        self.cityID = [aDecoder decodeIntForKey:CITYID];
        
    }
    
    return self;
}

@end
