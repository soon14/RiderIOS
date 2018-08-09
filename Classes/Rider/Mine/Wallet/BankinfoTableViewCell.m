//
//  BankinfoTableViewCell.m
//  RiderIOS
//
//  Created by Han on 2018/6/11.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "BankinfoTableViewCell.h"

@interface BankinfoTableViewCell()
{
    
}
@property(nonatomic,weak)IBOutlet UILabel *titleLbl;
@property(nonatomic,weak)IBOutlet UILabel *keyLbl;
@property(nonatomic,weak)IBOutlet UIImageView *iconImage;
@property(nonatomic,weak)IBOutlet UIImageView *lineImage;
@end

@implementation BankinfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(NSString *)title key:(NSString *)key withIndexRow:(NSInteger)indexRow
{
    self.titleLbl.text =title;
    self.keyLbl.text = key;
    self.lineImage.hidden = YES;
    
    if(indexRow == 0)
    {
        self.keyLbl.font = [UIFont systemFontOfSize:16];
        self.keyLbl.textColor = [UIColor blackColor];
        self.iconImage.hidden = NO;
    }
    else
    {
        self.keyLbl.font = [UIFont systemFontOfSize:14];
        self.keyLbl.textColor = [UIColor colorWithHexString:@"ff8a00"];
        self.iconImage.hidden = YES;
        
    }
    
    if (indexRow == 2) {
        self.lineImage.hidden = NO;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
