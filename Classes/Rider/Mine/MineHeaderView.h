//
//  MineHeaderView.h
//  RiderIOS
//
//  Created by Han on 2018/6/8.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineHeaderView : UIView

+ (id)defaultView;
@property(nonatomic,copy) void (^didHeaderButton)(int index);

- (void)setTXImage:(NSString *)imgUrl;
@end
