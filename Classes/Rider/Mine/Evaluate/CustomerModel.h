//
//  CustomerModel.h
//  RiderIOS
//
//  Created by Han on 2018/7/30.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicModel.h"

@interface CustomerModel : BasicModel
{
    
}

@property(nonatomic,strong)NSString *order_id;
@property(nonatomic,strong)NSString *reason;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *yes_no;
//@property(nonatomic,strong)NSString *allNum;
//@property(nonatomic,strong)NSString *yesNum;
//@property(nonatomic,strong)NSString *noNum;

@end
