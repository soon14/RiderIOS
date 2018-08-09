//
//  GuideView.h
//  RiderIOS
//
//  Created by Han on 2018/6/14.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideView : UIView

@property (nonatomic, copy) void(^didSelectView)(NSInteger idx);
@property (nonatomic, copy) void(^didHiddenView)(NSString *str);
@property (nonatomic, copy) void(^pushCtr)(NSInteger idx);

@end
