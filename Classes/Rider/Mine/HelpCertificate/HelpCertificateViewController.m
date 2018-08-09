//
//  HelpCertificateViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/12.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "HelpCertificateViewController.h"
#import "HelpTableViewCell.h"
#import "TitleHeaderView.h"
#import "HelpModel.h"
#import "HelpWebViewController.h"

static NSString *const helpCellIndentifier = @"HelpTableViewCell";

@interface HelpCertificateViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *listArr;
    NSString *title;
    NSString *cateID;
}
@property(nonatomic,strong)NSMutableArray *proplemList;
@property(nonatomic,weak)IBOutlet UITableView *m_HelpTaleView;
@property(nonatomic,strong) MBProgressHUD *hubView;
@end

@implementation HelpCertificateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    listArr = [[NSMutableArray alloc]initWithObjects:@"配送相关问题",@"订单申诉相关问题",@"异常问题处理",nil];
    
    
    [self.m_HelpTaleView registerNib:[UINib nibWithNibName:@"HelpTableViewCell" bundle:nil] forCellReuseIdentifier:helpCellIndentifier];
    
//    self.m_HelpTaleView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.hubView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hubView];
    self.hubView.label.text = @"加载中...";
    [self.hubView hideAnimated:YES];
    
    [self requestProplemList];
}

-(NSMutableArray *)proplemList{
    
    if (!_proplemList) {
        _proplemList = [NSMutableArray arrayWithCapacity:0];
    }
    return _proplemList;
}

#pragma mark - UItableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.proplemList count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TitleHeaderView *headerView = [TitleHeaderView defaultView];
//    if (section == 0) {
        headerView.titleLbl.text = @"常见问题";
//    }
//    else
//    {
//        headerView.titleLbl.text = @"更多问题";
//    }
    return headerView;
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
    HelpTableViewCell *cell = (HelpTableViewCell *)[tableView dequeueReusableCellWithIdentifier:helpCellIndentifier];
    
    if (cell == nil)
    {
        cell = [[HelpTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:helpCellIndentifier];
    }
    
    [cell setData:self.proplemList[indexPath.row]];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    HelpModel *mode = self.proplemList[indexPath.row];
    title = mode.catename;
    cateID = mode.cate_id;
    [self performSegueWithIdentifier:@"goHelpWeb" sender:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //    typeStr = @"";
        if([segue.identifier isEqualToString:@"goHelpWeb"]){
            HelpWebViewController *webCtr = segue.destinationViewController;
            webCtr.titleStr = title;
            webCtr.cateID = cateID;
        }
}

- (void)requestProplemList
{
    [self.hubView showAnimated:YES];
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.service.indexapp" forKey:@"r"];
    
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        LogInfo(@"responseDic = %@ ",responseDic);
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
            NSArray *listArray = [responseDic valueForKey:@"cate"];
            NSMutableArray *requestArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i = 0; i<[listArray count]; i++)
            {
                HelpModel *listModel = [[HelpModel alloc] init];
                [listModel parseFromDictionary:[listArray objectAtIndex:i]];
                [requestArray addObject:listModel];
            }
            
            [self.proplemList addObjectsFromArray:requestArray];
            
            [self.m_HelpTaleView reloadData];
        }
        else
        {
            NSString *errorMessage = [responseDic valueForKey:@"message"];
            [ShowErrorMgs sendErrorCode:errorMessage withCtr:self];
        }
         [self.hubView hideAnimated:YES];
    } FailureBlock:^(id error) {
        NSLog(@"error == %@",error);
        [ShowErrorMgs sendErrorCode:@"服务器错误，请稍后重试！" withCtr:self];
         [self.hubView hideAnimated:YES];
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
