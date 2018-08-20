//
//  BankCardTableViewCell.h
//  RiderIOS
//
//  Created by Han on 2018/7/3.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankModel.h"

@interface BankCardTableViewCell : UITableViewCell

- (void)setData:(NSString *)number withName:(BankModel *)mode;
@end
