//
//  RankingListHeaderView.m
//  RiderDemo
//
//  Created by mac on 2018/2/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RankingListHeaderView.h"
#import "RankingListMode.h"

static RankingListHeaderView *defaultView;

@interface RankingListHeaderView()
{
    IBOutlet UIImageView *firstImageView;
    IBOutlet UIImageView *secondImageView;
    IBOutlet UIImageView *thirdImageView;
}
@property(nonatomic,weak)IBOutlet UILabel *firstNameLbl;
@property(nonatomic,weak)IBOutlet UILabel *firstNumLbl;
@property(nonatomic,weak)IBOutlet UILabel *firstCompanyLbl;
@property(nonatomic,weak)IBOutlet UILabel *secNameLbl;
@property(nonatomic,weak)IBOutlet UILabel *secNumLbl;
@property(nonatomic,weak)IBOutlet UILabel *secCompanyLbl;
@property(nonatomic,weak)IBOutlet UILabel *thirdNameLbl;
@property(nonatomic,weak)IBOutlet UILabel *thirdNumLbl;
@property(nonatomic,weak)IBOutlet UILabel *thirdCompanyLbl;

@end

@implementation RankingListHeaderView

+ (id)defaultView{
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"RankingListHeaderView" owner:nil options:nil];
    defaultView = [nibView firstObject];
    
    return defaultView;
}

- (void)sendData:(NSMutableArray *)dataArr withType:(RankListType)type
{
    if (dataArr.count > 0) {
        self.firstNameLbl.hidden = NO;
        self.firstNumLbl.hidden = NO;
        self.secNameLbl.hidden = NO;
        self.secNumLbl.hidden = NO;
        self.thirdNameLbl.hidden = NO;
        self.thirdNumLbl.hidden = NO;
        self.firstCompanyLbl.hidden = NO;
        self.secCompanyLbl.hidden = NO;
        self.thirdCompanyLbl.hidden = NO;
    }
    else
    {
        self.firstNameLbl.hidden = YES;
        self.firstNumLbl.hidden = YES;
        self.secNameLbl.hidden = YES;
        self.secNumLbl.hidden = YES;
        self.thirdNameLbl.hidden = YES;
        self.thirdNumLbl.hidden = YES;
        self.firstCompanyLbl.hidden = YES;
        self.secCompanyLbl.hidden = YES;
        self.thirdCompanyLbl.hidden = YES;
    }
    
    for (int i = 0; i < dataArr.count; i++) {
        RankingListMode *mode = [dataArr objectAtIndex:i];
        if (i == 0) {
            self.firstNameLbl.text = mode.name;
            
            if (type == dayMileage || type == monthMileage) {
                self.firstNumLbl.text = mode.distance;
                self.firstCompanyLbl.text = @"km";
            }
            else
            {
                self.firstNumLbl.text = mode.num;
                self.firstCompanyLbl.hidden = @"单";
            }
        }
        else if (i ==1)
        {
            self.secNameLbl.text = mode.name;
        
            if (type == dayMileage || type == monthMileage) {
                self.secNumLbl.text = mode.distance;
                self.secCompanyLbl.text = @"km";
            }
            else
            {
                self.secNumLbl.text = mode.num;
                self.secCompanyLbl.hidden = @"单";
            }
        }
        else
        {
            self.thirdNameLbl.text = mode.name;
            
            if (type == dayMileage || type == monthMileage) {
                self.thirdNumLbl.text = mode.distance;
                self.thirdCompanyLbl.text = @"km";
            }
            else
            {
                self.thirdNumLbl.text = mode.num;
                self.thirdCompanyLbl.hidden = @"单";
            }
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
