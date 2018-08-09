//
//  AppContextManager.m
//  ChinaYZ
//
//  Created by yons on 14-7-1.
//  Copyright (c) 2014年 yons. All rights reserved.
//

#import "AppContextManager.h"

@implementation AppContextManager
@synthesize isLogin;
@synthesize locY,locX;
@synthesize locCityName,cityID;
@synthesize userAccopunt,userID,userPhone;
@synthesize userStatus;
@synthesize token;
@synthesize imageURl;
@synthesize userName,bond_money,balance,photo,photo_front,riderID,health_type,rider_type,addr,mobile,closed;


static AppContextManager *m_manger;

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

+ (id)shareManager
{
    if (!m_manger)
    {
        m_manger = [[AppContextManager alloc] init];
    }
    return m_manger;
}


@end
