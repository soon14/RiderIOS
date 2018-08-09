//
//  MyNavgationViewController.m
//  RiderDemo
//
//  Created by mac on 2018/3/1.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MyNavgationViewController.h"
//#import "LoginViewController.h"

@interface MyNavgationViewController ()
{
    
}
@end

@implementation MyNavgationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 如果滑动移除控制器的功能失效，清空代理（让导航控制器重新设置这个功能）
//    self.interactivePopGestureRecognizer.delegate = nil;
    
    //设置导航栏背景颜色
    self.navigationBar.barTintColor = [UIColor colorWithHexString:@"2196d9"];
    
    
    //设置字体颜色
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    //设置字体颜色大小
//    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:19]}];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
     
//        self.navigationBar.translucent = NO;

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
          [btn setTitle:@"" forState:UIControlStateNormal];
        
//       if ([self.childViewControllers.lastObject isKindOfClass:[MineViewController class]]) {

//                [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//                btn.userInteractionEnabled = NO;
//            }
//            else
//            {
                 [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
                 btn.userInteractionEnabled = YES;
        
//            }
        
        
//        }
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        
        [btn sizeToFit];
        // 让按钮内部的所有内容左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        btn.backgroundColor = [UIColor redColor];
        //设置内边距，让按钮靠近屏幕边缘
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
//        viewController.view.backgroundColor = [UIColor colorWithHexString:@"eff3f8"];
        
        viewController.hidesBottomBarWhenPushed = YES; // 隐藏底部的工具条
    }
    
    // 一旦调用super的pushViewController方法,就会创建子控制器viewController的view并调用viewController的viewDidLoad方法。可以在viewDidLoad方法中重新设置自己想要的左上角按钮样式
    [super pushViewController:viewController animated:animated];
    
}

-(void)back
{
    [self popViewControllerAnimated:YES];
}

-(UIStatusBarStyle)preferredStatusBarStyle

{
    
    return UIStatusBarStyleLightContent;
    
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
