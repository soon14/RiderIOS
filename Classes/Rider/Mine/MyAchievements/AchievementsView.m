//
//  AchievementsView.m
//  RiderIOS
//
//  Created by Han on 2018/6/10.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "AchievementsView.h"

static AchievementsView *defaultView;

@interface AchievementsView()
{
    
}
@property(nonatomic,weak)IBOutlet UILabel *titleLbl;
@end

@implementation AchievementsView

+ (id)defaultView{
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"AchievementsView" owner:nil options:nil];
    defaultView = [nibView firstObject];
    
    return defaultView;
}

- (void)setTitle:(NSString *)title
{
    self.titleLbl.text = title;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
