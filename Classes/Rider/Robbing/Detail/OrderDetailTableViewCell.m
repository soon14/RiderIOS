//
//  OrderDetailTableViewCell.m
//  RiderIOS
//
//  Created by Han on 2018/6/6.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "OrderDetailTableViewCell.h"
#import "OrderDetailMode.h"

@interface OrderDetailTableViewCell()
{
    
}
@property(nonatomic,weak)IBOutlet UILabel *nameLbl;
@property(nonatomic,weak)IBOutlet UILabel *numLbl;
@property(nonatomic,weak)IBOutlet UILabel *moneyLbl;
@property(nonatomic,weak)IBOutlet UIImageView *lineImage;
@end

@implementation OrderDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(NSMutableArray *)data count:(NSInteger)count index:(NSInteger)indexRow withIsLast:(BOOL)islast
{
    OrderDetailMode *mode = [data objectAtIndex:indexRow];
    self.nameLbl.text = mode.title;
    self.numLbl.text = [NSString stringWithFormat:@"x%@",mode.total];
    self.moneyLbl.text = [NSString stringWithFormat:@"￥%@",mode.price];
    self.lineImage.hidden = YES;
//    self.numLbl.hidden = NO;
//    if (indexRow == 3 || indexRow == 5) {
//        self.lineImage.hidden = NO;
//         self.numLbl.hidden = YES;
//    }
//
//    if (indexRow == count-1) {
////         self.nameLbl.text = mode.name;
//        self.nameLbl.text = [NSString stringWithFormat:@"总计：￥%@",mode.name];
//        self.moneyLbl.text = [NSString stringWithFormat:@"实付：￥%@",mode.money];
//         self.numLbl.hidden = YES;
//    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
