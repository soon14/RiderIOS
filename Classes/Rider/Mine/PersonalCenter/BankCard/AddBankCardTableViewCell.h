//
//  AddBankCardTableViewCell.h
//  RiderIOS
//
//  Created by Han on 2018/7/3.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddBankCardTableViewCell : UITableViewCell

@property (nonatomic, copy) void(^beginEditingBlock)(void);
@property (nonatomic, copy) void(^returnBlock)(NSString *number);
@property (nonatomic, copy) void(^endEditingBlock)(NSString *number,NSInteger tag);

- (void)setData:(NSString *)title bankName:(NSString *)bankName withIndexRow:(NSInteger)indexRow;
@end
