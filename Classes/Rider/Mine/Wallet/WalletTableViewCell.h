//
//  WalletTableViewCell.h
//  RiderIOS
//
//  Created by Han on 2018/6/11.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalletTableViewCell : UITableViewCell
- (void)setData:(NSString *)title imageName:(NSString *)imageName money:(NSString *)money withIndex:(NSInteger )indexRow;
@end
