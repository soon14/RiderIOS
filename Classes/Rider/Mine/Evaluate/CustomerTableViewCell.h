//
//  CustomerTableViewCell.h
//  RiderIOS
//
//  Created by Han on 2018/6/12.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerModel.h"

@interface CustomerTableViewCell : UITableViewCell

- (void)setData:(CustomerModel *)model;
@end
