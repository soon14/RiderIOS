//
//  OrderdDetailTableViewCell.h
//  RiderIOS
//
//  Created by Han on 2018/6/7.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderdDetailTableViewCell : UITableViewCell
- (void)setData:(NSMutableArray *)data index:(NSInteger)indexRow withStatus:(NSString *)status;
@end
