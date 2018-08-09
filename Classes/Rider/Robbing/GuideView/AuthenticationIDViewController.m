//
//  AuthenticationIDViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/14.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "AuthenticationIDViewController.h"

@interface AuthenticationIDViewController ()

@property (nonatomic, weak)IBOutlet UIImageView *zmImage;
@property (nonatomic, weak)IBOutlet UIButton *zmBtn;
@property (nonatomic, weak)IBOutlet UIImageView *scImage;
@property (nonatomic, weak)IBOutlet UIButton *scBtn;
@end

@implementation AuthenticationIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    //[leftbutton setBackgroundColor:[UIColor blackColor]];
    [rightbutton setTitle:@"下一步" forState:UIControlStateNormal];
    [rightbutton setFont:[UIFont systemFontOfSize:17]];
    [rightbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    [rightbutton addTarget:self action:@selector(nextPress) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=rightitem;
    
    self.zmBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.zmBtn.layer.borderWidth = 1;
    self.scBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.scBtn.layer.borderWidth = 1;
}

- (void)nextPress
{
    
    [self performSegueWithIdentifier:@"goRealName" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //    typeStr = @"";
    //    if([segue.identifier isEqualToString:@"PayToCoupon"]){
    //        QQKCouponViewController *couponCtr = segue.destinationViewController;
    //        couponCtr.delegate = self;
    //    }
    
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
