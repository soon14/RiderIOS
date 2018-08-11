//
//  DistributionMode.h
//  RiderDemo
//
//  Created by mac on 2018/1/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicModel.h"

@interface DistributionMode : BasicModel
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *shop_name;
@property(nonatomic,strong)NSString *addrmerch;
@property(nonatomic,strong)NSString *userDis;
@property(nonatomic,strong)NSString *shopDis;
@property(nonatomic,strong)NSString *price;
@end
