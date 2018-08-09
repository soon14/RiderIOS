//
//  ServiceManagement.m
//  RiderIOS
//
//  Created by Han on 2018/7/4.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "ServiceManagement.h"

static ServiceManagement *m_serviceManagement;

@interface ServiceManagement()
{
    
}
@property (nonatomic, retain) NSDictionary *m_settingDic;
@end

@implementation ServiceManagement

+ (ServiceManagement *)shareManagement
{
    @synchronized(self)
    {
        if (!m_serviceManagement)
        {
            m_serviceManagement = [[ServiceManagement alloc] init];
        }
    }
    return m_serviceManagement;
}

- (id)init
{
    if (self = [super init])
    {
        NSString *settingPath = [[NSBundle mainBundle] pathForResource:@"RiderService" ofType:@"plist"];
        self.m_settingDic = [[NSDictionary alloc] initWithContentsOfFile:settingPath];
        
    }
    return self;
}

- (NSString *)getHostUrl:(NSString *)key
{
    NSString *str = [[self.m_settingDic objectForKey:@"BasicSetting"] objectForKey:key];
//    NSLog(@"Url == %@",str);
    return str;
}

@end
