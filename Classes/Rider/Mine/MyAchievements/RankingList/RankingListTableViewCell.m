//
//  RankingListTableViewCell.m
//  RiderDemo
//
//  Created by mac on 2018/2/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RankingListTableViewCell.h"

@interface RankingListTableViewCell()
{
    IBOutlet UILabel *rankLbl;
    IBOutlet UILabel *nameLbl;
    IBOutlet UIImageView *logoView;
    IBOutlet UILabel *numLbl;
    IBOutlet UILabel *companyLbl;
    IBOutlet UIImageView *bagImage;
    IBOutlet UIImageView *lineImage;
    
}
@end

@implementation RankingListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMode:(RankingListMode *)model withType:(RankListType)type index:(NSInteger)indeRow
{
    rankLbl.text = model.ranking;
    nameLbl.text = model.name;
    
    lineImage.image = [UIImage imageNamed:@"cell_line"];
    
    if (indeRow == 0) {
        bagImage.image = [UIImage imageNamed:@"up_cell"];
    }
    else
    {
        bagImage.image = [UIImage imageNamed:@"center_cell"];
    }
    
    if (type == dayMileage)
    {
         numLbl.text = model.distance;
        companyLbl.text = @"km";
    }
    else if (type == monthMileage)
    {
        numLbl.text = model.distance;
        companyLbl.text = @"km";
    }
    else
    {
        numLbl.text = model.num;
         companyLbl.text = @"单";
    }

//    logoView.layer.cornerRadius = logoView.frame.size.width/2;
//    logoView.image = [UIImage imageNamed:@"testHeard"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
