//
//  BalanceInfoTableViewCell.h
//  RiderDemo
//
//  Created by mac on 2018/1/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BalanceInfMoodel.h"

@interface BalanceInfoTableViewCell : UITableViewCell

- (void)setData:(BalanceInfMoodel *)mode withType:(NSString *)type;
@end
