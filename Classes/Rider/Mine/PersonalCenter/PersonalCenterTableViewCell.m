//
//  PersonalCenterTableViewCell.m
//  RiderIOS
//
//  Created by Han on 2018/6/19.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "PersonalCenterTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface PersonalCenterTableViewCell()
{
    
}
@property(nonatomic,weak) IBOutlet UILabel *titleLbl;
@property(nonatomic,weak) IBOutlet UIImageView *txImage;
@property(nonatomic,weak) IBOutlet UILabel *subTitleLbl;
@property(nonatomic,weak) IBOutlet UIImageView *arrowImage;
@end
@implementation PersonalCenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage)];
    [self.txImage addGestureRecognizer:tapGesture];
    self.txImage.userInteractionEnabled = YES;
}

- (void)setData:(NSString *)data image:(UIImage *)image phoneNum:(NSString *)num adddr:(NSString *)addr withIndex:(NSInteger)index
{
    self.titleLbl.text = data;
    
    self.txImage.image = image;
    
//    [self.txImage sd_setImageWithURL:[NSURL URLWithString:imageStr]];
    
    self.txImage.hidden = YES;
    self.txImage.clipsToBounds = YES;
    self.subTitleLbl.hidden = YES;
    self.arrowImage.hidden = YES;
    
    if (index == 0) {
        self.txImage.hidden = NO;
    }
    else  if (index == 1 || index == 2) {
        self.subTitleLbl.hidden = NO;
        if (index == 1) {
            
            self.subTitleLbl.text = addr;
            
        }
        else
        {
            self.subTitleLbl.text = num;
            self.arrowImage.hidden = NO;
        }
    }
    else
    {
         self.arrowImage.hidden = NO;
    }
}

- (void)clickImage
{
    if (self.showActionSheet) {
        self.showActionSheet();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
