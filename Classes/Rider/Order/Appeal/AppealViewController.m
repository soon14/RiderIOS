//
//  AppealViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/10.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "AppealViewController.h"
#import "HWDownSelectedView.h"

@interface AppealViewController ()
@property (weak, nonatomic) IBOutlet HWDownSelectedView *selectView;
@end

@implementation AppealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectView.placeholder = @"原因选择";
    self.selectView.listArray = @[@"顾客修改配送地址/时间", @"商家出餐慢", @"取餐时定位出错", @"送达时定位出错", @"其他"];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.selectView close];
}

- (IBAction)goAppealSuccess:(id)sender {
    
    [self performSegueWithIdentifier:@"goAppealSuccess" sender:nil];
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
