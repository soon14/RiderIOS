//
//  MineTableViewCell.h
//  RiderIOS
//
//  Created by Han on 2018/6/8.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineTableViewCell : UITableViewCell

- (void)setData:(NSString *)data image:(NSString *)imageName index:(NSInteger)indexRow withIsOpen:(int)isOpen;

@property(nonatomic,copy) void (^didSwichView)(int i);

@end
