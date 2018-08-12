//
//  RankingListHeaderView.h
//  RiderDemo
//
//  Created by mac on 2018/2/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankingListHeaderView : UIView
+ (id)defaultView;

- (void)sendData:(NSMutableArray *)dataArr withType:(RankListType)type;
@end
