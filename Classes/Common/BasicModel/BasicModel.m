//
//  BasicModel.m
//  TestDZAPI
//
//  Created by wangjun on 13-11-1.
//  Copyright (c) 2013年 user. All rights reserved.
//

#import "BasicModel.h"

@implementation BasicModel

- (id)initFromDictionary:(NSDictionary *)dic
{
	self = [super init];
	
	// 将字典的数据转化为模型的数据
	[self parseFromDictionary:dic];
	
	return self;
}

- (void)parseFromDictionary:(NSDictionary *)dic
{
	
}

@end
