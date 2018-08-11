//
//  PutForwardTableViewCell.h
//  RiderIOS
//
//  Created by Han on 2018/6/29.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PutForwardTableViewCell : UITableViewCell

@property (nonatomic, copy) void(^txBlock)(void);
@property (nonatomic, copy) void(^beginEditingBlock)(void);
@property (nonatomic, copy) void(^returnBlock)(NSString *number);
@property (nonatomic, copy) void(^endEditingBlock)(NSString *number,NSInteger tag);

- (void)setData:(NSString *)title bankName:(NSString *)name withIndex:(NSInteger)indexRow;
@end
