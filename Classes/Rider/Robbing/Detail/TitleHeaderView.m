//
//  TitleHeaderView.m
//  RiderIOS
//
//  Created by Han on 2018/6/5.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "TitleHeaderView.h"

static TitleHeaderView *defaultView;

@interface TitleHeaderView()

@end

@implementation TitleHeaderView
@synthesize titleLbl;
+ (id)defaultView{
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"TitleHeaderView" owner:nil options:nil];
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
