//
//  OrderTableViewCell.h
//  RiderIOS
//
//  Created by Han on 2018/6/7.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DistributionMode.h"

@interface OrderTableViewCell : UITableViewCell

- (void)setIndex:(NSInteger)indexRow withData:(DistributionMode *)mode;

@end
