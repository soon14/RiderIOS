//
//  AddBankCardTableViewCell.m
//  RiderIOS
//
//  Created by Han on 2018/7/3.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "AddBankCardTableViewCell.h"

@interface AddBankCardTableViewCell()<UITextFieldDelegate>
{
    
}
@property(nonatomic,weak)IBOutlet UILabel *titleLbl;
@property(nonatomic,weak)IBOutlet UILabel *nameLbl;
@property(nonatomic,weak)IBOutlet UITextField *cardField;
@property(nonatomic,weak)IBOutlet UIImageView *arrowImage;
@property(nonatomic,weak)IBOutlet UIImageView *lineImage;
@end

@implementation AddBankCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    self.cardField.keyboardType = UIKeyboardTypeDecimalPad;
    self.cardField.delegate = self;
}

- (void)setData:(NSString *)title bankName:(NSString *)bankName withIndexRow:(NSInteger)indexRow
{
    self.titleLbl.text = title;
     self.nameLbl.text = bankName;
    self.arrowImage.hidden = YES;
    self.nameLbl.hidden = NO;
    self.cardField.hidden = YES;
    self.lineImage.hidden = NO;
    self.cardField.tag = 100+indexRow;
    if (indexRow == 0) {
        self.nameLbl.text = @"赵*勇";
        self.nameLbl.textColor = [UIColor blackColor];
    }
    else if (indexRow == 1)
    {
        if ([bankName isEqualToString:@"请选择您的开户银行"]) {
            self.nameLbl.textColor = [UIColor colorWithHexString:@"c1c1c1"];
        }
        else
        {
            self.nameLbl.textColor = [UIColor blackColor];
        }
        self.arrowImage.hidden = NO;
    }
    else if (indexRow == 2)
    {
        self.nameLbl.hidden = YES;
        self.cardField.hidden = NO;
        self.lineImage.hidden = YES;
        self.cardField.placeholder = @"XX市XX区XX分行";
    }
    else
    {
        self.nameLbl.hidden = YES;
        self.cardField.hidden = NO;
        self.lineImage.hidden = YES;
    }
    
}

- ( BOOL )textFieldShouldBeginEditing:( UITextField *)textField
{
    if (self.beginEditingBlock) {
        self.beginEditingBlock();
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    if (self.returnBlock) {
        self.returnBlock(textField.text);
    }
    return YES;
}

- ( void )textFieldDidEndEditing:( UITextField *)textField
{
    NSLog(@"taaaag == %ld",textField.tag-100);

    if (self.endEditingBlock) {
        self.endEditingBlock(textField.text,textField.tag-100);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
