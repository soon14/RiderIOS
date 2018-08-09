//
//  MyAchievementsViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/10.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "MyAchievementsViewController.h"
#import "MyAchievementsTableViewCell.h"
#import "AchievementMode.h"

static NSString *const cellIndentifier = @"MyAchievementsTableViewCell";

@interface MyAchievementsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *listArr;
    NSMutableArray *imageArr;
}
@property(nonatomic,weak)IBOutlet UITableView *m_tableView;
@property(nonatomic,strong) MBProgressHUD *hubView;
@property(nonatomic,strong) AppContextManager *appMger;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation MyAchievementsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    listArr = [[NSMutableArray alloc]initWithObjects:@"今日成绩",@"本月成绩",nil];
    imageArr = [[NSMutableArray alloc]initWithObjects:@"yl",@"ty",nil];
    self.dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    
//    self.m_tableView.scrollEnabled = NO;
    [self.m_tableView registerNib:[UINib nibWithNibName:@"MyAchievementsTableViewCell" bundle:nil] forCellReuseIdentifier:cellIndentifier];
    self.m_tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.hubView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hubView];
    self.hubView.label.text = @"加载中...";
    [self.hubView hideAnimated:YES];
    
    self.appMger = [AppContextManager shareManager];
    
    [self requestAchievemntts];
}



#pragma mark - UItableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [listArr count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_width, 10)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    return headerView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    //    return 12;//这个方法不写，或者return 0跟return 12的效果一样
    return 0.1f;//把高度设置很小，效果可以看成footer的高度等于0
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 240;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyAchievementsTableViewCell *cell = (MyAchievementsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (cell == nil)
    {
        cell = [[MyAchievementsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:cellIndentifier];
    }
    
    if (self.dataArr.count > indexPath.row) {
        [cell setData:listArr[indexPath.row] image:imageArr[indexPath.row] withData:self.dataArr[indexPath.row]];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
//        [self performSegueWithIdentifier:@"goAchievements" sender:nil];
    }
    else
    {
        
    }
}

- (IBAction)goRank:(id)sender
{
    [self performSegueWithIdentifier:@"goRank" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //    typeStr = @"";
    //    if([segue.identifier isEqualToString:@"PayToCoupon"]){
    //        QQKCouponViewController *couponCtr = segue.destinationViewController;
    //        couponCtr.delegate = self;
    //    }
}

- (void)requestAchievemntts
{
    
    [self.hubView showAnimated:YES];
    
    // http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.achievement&openid=
    
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.achievement" forKey:@"r"];
    [childDic setValue:self.appMger.userID forKey:@"openid"];
    
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        LogInfo(@"responseDic = %@ ",responseDic);
        
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
            NSMutableArray *requestArray = [[NSMutableArray alloc] initWithCapacity:0];
            NSDictionary *todayDic = [responseDic valueForKey:@"today"];
            AchievementMode *todayModel = [[AchievementMode alloc] init];
            [todayModel parseFromDictionary:todayDic];
            [requestArray addObject:todayModel];
            
            NSDictionary *mouthDic = [responseDic valueForKey:@"mouth"];
            AchievementMode *mouthModel = [[AchievementMode alloc] init];
            [mouthModel parseFromDictionary:mouthDic];
            [requestArray addObject:mouthModel];
            
            [self.dataArr addObjectsFromArray:requestArray];
            [self.m_tableView reloadData];
            
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
