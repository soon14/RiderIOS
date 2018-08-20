//
//  OrderViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/4.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderHeaderView.h"
#import "OrderTableViewCell.h"
#import "OrderDetailViewController.h"
#import "GridScreenView.h"
#import "DistributionMode.h"

static NSString *const orderCellIndentifier = @"OrderTableViewCell";

@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    
    NSMutableArray *detailArr;
    NSString *statusStr;
    NSMutableArray *mothArr;
}
@property(nonatomic,weak)IBOutlet UITableView *orderListView;
@property(nonatomic,strong)GridScreenView *historyView;
@property (nonatomic, strong) AppContextManager *appMger;
@property(nonatomic,strong) MBProgressHUD *hubView;
@property(nonatomic,strong)NSMutableArray *infoArr;
@end

@implementation OrderViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    mothArr = [[NSMutableArray alloc]initWithObjects:@"6月",@"5月",@"4月",@"3月",@"2月",@"1月",nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.appMger = [AppContextManager shareManager];
    
    self.infoArr = [[NSMutableArray alloc]initWithCapacity:0];
    
     [self.orderListView registerNib:[UINib nibWithNibName:@"OrderTableViewCell" bundle:nil] forCellReuseIdentifier:orderCellIndentifier];
    
     self.orderListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.historyView = [[GridScreenView alloc]initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height-50)];

    __weak typeof(self) weakSelf = self;
    self.historyView.didSelectView = ^(NSInteger idx){
        id sself = weakSelf;
        if(sself){
            NSLog(@"index == %lu",idx);
        }
    };
    
    self.historyView.didHiddenView = ^(NSString *str){
        id sself = weakSelf;
        if(sself){
            weakSelf.historyView.hidden = YES;
        }
    };
    
    self.historyView.hidden = YES;
    [self.view addSubview:self.historyView];
    
    self.hubView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hubView];
    self.hubView.label.text = @"加载中...";
    [self.hubView hideAnimated:YES];
    
    [self requestOrderList];
}

- (IBAction)historyView:(id)sender
{
    self.historyView.monthArr = mothArr;
      self.historyView.hidden = NO;
}

#pragma mark - UItableView delegate
//设置表头
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
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
    OrderHeaderView *headerView = [OrderHeaderView defaultView];

    return headerView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infoArr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    return 170;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    OrderTableViewCell *cell = (OrderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:orderCellIndentifier];
    
    if (cell == nil)
    {
        cell = [[OrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:orderCellIndentifier];
    }
    [cell setIndex:indexPath.row withData:self.infoArr[indexPath.row]];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        statusStr = @"settlementing";//结算中
        [self performSegueWithIdentifier:@"goOrderDetail" sender:nil];
    }
    else if (indexPath.row == 1) {
        statusStr = @"granting";//发放
        [self performSegueWithIdentifier:@"goOrderDetail" sender:nil];
    }
    else if (indexPath.row == 2) {
        statusStr = @"examining";//审核中
        [self performSegueWithIdentifier:@"goOrderDetail" sender:nil];
    }
    else if (indexPath.row == 3) {
        statusStr = @"examined";//已审核
        [self performSegueWithIdentifier:@"goOrderDetail" sender:nil];
    }
    else
    {
        statusStr = @"cancel";//取消
        
        [self performSegueWithIdentifier:@"goCancelDetail" sender:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
        if([segue.identifier isEqualToString:@"goOrderDetail"]){
            OrderDetailViewController *detailCtr = segue.destinationViewController;
            detailCtr.orderStatus = statusStr;
        }
}


- (void)requestOrderList
{
    [self.hubView showAnimated:YES];
    
    // http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.lists.finishedapp&type=&order=
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.lists.finishedapp" forKey:@"r"];
    [childDic setValue:@"1" forKey:@"type"];
    [childDic setValue:self.appMger.userID forKey:@"openid"];
    
    
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        LogInfo(@"responseDic = %@ ",responseDic);
        
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
            NSArray *listArray = [responseDic valueForKey:@"list"];
            NSMutableArray *requestArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i = 0; i<[listArray count]; i++)
            {
                DistributionMode *listModel = [[DistributionMode alloc] init];
                [listModel parseFromDictionary:[listArray objectAtIndex:i]];
                [requestArray addObject:listModel];
            }

            [self.infoArr addObjectsFromArray:requestArray];
            [self.orderListView reloadData];
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
