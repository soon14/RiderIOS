//
//  HomeTableViewCell.m
//  RiderDemo
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HomeTableViewCell.h"


@interface HomeTableViewCell()
{
    IBOutlet UILabel *dateLbl;
    IBOutlet UILabel *priceLbl;
    IBOutlet UILabel *businessAddr;
    IBOutlet UILabel *businessDis;
    IBOutlet UILabel *receiptAddr;
    IBOutlet UILabel *receiptDis;
    IBOutlet UIButton *jdBtn;
}

@end

@implementation HomeTableViewCell
@synthesize delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setData:(DistributionMode *)mode indexPath:(NSIndexPath *)pathRow withView:(NSString *)view
{
    businessAddr.text = mode.shop_name;
    businessDis.text = [NSString stringWithFormat:@"%@km",mode.shopDis];
    receiptAddr.text = mode.addrmerch;
    receiptDis.text = [NSString stringWithFormat:@"%@km",mode.userDis];
    priceLbl.text = mode.price;
    
    if ([view isEqualToString:@"Map"]) {
        jdBtn.hidden = YES;
    }
    else
    {
         jdBtn.hidden = NO;
    }
//    nameLbl.text = name;
    jdBtn.tag = 100+pathRow.row;
}

-(IBAction)clickJDBtnpress:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderBtn:)] ) {
        [self.delegate orderBtn:btn.tag-100];
    }
//    NSLog(@"btn.tag == %ld",btn.tag-100);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
