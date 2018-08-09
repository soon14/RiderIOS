//
//  AppealListViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/12.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "AppealListViewController.h"
#import "AppealListTableViewCell.h"
#import "AppealModel.h"
#import "AppealDetailViewController.h"

static NSString *const appealCellIndentifier = @"AppealListTableViewCell";

@interface AppealListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *orderID;
}
@property(nonatomic,weak)IBOutlet UITableView *m_listTaleView;
@property(nonatomic,strong) AppContextManager *appMger;
@property(nonatomic,strong) NSMutableArray *appealList;
@property(nonatomic,strong) MBProgressHUD *hubView;

@end

@implementation AppealListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.m_listTaleView registerNib:[UINib nibWithNibName:@"AppealListTableViewCell" bundle:nil] forCellReuseIdentifier:appealCellIndentifier];
    
    self.m_listTaleView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.appMger = [AppContextManager shareManager];
    
    self.hubView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hubView];
    self.hubView.label.text = @"加载中...";
    
    [self.hubView hideAnimated:YES];
    
//    self.hubView.hidden = YES;
//    self.hubView.dimBackground = YES;
    
    [self requestAppealList];
}

-(NSMutableArray *)appealList{
    
    if (!_appealList) {
        _appealList = [NSMutableArray arrayWithCapacity:0];
    }
    return _appealList;
}

#pragma mark - UItableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.appealList count];
    
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
    
    return 91;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppealListTableViewCell *cell = (AppealListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:appealCellIndentifier];
    
    if (cell == nil)
    {
        cell = [[AppealListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:appealCellIndentifier];
    }
    
    [cell setData:self.appealList[indexPath.row]];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppealModel *model = self.appealList[indexPath.row];
    orderID = model.order_id;
    [self performSegueWithIdentifier:@"goAppealDetail" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //    typeStr = @"";
        if([segue.identifier isEqualToString:@"goAppealDetail"]){
            AppealDetailViewController *detailCtr = segue.destinationViewController;
            detailCtr.orderID = orderID;
        }
}

- (void)requestAppealList
{
    
    [self.hubView showAnimated:YES];
    
//    http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.appeal.indexapp&openid=
    
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.appeal.indexapp" forKey:@"r"];
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
                
                AppealModel *listModel = [[AppealModel alloc] init];
                [listModel parseFromDictionary:[listArray objectAtIndex:i]];
                [requestArray addObject:listModel];
            }

            [self.appealList addObjectsFromArray:requestArray];

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
