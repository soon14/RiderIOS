//
//  OrderdDetailTableViewCell.m
//  RiderIOS
//
//  Created by Han on 2018/6/7.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "OrderdDetailTableViewCell.h"

@interface OrderdDetailTableViewCell()
{
    
}
@property(nonatomic,weak)IBOutlet UILabel *nameLbl;
@property(nonatomic,weak)IBOutlet UILabel *moneyLbl;
@property(nonatomic,weak)IBOutlet UILabel *titleLbl;
@property(nonatomic,weak)IBOutlet UILabel *contentLbl;
@property(nonatomic,weak)IBOutlet UIImageView *lineImage;
@end

@implementation OrderdDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(NSMutableArray *)data index:(NSInteger)indexRow withStatus:(NSString *)status
{
    self.lineImage.hidden = YES;
        
    if (indexRow == [data count]-1) {
        
        if ([status isEqualToString:@"settlementing"]) {
            self.titleLbl.text = @"结算中";
            self.contentLbl.text = @"系统结算中，结算周期为24-48小时，通过后将发放奖励，请耐心等待";
        }
        else if ([status isEqualToString:@"granting"])
        {
            self.titleLbl.text = @"部分发放";
            self.contentLbl.text = @"不规范取餐（取餐超时15分钟）不规范送餐（送餐超时5分钟）";
        }
        else if ([status isEqualToString:@"examining"])
        {
            self.titleLbl.text = @"审核中";
            self.contentLbl.text = @"系统审核中，结算周期为24-48小时，通过后将发放奖励，请耐心等待）";
        }
        else if ([status isEqualToString:@"examined"])
        {
            self.titleLbl.text = @"已审核";
            self.contentLbl.text = @"审核通过";
        }
        self.titleLbl.hidden = NO;
        self.contentLbl.hidden = NO;
        self.nameLbl.hidden = YES;
        self.moneyLbl.hidden = YES;
       
    }
    else
    {
        
        self.nameLbl.text = data[indexRow];
        self.nameLbl.hidden = NO;
        self.moneyLbl.hidden = NO;
        self.titleLbl.hidden = YES;
        self.contentLbl.hidden = YES;
    }
    
    if ([data count]>3) {
        if (indexRow == [data count]-3)
        {
            self.lineImage.hidden = NO;
        }
    }
    else
    {
        if (indexRow == [data count]-2)
        {
            self.lineImage.hidden = NO;
        }
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
