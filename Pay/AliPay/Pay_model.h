//
//  Pay_model.h
//  RoseGarden
//
//  Created by 憧憬云天888 on 2017/6/26.
//  Copyright © 2017年 吕志杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pay_model : NSObject
+(void)doAlipayPay:(NSString *)order_id order_price:(NSString *)order_price body_str:(NSString *)body_str;

@end
