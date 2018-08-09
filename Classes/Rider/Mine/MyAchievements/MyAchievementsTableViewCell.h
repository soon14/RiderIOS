//
//  MyAchievementsTableViewCell.h
//  RiderIOS
//
//  Created by Han on 2018/6/28.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AchievementMode.h"

@interface MyAchievementsTableViewCell : UITableViewCell

- (void)setData:(NSString *)title image:(NSString *)imageName withData:(AchievementMode *)mode;
@end
