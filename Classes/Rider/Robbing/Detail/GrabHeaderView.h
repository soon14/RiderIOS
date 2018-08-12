//
//  GrabHeaderView.h
//  RiderDemo
//
//  Created by mac on 2018/2/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GrabHeaderView : UIView

+ (id)defaultView;

- (void)isHiddenView;

- (void)sendDataArr:(NSMutableArray *)dataArr;
@end
