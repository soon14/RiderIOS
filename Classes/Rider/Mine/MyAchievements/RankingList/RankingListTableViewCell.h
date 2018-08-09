//
//  RankingListTableViewCell.h
//  RiderDemo
//
//  Created by mac on 2018/2/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankingListMode.h"
#import "AppContextManager.h"

@interface RankingListTableViewCell : UITableViewCell

- (void)setMode:(RankingListMode *)model withType:(RankListType)type index:(NSInteger)indeRow;
@end
