//
//  SettingViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/13.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MyNavgationViewController.h"

static NSString *const cellIndentifier = @"SettingTableViewCell";

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
     NSMutableArray *setArr;
    
}
@property(nonatomic,weak)IBOutlet UITableView *m_setTaleView;
@property(nonatomic,strong) MBProgressHUD *hubView;
@property(nonatomic,assign) unsigned long long size;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden = YES;
    
    setArr = [[NSMutableArray alloc]initWithObjects:@"清除缓存",@"管理细则",@"关于我们",@"退出登录",nil];
    
    [self.m_setTaleView registerNib:[UINib nibWithNibName:@"SettingTableViewCell" bundle:nil] forCellReuseIdentifier:cellIndentifier];
    self.m_setTaleView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.hubView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hubView];
    self.hubView.label.text = @"加载中...";
    [self.hubView hideAnimated:YES];
    
    self.size = [SDImageCache sharedImageCache].getSize;
}

#pragma mark - UItableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [setArr count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    //    return 12;//这个方法不写，或者return 0跟return 12的效果一样
    return 0.1f;//把高度设置很小，效果可以看成footer的高度等于0
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SettingTableViewCell *cell = (SettingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (cell == nil)
    {
        cell = [[SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:cellIndentifier];
    }
    
    [cell setData:setArr[indexPath.row] indexRow:indexPath.row withCache:self.size];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//        [self performSegueWithIdentifier:@"goAchievements" sender:nil];
    if (indexPath.row == 0)
    {
        [self clearCacheClick];
    }
    else if (indexPath.row == 3) {
       NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"NO" forKey:@"Login"];
        
        UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MyNavgationViewController *vc = [mainStory instantiateViewControllerWithIdentifier:@"LoginNav"];
        self.view.window.rootViewController = vc;
        
    }
}

- (void)clearCacheClick
{
    [self.hubView showAnimated:YES];
    
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
             self.size = [SDImageCache sharedImageCache].getSize;
            
            dispatch_async(dispatch_get_main_queue(), ^{
            
                [self.hubView hideAnimated:YES];
                [self.m_setTaleView reloadData];
                
            });
        });
    }];
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
