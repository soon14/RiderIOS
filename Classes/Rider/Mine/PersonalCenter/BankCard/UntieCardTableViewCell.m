//
//  UntieCardTableViewCell.m
//  RiderIOS
//
//  Created by Han on 2018/7/6.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "UntieCardTableViewCell.h"

@interface UntieCardTableViewCell()
{
    
}
@property(nonatomic,weak)IBOutlet UIImageView *bcgImage;
@property(nonatomic,weak)IBOutlet UIImageView *lineImage;
@property(nonatomic,weak)IBOutlet UILabel *titleLbl;
@property(nonatomic,weak)IBOutlet UILabel *keyLbl;
@end

@implementation UntieCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(NSString *)title indexRow:(NSInteger)indexRow withName:(NSString *)key
{
    self.titleLbl.text = title;
    self.keyLbl.text = key;
    self.lineImage.hidden = NO;
    if (indexRow == 0) {
         self.bcgImage.image = [UIImage imageNamed:@"white_up_cell"];
    }
    else if (indexRow == 1) {
        self.bcgImage.image = [UIImage imageNamed:@"white_center_cell"];
    }
    else
    {
         self.bcgImage.image = [UIImage imageNamed:@"white_bottom_cell"];
         self.lineImage.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
