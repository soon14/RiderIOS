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
@property(nonatomic,weak) IBOutlet UILabel *moneyLbl;
@property(nonatomic,weak) IBOutlet UILabel *timeLbl;
@property(nonatomic,weak) IBOutlet UILabel *merchAddrLbl;
@property(nonatomic,weak) IBOutlet UILabel *userAddrLbl;
@property(nonatomic,weak) IBOutlet UILabel *distanceLbl;
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

- (void)sendDataArr:(NSMutableArray *)dataArr
{
    self.moneyLbl.text = [NSString stringWithFormat:@"¥%@",[dataArr objectAtIndex:0]];
    self.timeLbl.text = [NSString stringWithFormat:@"%@分钟内",[dataArr objectAtIndex:1]];
    self.merchAddrLbl.text = [dataArr objectAtIndex:2];
    self.userAddrLbl.text = [dataArr objectAtIndex:3];;
    self.distanceLbl.text = [NSString stringWithFormat:@"%@km",[dataArr objectAtIndex:4]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
