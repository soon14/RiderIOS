//
//  BusinessViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/12.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "BusinessViewController.h"
#import "CustomerTableViewCell.h"

static NSString *const businessCellIndentifier = @"CustomerTableViewCell";

@interface BusinessViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
}
@property(nonatomic,weak)IBOutlet UITableView *m_businessTaleView;
@property(nonatomic,weak)IBOutlet UISegmentedControl *m_segmentedCtr;
@property(nonatomic,strong) MBProgressHUD *hubView;
@property(nonatomic,strong) AppContextManager *appMger;
@property(nonatomic,strong)NSMutableArray *businessList;

@end

@implementation BusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.appMger = [AppContextManager shareManager];
    
    self.m_businessTaleView.delegate = self;
    self.m_businessTaleView.dataSource = self;
    [self.m_businessTaleView registerNib:[UINib nibWithNibName:@"CustomerTableViewCell" bundle:nil] forCellReuseIdentifier:businessCellIndentifier];
    self.m_businessTaleView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    // 去掉颜色,现在整个segment偶看不到,可以相应点击事件
    self.m_segmentedCtr.layer.masksToBounds = YES;
    self.m_segmentedCtr.layer.borderWidth = 1.5;
    self.m_segmentedCtr.layer.borderColor = [UIColor colorWithHexString:@"2196d9"].CGColor;
    [self.m_segmentedCtr setDividerImage:[UIImage imageNamed:@""] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //     [self.m_segmentedCtr setTintColor:[UIColor colorWithHexString:@"2196d9"]];
    
    //设置选中状态下的文字颜色和字体
    [ self.m_segmentedCtr setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateSelected];
    
    [ self.m_segmentedCtr addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    
    self.hubView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hubView];
    self.hubView.label.text = @"加载中...";
    [self.hubView hideAnimated:YES];
    
    [self requestBusinessList:@"0"];
}

-(NSMutableArray *)businessList{
    
    if (!_businessList) {
        _businessList = [NSMutableArray arrayWithCapacity:0];
    }
    return _businessList;
}

//点击不同分段就会有不同的事件进行相应
-(void)change:(UISegmentedControl *)sender{
    
    [self.businessList removeAllObjects];
    
    if (sender.selectedSegmentIndex == 0) {
        NSLog(@"1");
         [self requestBusinessList:@"0"];
    }else if (sender.selectedSegmentIndex == 1){
        NSLog(@"2");
         [self requestBusinessList:@"1"];
    }else if (sender.selectedSegmentIndex == 2){
        NSLog(@"3");
         [self requestBusinessList:@"2"];
    }
}

#pragma mark - UItableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.businessList.count;
    
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
    return 0.01f;//把高度设置很小，效果可以看成footer的高度等于0
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomerTableViewCell *cell = (CustomerTableViewCell *)[tableView dequeueReusableCellWithIdentifier:businessCellIndentifier];
    
    if (cell == nil)
    {
        cell = [[CustomerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:businessCellIndentifier];
    }
    
    [cell setData:self.businessList[indexPath.row]];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [self performSegueWithIdentifier:@"goEvaluate" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //    typeStr = @"";
    //    if([segue.identifier isEqualToString:@"PayToCoupon"]){
    //        QQKCouponViewController *couponCtr = segue.destinationViewController;
    //        couponCtr.delegate = self;
    //    }
}

- (void)requestBusinessList:(NSString *)type
{
    
    [self.hubView showAnimated:YES];
    
    // http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.evaluate.shopevaluateapp&yes_no=&openid=
    
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.evaluate.shopevaluateapp" forKey:@"r"];
    [childDic setValue:self.appMger.userID forKey:@"openid"];
    [childDic setValue:type forKey:@"yes_no"];
    
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
                CustomerModel *listModel = [[CustomerModel alloc] init];
                [listModel parseFromDictionary:[listArray objectAtIndex:i]];
                [requestArray addObject:listModel];
            }
            
            [self.businessList addObjectsFromArray:requestArray];
            
            [self.m_businessTaleView reloadData];
            
            [self.m_segmentedCtr setTitle:[NSString stringWithFormat:@"全部(%@)",[responseDic valueForKey:@"all"]] forSegmentAtIndex:0];
            [self.m_segmentedCtr setTitle:[NSString stringWithFormat:@"满意(%@)",[responseDic valueForKey:@"yes"]] forSegmentAtIndex:1];
            [self.m_segmentedCtr setTitle:[NSString stringWithFormat:@"不满意(%@)",[responseDic valueForKey:@"no"]] forSegmentAtIndex:2];
            
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
