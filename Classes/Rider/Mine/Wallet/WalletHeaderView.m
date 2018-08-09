//
//  WalletHeaderView.m
//  RiderIOS
//
//  Created by Han on 2018/6/11.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "WalletHeaderView.h"

static WalletHeaderView *defaultView;

@interface WalletHeaderView()
{
    
}
@property(nonatomic,weak)IBOutlet UILabel *balanceLbl;
@end

@implementation WalletHeaderView


+ (id)defaultView{
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"WalletHeaderView" owner:nil options:nil];
    defaultView = [nibView firstObject];
    
    return defaultView;
}

- (void)getBalanceData:(NSString *)balance
{
    self.balanceLbl.text = balance;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
