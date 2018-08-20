//
//  BankModel.h
//  RiderIOS
//
//  Created by Han on 2018/8/7.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicModel.h"

@interface BankModel : BasicModel

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *logogram;
@property(nonatomic,strong)NSString *bank;
@property(nonatomic,strong)NSString *cardID;
@property(nonatomic,strong)NSString *bankID;
@property(nonatomic,strong)NSString *bankname;
@end
