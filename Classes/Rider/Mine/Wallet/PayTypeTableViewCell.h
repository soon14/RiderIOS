//
//  PayTypeTableViewCell.h
//  RiderIOS
//
//  Created by Han on 2018/6/15.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayTypeTableViewCell : UITableViewCell

- (void)setTitle:(NSString *)title image:(NSString *)imageName withIndex:(NSInteger)row;

- (void)selectType:(NSInteger)indexRow;

@end
