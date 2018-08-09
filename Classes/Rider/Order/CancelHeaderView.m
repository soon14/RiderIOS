//
//  CancelHeaderView.m
//  RiderIOS
//
//  Created by Han on 2018/6/8.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "CancelHeaderView.h"

static CancelHeaderView *defaultView;

@implementation CancelHeaderView

+ (id)defaultView{
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"CancelHeaderView" owner:nil options:nil];
    defaultView = [nibView firstObject];
    
    return defaultView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
