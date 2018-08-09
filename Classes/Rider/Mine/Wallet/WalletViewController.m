//
//  WalletViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/11.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "WalletViewController.h"
#import "WalletHeaderView.h"
#import "WalletTableViewCell.h"
#import "BondViewController.h"

static NSString *const walletCellIndentifier = @"WalletTableViewCell";

@interface WalletViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    NSMutableArray *titleArr;
    NSMutableArray *imageArr;
    
    
}
@property(nonatomic,strong) UIImageView *lineView;
@property(nonatomic,weak)IBOutlet UITableView *walletListView;
@property(nonatomic,strong) WalletHeaderView *headerView;
@property(nonatomic,strong) MBProgressHUD *hubView;
@property(nonatomic,strong) AppContextManager *appMger;
@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _lineView = [self getLineViewInNavigationBar:self.navigationController.navigationBar];
    
    titleArr = [[NSMutableArray alloc]initWithObjects:@"申请提现",@"查看明细",@"保证金",nil];
    imageArr = [[NSMutableArray alloc]initWithObjects:@"cktx",@"mx",@"bzj",nil];
    self.headerView = [WalletHeaderView defaultView];
    
    self.walletListView.scrollEnabled = NO;
    [self.walletListView registerNib:[UINib nibWithNibName:@"WalletTableViewCell" bundle:nil] forCellReuseIdentifier:walletCellIndentifier];
    
      self.walletListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.hubView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hubView];
    self.hubView.label.text = @"上传中...";
    [self.hubView hideAnimated:YES];
    
    self.appMger = [AppContextManager shareManager];
    
    [self requestBalance];
}

- (void)requestBalance
{
    
    [self.hubView showAnimated:YES];
    
    // http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.wallet.indexapp&openid=
    
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.wallet.indexapp" forKey:@"r"];
    [childDic setValue:self.appMger.userID forKey:@"openid"];
    
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
//        LogInfo(@"responseDic = %@ ",responseDic);
        
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
            NSString *balance = [[responseDic valueForKey:@"show"] valueForKey:@"balance"];
            [self.headerView getBalanceData:balance];
            //            [self performSegueWithIdentifier:@"ToExamineHealth" sender:nil];
        }
        else
        {
            NSString *errorMessage = [responseDic valueForKey:@"message"];
            [ShowErrorMgs sendErrorCode:errorMessage withCtr:self];
        }
        
        [self.hubView hideAnimated:YES];
    } FailureBlock:^(id error) {
        NSLog(@"error == %@",error);
        [self.hubView hideAnimated:YES];
        [ShowErrorMgs sendErrorCode:@"服务器错误，请稍后重试！" withCtr:self];
    }];
}

#pragma mark - UItableView delegate
//设置表头
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 130;
    }
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    if (section == 0) {
        return self.headerView;
    }
    return nil;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [titleArr count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WalletTableViewCell *cell = (WalletTableViewCell *)[tableView dequeueReusableCellWithIdentifier:walletCellIndentifier];

    if (cell == nil)
    {
        cell = [[WalletTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:walletCellIndentifier];
    }
    [cell setData:titleArr[indexPath.section] imageName:imageArr[indexPath.section] money:@"" withIndex:indexPath.section];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
//
}
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        [self performSegueWithIdentifier:@"goCash" sender:nil];
    }
    else if (indexPath.section == 1)
    {
        
         [self performSegueWithIdentifier:@"goBalanceInfo" sender:nil];
    }
    else
    {
        
        [self performSegueWithIdentifier:@"goBond" sender:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"goBond"]){
        BondViewController *bondCtr = segue.destinationViewController;
         __weak typeof(self) weakSelf = self;
        bondCtr.refundBlock = ^{
            
            [weakSelf requestBalance];
            
        };
    }
    
}

 -(void)viewWillAppear:(BOOL)animated {
     [super viewWillAppear:YES];
     
     
     _lineView.hidden = YES;
     self.navigationController.navigationBar.translucent = NO;
 }
 
 -(void)viewWillDisappear:(BOOL)animated {
     [super viewWillDisappear:YES];
 
     _lineView.hidden = NO;
     self.navigationController.navigationBar.translucent = YES;
 }

//找到导航栏最下面黑线视图
- (UIImageView *)getLineViewInNavigationBar:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self getLineViewInNavigationBar:subview];
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
