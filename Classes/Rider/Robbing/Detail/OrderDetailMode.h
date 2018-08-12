//
//  OrderDetailMode.h
//  RiderIOS
//
//  Created by Han on 2018/6/6.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicModel.h"

@interface OrderDetailMode : BasicModel
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *num;
@property(nonatomic,strong)NSString *money;

@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *total;
@property(nonatomic,strong)NSString *allprice;
@end
