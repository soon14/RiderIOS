//
//  DistributioningViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/4.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "DistributioningViewController.h"
#import "StayDistributionTableViewCell.h"
#import "GrabViewController.h"
#import "DistributionMode.h"

static NSString *const listCellIndentifier = @"StayDistributionTableViewCell";

@interface DistributioningViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
}
@property(nonatomic,strong) UITableView *m_listTaleView;
@property (nonatomic, strong) AppContextManager *appMger;
@property(nonatomic,strong) MBProgressHUD *hubView;
@property(nonatomic,strong)NSMutableArray *listArr;
@end

@implementation DistributioningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.appMger = [AppContextManager shareManager];
    
    self.m_listTaleView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.m_listTaleView =  [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    self.m_listTaleView.dataSource = self;
    self.m_listTaleView.delegate = self;
    self.m_listTaleView.sectionFooterHeight = 0;
    self.m_listTaleView.sectionHeaderHeight = 0;
    //    self.m_listTaleView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:self.m_listTaleView];
    [self.m_listTaleView registerNib:[UINib nibWithNibName:@"StayDistributionTableViewCell" bundle:nil] forCellReuseIdentifier:listCellIndentifier];
    self.m_listTaleView.separatorStyle = UITableViewCellSelectionStyleNone;
    //    self.m_listTaleView.backgroundColor = [UIColor colorWithHexString:@"eff3f8"];
    
    self.listArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    if (KIsiPhoneX) {
        self.m_listTaleView.sd_layout
        .rightSpaceToView(self.view, 0)
        .leftSpaceToView(self.view, 0)
        .topSpaceToView(self.view, 0)
        .bottomSpaceToView(self.view, 170);
    }
    else
    {
        self.m_listTaleView.sd_layout
        .rightSpaceToView(self.view, 0)
        .leftSpaceToView(self.view, 0)
        .topSpaceToView(self.view, 0)
        .bottomSpaceToView(self.view, 114);
    }
    
    self.hubView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hubView];
    self.hubView.label.text = @"加载中...";
    [self.hubView hideAnimated:YES];
    
    [self requestDistribution];
    
}

#pragma mark - UItableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.listArr count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //    if (section == 0) {
    //        return 0.1f;
    //    }
    return 0.1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    //    return 12;//这个方法不写，或者return 0跟return 12的效果一样
    return 0.1f;//把高度设置很小，效果可以看成footer的高度等于0
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 230;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StayDistributionTableViewCell *cell = (StayDistributionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:listCellIndentifier];
    
    if (cell == nil)
    {
        cell = [[StayDistributionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:listCellIndentifier];
    }
    //    cell.delegate = self;
    [cell setType:@"Distributioning" indexPath:indexPath withData:self.listArr[indexPath.row]];
    cell.didContactButton = ^(NSInteger idx) {
        NSLog(@"Contactidx == %lu",idx);
    };
    
    cell.didStatusButton = ^(NSInteger idx) {
//        NSLog(@"Statusidx == %lu",idx);
        DistributionMode *mode = self.listArr[indexPath.row];
        [self requestComplete:mode.orderID];
    };
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DistributionMode *mode = self.listArr[indexPath.row];
    
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //将第二个控制器实例化，"SecondViewController"为我们设置的控制器的ID
    GrabViewController *detailVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"GrabViewController"];
    detailVC.grabType = @"distribution";
    detailVC.hidesBottomBarWhenPushed = YES;
    detailVC.orderID = mode.orderID;
    //    detailVC.entranceStr = @"派单中";
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //    typeStr = @"";
    //    if([segue.identifier isEqualToString:@"PayToCoupon"]){
    //        QQKCouponViewController *couponCtr = segue.destinationViewController;
    //        couponCtr.delegate = self;
    //    }
}

- (void)requestDistribution
{
    [self.hubView showAnimated:YES];
    
    // http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.lists.distributionapp&type=&order=&openid=
    
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.lists.distributionapp" forKey:@"r"];
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
            
            [self.listArr addObjectsFromArray:requestArray];
            [self.m_listTaleView reloadData];
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

//完成
- (void)requestComplete:(NSString *)sid
{
    
    [self.hubView showAnimated:YES];
    
    //  http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.lists.handleapp&openid=&sid=
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.lists.handleapp" forKey:@"r"];
    [childDic setValue:sid forKey:@"sid"];
    [childDic setValue:self.appMger.userID forKey:@"openid"];
    
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        LogInfo(@"responseDic = %@ ",responseDic);
        
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
            //            NSArray *listArray = [responseDic valueForKey:@"list"];
            //            NSMutableArray *requestArray = [[NSMutableArray alloc] initWithCapacity:0];
            //            for (int i = 0; i<[listArray count]; i++)
            //            {
            //                DistributionMode *listModel = [[DistributionMode alloc] init];
            //                [listModel parseFromDictionary:[listArray objectAtIndex:i]];
            //                [requestArray addObject:listModel];
            //            }
            //
            //            [self.listArr addObjectsFromArray:requestArray];
            //            [self.m_listTaleView reloadData];
            [self.listArr removeAllObjects];
            [self requestDistribution];
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
