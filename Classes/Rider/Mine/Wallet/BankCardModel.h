//
//  BankCardModel.h
//  RiderIOS
//
//  Created by Han on 2018/8/7.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicModel.h"

@interface BankCardModel : BasicModel

@property(nonatomic,strong)NSString *cardId;
@property(nonatomic,strong)NSString *cardCode;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *bankname;
@property(nonatomic,strong)NSString *openingbank;
@end
