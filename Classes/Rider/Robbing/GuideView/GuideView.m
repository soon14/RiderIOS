//
//  GuideView.m
//  RiderIOS
//
//  Created by Han on 2018/6/14.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "GuideView.h"

@interface GuideView()
{
    NSInteger index;
}
@property(nonatomic,strong) IBOutlet UIImageView *backgoundView;
@property(nonatomic,strong) IBOutlet UIView *bottomView;
@property(nonatomic,strong) IBOutlet UILabel *firstLbl;
@property(nonatomic,strong) IBOutlet UILabel *secondLbl;
@property(nonatomic,strong) IBOutlet UIButton *pushBtn;
@property(nonatomic,strong) IBOutlet UIView *beforeView;
@property(nonatomic,strong) IBOutlet UIView *afterView;
@property(nonatomic,strong) IBOutlet UIButton *againBtn;
@property(nonatomic,strong) IBOutlet UILabel *promptLbl;

@end

@implementation GuideView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibs=[[NSBundle mainBundle]loadNibNamed:@"GuideView" owner:nil options:nil];
        self=[nibs objectAtIndex:0];
        self.frame = frame;
        self.backgoundView.userInteractionEnabled = YES;
    }
    
     return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([touch view] == self.backgoundView)
    {
        //do some method.....
        if(self.didHiddenView){
            self.didHiddenView(@"");
        }
    }
    
}

- (IBAction)selectPress:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    index = btn.tag-120;
    if (btn.tag-120 == 0) {
        self.firstLbl.text = @"请准备好身份证";
        self.secondLbl.text = @"我们保证您的个人信息不回泄露，请放心";
        [self.pushBtn setTitle:@"去认证" forState:UIControlStateNormal];
    }
    else if (btn.tag-120 == 1)
    {
        self.firstLbl.text = @"请完成线上培训";
        self.secondLbl.text = @"完成培训后进行线上考试";
        [self.pushBtn setTitle:@"去培训" forState:UIControlStateNormal];
    }
    else
    {
        self.firstLbl.text = @"您需要缴纳保证金才可以接单";
        self.secondLbl.text = @"保证金只做担保，随时可退，平台不回随意扣款";
        [self.pushBtn setTitle:@"去缴纳保证金" forState:UIControlStateNormal];
    }
    
    if (self.didSelectView) {
        self.didSelectView(btn.tag-120);
    }
}

- (IBAction)againPress:(id)sender
{
   
}

- (IBAction)pushPress:(id)sende
{
//    self.beforeView.hidden = YES;
//    self.afterView.hidden = NO;
    if (self.pushCtr) {
        self.pushCtr(index);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
