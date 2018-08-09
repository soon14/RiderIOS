//
//  MineViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/4.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeaderView.h"
#import "MineTableViewCell.h"
#import "ExamineHealthViewController.h"
#import "PersonalCenterViewController.h"

#define Screen_Width   ([[UIScreen mainScreen] bounds].size.width)
#define Screen_Height  ([[UIScreen mainScreen] bounds].size.height)
#define HeadImageViewHeight 300

static NSString *const mineCellIndentifier = @"MineTableViewCell";

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *listArr;
    NSMutableArray *imageArr;
   
    UIView *sectionView;
}
@property(nonatomic,strong) UITableView *m_mineTaleView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, assign) CGRect origialFrame;
@property (nonatomic, strong) AppContextManager *appMger;
@property(nonatomic,strong) MBProgressHUD *hubView;
@property(nonatomic,assign) int status;
@property(nonatomic,strong) NSString *imageUrl;
@property(nonatomic,strong)  MineHeaderView *headerView;
@property(nonatomic,assign) int isopen;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    [self.view addSubview: headerView];
    
     self.appMger = [AppContextManager shareManager];
    
    listArr = [[NSMutableArray alloc]initWithObjects:@"开/收工",@"我的成绩",@"我的钱包",@"我的评价",@"申诉中心",@"帮助中心",@"设置",nil];
    
    imageArr = [[NSMutableArray alloc]initWithObjects:@"kg",@"cj",@"qb",@"pj",@"ss",@"bg",@"sz",nil];
    
    self.headerView = [MineHeaderView defaultView];
    
    
    [self.view addSubview:[self imageview]];
    
    [self.view addSubview:[self tableView]];

    self.m_mineTaleView.tableHeaderView = self.headerView;
    
   [self.headerView setTXImage:self.appMger.photo];
    
//    [self addHeadView];
    
    __weak typeof(self) weakSekf = self;
    self.headerView.didHeaderButton = ^(int index) {
        if (index == 0) {
            [weakSekf performSegueWithIdentifier:@"goTrainView" sender:nil];
        }
        else if (index == 1) {
//            [weakSekf performSegueWithIdentifier:@"goTrainView" sender:nil];
        }
    
        else if (index == 3) {
            //             [weakSekf performSegueWithIdentifier:@"goCityList" sender:nil];
            [weakSekf performSegueWithIdentifier:@"goPersonalCenter" sender:nil];
        }
        else {

            [weakSekf requestHealthStatus];
//            [weakSekf performSegueWithIdentifier:@"goHealthCertificate" sender:nil];
        }
        
    };
    
    self.hubView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hubView];
    self.hubView.label.text = @"加载中...";
    [self.hubView hideAnimated:YES];
    
    self.isopen = [self.appMger.closed intValue];
}

- (UITableView *)tableView{
    if (! self.m_mineTaleView) {
         self.m_mineTaleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
         self.m_mineTaleView.delegate = self;
         self.m_mineTaleView.dataSource = self;
         self.m_mineTaleView.backgroundColor=[UIColor clearColor];
        [self.m_mineTaleView registerNib:[UINib nibWithNibName:@"MineTableViewCell" bundle:nil] forCellReuseIdentifier:mineCellIndentifier];
        self.m_mineTaleView.separatorStyle = UITableViewCellSelectionStyleNone;
        self.m_mineTaleView.showsVerticalScrollIndicator = NO;
//         self.m_mineTaleView.rowHeight = 50;
    }
    return  self.m_mineTaleView;
}


-(UIImageView*)imageview{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, HeadImageViewHeight)];
        _headImageView.image = [UIImage imageNamed:@"wdbjt"];
//        _headImageView.alpha = 0.4;
        self.origialFrame = _headImageView.frame;
    }
    return _headImageView;
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

    return 0.0f;
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
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineTableViewCell *cell = (MineTableViewCell *)[tableView dequeueReusableCellWithIdentifier:mineCellIndentifier];
    
    if (cell == nil)
    {
        cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:mineCellIndentifier];
    }

    [cell setData:[listArr objectAtIndex:indexPath.row] image:[imageArr objectAtIndex:indexPath.row] index:indexPath.row withIsOpen:self.isopen];
     __weak typeof(self) weakSelf = self;
    cell.didSwichView = ^(int i) {
        
        [weakSelf requestRiderOpen:[NSString stringWithFormat:@"%d",i]];
    };
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        
         [self performSegueWithIdentifier:@"goAchievements" sender:nil];
    }
    else if (indexPath.row == 2) {
        [self performSegueWithIdentifier:@"goWallet" sender:nil];
    }
    else if (indexPath.row == 3) {
        [self performSegueWithIdentifier:@"goEvaluate" sender:nil];
    }
    else if (indexPath.row == 4) {
        [self performSegueWithIdentifier:@"goAppealList" sender:nil];
    }
    else if (indexPath.row == 5) {
        [self performSegueWithIdentifier:@"goHelp" sender:nil];
    }
    else if (indexPath.row == 6) {
         [self performSegueWithIdentifier:@"goSetting" sender:nil];
    }
    else
    {
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if([segue.identifier isEqualToString:@"mineToExamine"]){
        ExamineHealthViewController *examineCtr = segue.destinationViewController;
        examineCtr.status = self.status;
        examineCtr.imgUrl = self.imageUrl;
    }
    else if([segue.identifier isEqualToString:@"goPersonalCenter"]){
        
        PersonalCenterViewController *personCtr = segue.destinationViewController;
         __weak typeof(self) weakSelf = self;
        personCtr.URLBlock = ^(NSString *url) {
           [weakSelf.headerView setTXImage:url];
            [weakSelf.m_mineTaleView reloadData];
        };
        
    }
    else
    {
        
    }
}

- (void)requestHealthStatus
{
    [self.hubView showAnimated:YES];
    
    //   http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.health.indexapp&openid=
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.health.indexapp" forKey:@"r"];
    [childDic setValue:self.appMger.userID forKey:@"openid"];
    
    
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
//        LogInfo(@"responseDic = %@ ",responseDic);
        
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
            //type : 0 添加健康证 1 审核中 2 已通过 3 未通过
            self.status = [[responseDic valueForKey:@"type"] intValue];
            self.imageUrl = [[responseDic valueForKey:@"photo"] objectAtIndex:0];
            
            if ([[responseDic valueForKey:@"type"] intValue] == 0 || [[responseDic valueForKey:@"type"] intValue] == 3) {
               
                [self performSegueWithIdentifier:@"goHealthCertificate" sender:nil];
                if ([[responseDic valueForKey:@"type"] intValue] == 3) {
//                    [ShowErrorMgs sendErrorCode:@"健康证审核未通过，请重新上传" withCtr:self];
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"健康证审核未通过，请重新上传" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        [self requestClearHealthData];
                        
                    }];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }];
                    [alert addAction:cancel];
                    [alert addAction:ok];
                    [self presentViewController:alert animated:YES completion:nil];
                    
                }
            }
            else
            {
                [self performSegueWithIdentifier:@"mineToExamine" sender:nil];
            }
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

//重新上传，清空后台数据
- (void)requestClearHealthData
{
    
    [self.hubView showAnimated:YES];
    
    // http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.health.submitedapp&sid=
    
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.health.submitedapp" forKey:@"r"];
    [childDic setValue:self.appMger.riderID forKey:@"sid"];
    
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
//        LogInfo(@"responseDic = %@ ",responseDic);
        
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
           
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

//开工收工
- (void)requestRiderOpen:(NSString *)open
{
    [self.hubView showAnimated:YES];
    //   http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.index.changeapp&sid=&open=
    
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.index.changeapp" forKey:@"r"];
    [childDic setValue:self.appMger.riderID forKey:@"sid"];
    [childDic setValue:open forKey:@"open"];//0关 1开
    
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        LogInfo(@"responseDic = %@ ",responseDic);
        
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
            self.isopen = [[[responseDic valueForKey:@"show"] valueForKey:@"closed"] intValue];
            self.appMger.closed = [[responseDic valueForKey:@"show"] valueForKey:@"closed"];
            [self.m_mineTaleView reloadData];
            
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //往上滑动offset增加，往下滑动，yoffset减小
    CGFloat yoffset = scrollView.contentOffset.y;
    //处理背景图的放大效果和往上移动的效果
    if (yoffset>0) {//往上滑动
        
        _headImageView.frame = ({
            CGRect frame = self.origialFrame;
            frame.origin.y = self.origialFrame.origin.y - yoffset;
            frame;
        });
        
    }else {//往下滑动，放大处理
        _headImageView.frame = ({
            CGRect frame = self.origialFrame;
            frame.size.height = self.origialFrame.size.height - yoffset;
            frame.size.width = frame.size.height*1.5;
            frame.origin.x = _origialFrame.origin.x - (frame.size.width-_origialFrame.size.width)/2;
            frame;
        });
    }
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
