//
//  MineTableViewCell.m
//  RiderIOS
//
//  Created by Han on 2018/6/8.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "MineTableViewCell.h"

@interface MineTableViewCell()
{
    
}
@property(nonatomic,weak)IBOutlet UILabel *nameLbl;
@property(nonatomic,weak)IBOutlet UISwitch *swich;
@property(nonatomic,weak)IBOutlet UIImageView *arrowImage;
@property(nonatomic,weak)IBOutlet UIImageView *iconImage;
@end

@implementation MineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(NSString *)data image:(NSString *)imageName index:(NSInteger)indexRow withIsOpen:(int)isOpen
{
    if (indexRow == 0) {
        self.swich.hidden = NO;
        self.arrowImage.hidden = YES;
    }
    else
    {
        self.swich.hidden = YES;
        self.arrowImage.hidden = NO;
    }
    
    self.nameLbl.text = data;
    self.iconImage.image = [UIImage imageNamed:imageName];
    self.swich.on = isOpen == 1?YES:NO;
}

- (IBAction)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"开");
        
    }else {
        NSLog(@"关");
    }
    
    if (self.didSwichView) {
        self.didSwichView(isButtonOn);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
