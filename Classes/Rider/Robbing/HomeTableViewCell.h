//
//  HomeTableViewCell.h
//  RiderDemo
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DistributionMode.h"

@protocol HomeTableViewCellDelegate <NSObject>

- (void)orderBtn:(NSInteger)index;

@end

@interface HomeTableViewCell : UITableViewCell
{
    __weak id<HomeTableViewCellDelegate>delegate;
}
@property(nonatomic,weak)id<HomeTableViewCellDelegate>delegate;

-(void)setData:(DistributionMode *)mode indexPath:(NSIndexPath *)pathRow withView:(NSString *)view;
@end
