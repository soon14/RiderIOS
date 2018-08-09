//
//  AppealModel.h
//  RiderIOS
//
//  Created by Han on 2018/7/26.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicModel.h"

@interface AppealModel : BasicModel

@property(nonatomic,strong)NSString *order_id;
@property(nonatomic,strong)NSString *shop_name;
@property(nonatomic,strong)NSString *addr;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *type_order_id;

@end
