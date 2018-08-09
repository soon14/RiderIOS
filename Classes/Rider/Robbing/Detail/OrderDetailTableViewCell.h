//
//  OrderDetailTableViewCell.h
//  RiderIOS
//
//  Created by Han on 2018/6/6.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailTableViewCell : UITableViewCell

- (void)setData:(NSMutableArray *)data count:(NSInteger)count index:(NSInteger)indexRow withIsLast:(BOOL)islast;

@end
