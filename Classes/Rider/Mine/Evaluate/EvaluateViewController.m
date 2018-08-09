//
//  EvaluateViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/12.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "EvaluateViewController.h"
#import "ZWMSegmentController.h"
#import "CustomerViewController.h"
#import "BusinessViewController.h"

@interface EvaluateViewController ()
{
    UIImageView *navBarHairlineImageView;
}
@property (nonatomic, strong) ZWMSegmentController *segmentVC;
@end

@implementation EvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    //顾客评价
    CustomerViewController *customerVC = [[CustomerViewController alloc] init];
    //商家评价
    BusinessViewController *businessVC = [[BusinessViewController alloc] init];
    
    NSArray *array = @[customerVC,businessVC];
    
    self.segmentVC = [[ZWMSegmentController alloc] initWithFrame:self.view.bounds titles:@[@"顾客评价",@"商家评价"]];
    self.segmentVC.segmentView.style=ZWMSegmentStyleDefault;
    self.segmentVC.segmentView.showSeparateLine = YES;
    self.segmentVC.segmentView.backgroundColor = [UIColor colorWithHexString:@"2196d9"];
    self.segmentVC.segmentView.segmentNormalColor = [UIColor whiteColor];
    self.segmentVC.segmentView.segmentTintColor = [UIColor whiteColor];
    self.segmentVC.viewControllers = [array copy];
    
    //    if (array.count==1) {
    //        self.segmentVC.segmentView.style=ZWMSegmentStyleDefault;
    //    } else {
    
    //    }
    //    [self.segmentVC  enumerateBadges:@[@(1),@10]];
    
    [self addSegmentController:self.segmentVC];
    [self.segmentVC  setSelectedAtIndex:0];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    navBarHairlineImageView.hidden = YES;
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    navBarHairlineImageView.hidden = NO;
    self.navigationController.navigationBar.translucent = YES;
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
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
