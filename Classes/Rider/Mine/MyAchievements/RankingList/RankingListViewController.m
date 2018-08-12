//
//  RankingListViewController.m
//  RiderDemo
//
//  Created by mac on 2018/2/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RankingListViewController.h"
#import "RankingListHeaderView.h"
#import "RankingListTableViewCell.h"
#import "RankingListMode.h"
#import "AppContextManager.h"

static NSString *const cellIndentifier = @"RankingListTableViewCell";

@interface RankingListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    IBOutlet UISegmentedControl *m_rankingListSgn;
   
}
@property(nonatomic,weak)IBOutlet UITableView *m_rankingListTab;
@property(nonatomic,weak)IBOutlet UILabel *rankLbl;
@property(nonatomic,weak)IBOutlet UILabel *nameLbl;
@property(nonatomic,weak)IBOutlet UILabel *numLbl;
@property(nonatomic,weak)IBOutlet UILabel *dwLbl;
@property(nonatomic,strong) MBProgressHUD *hubView;
@property(nonatomic,strong) AppContextManager *appMger;
@property(nonatomic,strong)NSMutableArray *m_tabArr;
@property(nonatomic,strong)RankingListHeaderView *headerView;
@property(nonatomic,assign) RankListType ranType;
@end

@implementation RankingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.m_tabArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    
//    [m_rankingListSgn setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"006dcc"]} forState:UIControlStateNormal]; //正常
//    [m_rankingListSgn setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateSelected]; //选中
    
    m_rankingListSgn.layer.masksToBounds = YES;
    m_rankingListSgn.layer.borderWidth = 1.5;
    m_rankingListSgn.layer.borderColor = [UIColor colorWithHexString:@"2196d9"].CGColor;
    m_rankingListSgn.backgroundColor = [UIColor colorWithHexString:@"2196d9"];
    //     [self.m_segmentedCtr setTintColor:[UIColor colorWithHexString:@"2196d9"]];
    
    [m_rankingListSgn setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateNormal];
    //设置选中状态下的文字颜色和字体
    [m_rankingListSgn setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateSelected];

    [m_rankingListSgn addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    
    
    [self.m_rankingListTab registerNib:[UINib nibWithNibName:@"RankingListTableViewCell" bundle:nil] forCellReuseIdentifier:cellIndentifier];
    
    self.m_rankingListTab.separatorStyle = UITableViewCellSelectionStyleNone;
    self.m_rankingListTab.backgroundColor = [UIColor colorWithHexString:@"2196d9"];
    
    self.headerView = [RankingListHeaderView defaultView];
   
    
    self.hubView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hubView];
    self.hubView.label.text = @"加载中...";
    [self.hubView hideAnimated:YES];
    
    self.appMger = [AppContextManager shareManager];
    
    [self requestRankList:@"1"];
}

//点击不同分段就会有不同的事件进行相应
-(void)change:(UISegmentedControl *)sender{
    [self.m_tabArr removeAllObjects];
    if (sender.selectedSegmentIndex == 0) {
        NSLog(@"1");
        self.ranType = dayOrders;
         [self requestRankList:@"1"];
    }else if (sender.selectedSegmentIndex == 1){
        NSLog(@"2");
        self.ranType = dayMileage;
         [self requestRankList:@"2"];
    }else if (sender.selectedSegmentIndex == 2){
        NSLog(@"3");
        self.ranType = monthOrders;
        [self requestRankList:@"3"];
    }else if (sender.selectedSegmentIndex == 3){
        NSLog(@"4");
        self.ranType = monthMileage;
        [self requestRankList:@"4"];
    }
    [self.m_rankingListTab reloadData];
}

#pragma mark - UItableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.m_tabArr count];
    
}

//添加标头中的内容
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 220;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RankingListTableViewCell *cell = (RankingListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (cell == nil)
    {
        cell = [[RankingListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                      reuseIdentifier:cellIndentifier];
    }

    [cell setMode:[self.m_tabArr objectAtIndex:indexPath.row] withType:self.ranType index:indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)requestRankList:(NSString *)type
{
    
    [self.hubView showAnimated:YES];
    
    // http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.achievement.rank&openid=&type=
    
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.achievement.rank" forKey:@"r"];
    [childDic setValue:self.appMger.userID forKey:@"openid"];
    [childDic setValue:type forKey:@"type"];//type:1:日单量榜 2:日里程榜 3:月单量榜 4:月里程榜

    
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        LogInfo(@"responseDic = %@ ",responseDic);
        
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
            NSArray *listArray = [responseDic valueForKey:@"data2"];
            NSMutableArray *requestArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i = 0; i<[listArray count]; i++)
            {
                RankingListMode *listModel = [[RankingListMode alloc] init];
                [listModel parseFromDictionary:[listArray objectAtIndex:i]];
                [requestArray addObject:listModel];
            }

            [self.m_tabArr addObjectsFromArray:requestArray];
            
            NSArray *listArray1 = [responseDic valueForKey:@"data1"];
            NSMutableArray *requestArray1 = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i = 0; i<[listArray1 count]; i++)
            {
                RankingListMode *listModel = [[RankingListMode alloc] init];
                [listModel parseFromDictionary:[listArray1 objectAtIndex:i]];
                [requestArray1 addObject:listModel];
            }
             [self.headerView sendData:requestArray1 withType:self.ranType];
            
            self.rankLbl.text =[[responseDic valueForKey:@"rank"]valueForKey:@"rank"];
            self.nameLbl.text =[[responseDic valueForKey:@"rank"]valueForKey:@"name"];
            self.numLbl.text =[[responseDic valueForKey:@"rank"]valueForKey:@"distance"];
            
            if ([type isEqualToString:@"1"] || [type isEqualToString:@"3"]) {
                
                 self.dwLbl.text = @"单";
            }
            else
            {
                self.dwLbl.text = @"km";
            }
            [self.m_rankingListTab reloadData];
            
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
