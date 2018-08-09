//
//  ExamineHealthViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/11.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "ExamineHealthViewController.h"
#import "UIImageView+WebCache.h"

@interface ExamineHealthViewController ()
@property(nonatomic,weak)IBOutlet UILabel *statusLbl;
@property(nonatomic,weak)IBOutlet UILabel *subLbl;
@property(nonatomic,weak)IBOutlet UILabel *validityLbl;
@property(nonatomic,weak)IBOutlet UIImageView *healthImageView;
@property(nonatomic,weak)IBOutlet UIButton *submitBtn;
@end

@implementation ExamineHealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.statusLbl.hidden = YES;
    self.subLbl.hidden = YES;
    self.validityLbl.hidden = YES;
    self.healthImageView.hidden = YES;
    self.submitBtn.hidden = YES;

     //status : 1 审核中 2 已通过 3 未通过
    if (self.status == 1) {
        self.statusLbl.hidden = NO;
        self.subLbl.hidden = NO;
        self.statusLbl.text = @"已上传成功，审核中";
        self.subLbl.text = @"将在两个工作日内给出审核结果";
    }
    else if (self.status == 2)
    {
        self.validityLbl.hidden = NO;
        self.healthImageView.hidden = NO;
        self.validityLbl.text = @"健康证有效期至2019年6月5日";
        [self.healthImageView sd_setImageWithURL:[NSURL URLWithString:self.imgUrl]];
    }
    else
    {
//        self.statusLbl.hidden = NO;
//        self.submitBtn.hidden = NO;
//        self.healthImageView.hidden = NO;
//        self.statusLbl.text = @"健康证审核未通过，请重新上传";
//        [self.healthImageView setImage:[UIImage imageNamed:@"tj"]];
//        [self.healthImageView sd_setImageWithURL:[NSURL URLWithString:self.imgUrl]];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
