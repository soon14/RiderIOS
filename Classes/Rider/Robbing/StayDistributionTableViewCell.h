//
//  StayDistributionTableViewCell.h
//  RiderIOS
//
//  Created by Han on 2018/6/4.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StayDistributionTableViewCell : UITableViewCell


@property (nonatomic, copy) void(^didContactButton)(NSInteger idx);
@property (nonatomic, copy) void(^didStatusButton)(NSInteger idx);

- (void)setType:(NSString *)type indexPath:(NSIndexPath *)pathRow  withData:(NSString *)dataStr;
@end
