//
//  CommonDeal.m
//  TestDZAPI
//
//  Created by wangjun on 13-10-31.
//  Copyright (c) 2013年 user. All rights reserved.
//

#import "CommonDeal.h"

@interface CommonDeal ()

@end


static CommonDeal *static_commonDeal = nil;

@implementation CommonDeal
//@synthesize m_curLoginUser;
//@synthesize m_curCity;
//@synthesize m_allCity;
//@synthesize m_categoryArray;
//@synthesize m_regionArray;
//@synthesize m_hotCategoryArray;
//@synthesize m_hotDistrictArray;

#pragma mark - Public
// CommonDeal单例
+ (id)shareCommon
{
    @synchronized(self)
    {
        if(nil == static_commonDeal)
        {
            static_commonDeal = [[CommonDeal alloc] init];
        }
    }
    return static_commonDeal;
}

#pragma mark - Private
- (id)init
{
    if (self = [super init]) {
        // 初始化成员变量
//        self.m_curLoginUser = nil;
//        self.m_allCity = nil;
    }
    return self;
}

@end
