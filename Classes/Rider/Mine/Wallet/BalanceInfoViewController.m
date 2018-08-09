//
//  BalanceViewController.m
//  RiderDemo
//
//  Created by mac on 2018/1/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BalanceInfoViewController.h"
#import "BalanceInfoTableViewCell.h"
#import "BalanceInfMoodel.h"

static NSString *const balanceInfoCellIndentifier = @"BalanceInfoTableViewCell";

@interface BalanceInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView *navBarHairlineImageView;
    NSString *selectType;
}
@property(nonatomic,strong)IBOutlet UITableView *m_balanceTableView;
@property(nonatomic,strong)IBOutlet UISegmentedControl *m_segmentedControl;
@property(nonatomic,strong) MBProgressHUD *hubView;
@property(nonatomic,strong) AppContextManager *appMger;
@property(nonatomic,strong) NSMutableArray *m_balanceArr;
@end

@implementation BalanceInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    selectType = @"SZ";
    
     navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    [self.m_balanceTableView registerNib:[UINib nibWithNibName:@"BalanceInfoTableViewCell" bundle:nil] forCellReuseIdentifier:balanceInfoCellIndentifier];
    self.m_balanceTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.m_balanceArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    __weak typeof(self) weakSelf = self;
    self.m_balanceTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //刷新时候，需要执行的代码。一般是请求最新数据，请求成功之后，刷新列表
        [weakSelf loadNewData];
    }];
    
    self.m_balanceTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //刷新时候，需要执行的代码。一般是请求更多数据，请求成功之后，刷新列表
        [weakSelf loadNoreData];
    }];
    
    _m_segmentedControl.layer.masksToBounds = YES;
    _m_segmentedControl.layer.borderWidth = 1.5;
    _m_segmentedControl.layer.borderColor = [UIColor colorWithHexString:@"2196d9"].CGColor;
    _m_segmentedControl.backgroundColor = [UIColor colorWithHexString:@"2196d9"];
    //     [self.m_segmentedCtr setTintColor:[UIColor colorWithHexString:@"2196d9"]];
    
    [_m_segmentedControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateNormal];
    //设置选中状态下的文字颜色和字体
    [_m_segmentedControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateSelected];

    self.hubView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hubView];
    self.hubView.label.text = @"上传中...";
    [self.hubView hideAnimated:YES];
    
    self.appMger = [AppContextManager shareManager];
    
    [self requestBalanceInfo];
}

-(IBAction)changeInfo:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
        
        selectType = @"SZ";
        [self requestBalanceInfo];
        
    }else if (sender.selectedSegmentIndex == 1){
        
        selectType = @"TX";
        [self requestWithdrawCash];
    }
    
    [self.m_balanceTableView reloadData];
}

- (void)loadNewData {
    NSLog(@"请求获取最新的数据");
    //这里假设2秒之后获取到了最新的数据，刷新tableview，并且结束刷新控件的刷新状态
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //刷新列表
        [weakSelf.m_balanceTableView reloadData];
        //拿到当前的刷新控件，结束刷新状态
        [weakSelf.m_balanceTableView.mj_header endRefreshing];
    });
}

/**
 请求获取更多的数据
 */
- (void)loadNoreData {
    NSLog(@"请求获取更多的数据");
    
    //这里假设2秒之后获取到了更多的数据，刷新tableview，并且结束刷新控件的刷新状态
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //刷新列表
        [weakSelf.m_balanceTableView reloadData];
        //拿到当前的刷新控件，结束刷新状态
        [weakSelf.m_balanceTableView.mj_footer endRefreshing];
    });
}

#pragma mark - UItableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.m_balanceArr count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BalanceInfoTableViewCell *cell = (BalanceInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:balanceInfoCellIndentifier];
    
    if (cell == nil)
    {
        cell = [[BalanceInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:balanceInfoCellIndentifier];
    }
    
    [cell setData:self.m_balanceArr[indexPath.row] withType:selectType];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    if (indexPath.row == 0) {
    //
    //        [self performSegueWithIdentifier:@"ToMineInfo" sender:nil];
    //    }
    //    else if(indexPath.row == 4)
    //    {
    //        [self performSegueWithIdentifier:@"ToPersonalCenter" sender:nil];
    //    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //    typeStr = @"";
    //    if([segue.identifier isEqualToString:@"PayToCoupon"]){
    //        QQKCouponViewController *couponCtr = segue.destinationViewController;
    //        couponCtr.delegate = self;
    //    }
}

//收支明细
- (void)requestBalanceInfo
{
    
    [self.hubView showAnimated:YES];
    
    // http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.wallet.detailedapp&openid=
    
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.wallet.detailedapp" forKey:@"r"];
    [childDic setValue:self.appMger.userID forKey:@"openid"];

    
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        LogInfo(@"responseDic = %@ ",responseDic);
        
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
            
            NSArray *listArray = [responseDic valueForKey:@"show"];
            NSMutableArray *requestArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i = 0; i<[listArray count]; i++)
            {
                
                BalanceInfMoodel *listModel = [[BalanceInfMoodel alloc] init];
                [listModel parseFromDictionary:[listArray objectAtIndex:i]];
                [requestArray addObject:listModel];
            }
            
            [self.m_balanceArr addObjectsFromArray:requestArray];
            
            [self.m_balanceTableView reloadData];
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

//提现记录
- (void)requestWithdrawCash
{
    
    [self.hubView showAnimated:YES];
    
    // http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.wallet.detailed_recordapp&openid=
    
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.wallet.detailed_recordapp" forKey:@"r"];
    [childDic setValue:self.appMger.userID forKey:@"openid"];
    
    
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        LogInfo(@"responseDic = %@ ",responseDic);
        
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
            
            NSArray *listArray = [responseDic valueForKey:@"show"];
            NSMutableArray *requestArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i = 0; i<[listArray count]; i++)
            {
                
                BalanceInfMoodel *listModel = [[BalanceInfMoodel alloc] init];
                [listModel parseFromDictionary:[listArray objectAtIndex:i]];
                [requestArray addObject:listModel];
            }
            
            [self.m_balanceArr addObjectsFromArray:requestArray];
            
            [self.m_balanceTableView reloadData];
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
