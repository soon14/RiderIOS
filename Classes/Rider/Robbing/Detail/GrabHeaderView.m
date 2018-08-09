//
//  GrabHeaderView.m
//  RiderDemo
//
//  Created by mac on 2018/2/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GrabHeaderView.h"

static GrabHeaderView *defaultView;

@interface GrabHeaderView()
{
    
}
@property(nonatomic,weak) IBOutlet UIView *infoView;
@end

@implementation GrabHeaderView

+ (id)defaultView{
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"GrabHeaderView" owner:nil options:nil];
    defaultView = [nibView firstObject];
    
    return defaultView;
}

- (void)isHiddenView
{
    self.infoView.hidden = YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
