//
//  GridScreenView.h
//  RiderIOS
//
//  Created by Han on 2018/6/7.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridScreenView : UIView

@property (nonatomic, strong)NSMutableArray *monthArr;

@property (nonatomic, copy) void(^didSelectView)(NSInteger idx);
@property (nonatomic, copy) void(^didHiddenView)(NSString *str);

@end
