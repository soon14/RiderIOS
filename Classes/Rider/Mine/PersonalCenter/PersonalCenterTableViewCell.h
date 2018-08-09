//
//  PersonalCenterTableViewCell.h
//  RiderIOS
//
//  Created by Han on 2018/6/19.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalCenterTableViewCell : UITableViewCell

@property(nonatomic,copy) void (^showActionSheet)(void);

- (void)setData:(NSString *)data image:(UIImage *)image phoneNum:(NSString *)num adddr:(NSString *)addr withIndex:(NSInteger)index;

@end
