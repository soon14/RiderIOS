//
//  StatusTimeTableViewCell.m
//  RiderIOS
//
//  Created by Han on 2018/6/6.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "StatusTimeTableViewCell.h"

@interface StatusTimeTableViewCell()
{
    
}
@property(nonatomic,weak)IBOutlet UILabel *qdLbl;
@property(nonatomic,weak)IBOutlet UILabel *qhLbl;
@property(nonatomic,weak)IBOutlet UILabel *sdLbl;
@end

@implementation StatusTimeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)sendData:(NSMutableArray *)dataArr
{
    self.qdLbl.text = [dataArr objectAtIndex:0];
    self.qhLbl.text = [dataArr objectAtIndex:1];
    self.sdLbl.text = [dataArr objectAtIndex:2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
