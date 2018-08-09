//
//  PutForwardViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/29.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "PutForwardViewController.h"
#import "PutForwardTableViewCell.h"

static NSString *const cellIndentifier = @"PutForwardTableViewCell";

@interface PutForwardViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
     NSMutableArray *titleArr;
}
@property(nonatomic,weak)IBOutlet UITableView *forwardListView;
@property(nonatomic,weak)IBOutlet UIButton *confirmBtn;
@property (nonatomic, strong) AppContextManager *appMger;
@property(nonatomic,strong) MBProgressHUD *hubView;
@property(nonatomic,weak)IBOutlet UIView *bankView;
@property(nonatomic,weak)IBOutlet UIPickerView *m_bankPicker;
@end

@implementation PutForwardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.appMger = [AppContextManager shareManager];
    
    titleArr = [[NSMutableArray alloc]initWithObjects:@"选择银行卡",@"提现金额",@"本次可提现金额：",nil];
    
    self.forwardListView.scrollEnabled = NO;
    [self.forwardListView registerNib:[UINib nibWithNibName:@"PutForwardTableViewCell" bundle:nil] forCellReuseIdentifier:cellIndentifier];
     self.forwardListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.hubView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hubView];
    self.hubView.label.text = @"加载中...";
    [self.hubView hideAnimated:YES];
    
     self.bankView.hidden = YES;
    
    [self requestBankList];
}

- (IBAction)cancel:(id)sender
{
    self.bankView.hidden = YES;
}

- (IBAction)confirm:(id)sender
{
    self.bankView.hidden = YES;
    
    [self.forwardListView reloadData];
}


- (IBAction)confirmPress:(id)sender
{
    [self performSegueWithIdentifier:@"goPutForwardDetail" sender:nil];
}

#pragma mark UIPickerViewDataSource 数据源方法
// 返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}

// 返回多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return 5;
    
}

#pragma mark UIPickerViewDelegate 代理方法

//// 返回每行的标题
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return [NSString stringWithFormat:@"第%d行",row];
}

// 选中行显示在label上
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //    NSArray *items = self.bankData[component];
    //    if (component == 0) {
    //        self.fruitLabel.text = items[row];
    //    }else if (component == 1){
    //        self.mainFoodLabel.text = items[row];
    //    }else{
    //        self.drinkLabel.text = items[row];
    //    }
    
    //    bankName = self.bankArr[row];
}


#pragma mark - UItableView delegate
//设置表头
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     return 0.01f;
    
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
    
    return nil;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [titleArr count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PutForwardTableViewCell *cell = (PutForwardTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (cell == nil)
    {
        cell = [[PutForwardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:cellIndentifier];
    }

    [cell setData:titleArr[indexPath.row] withIndex:indexPath.row];
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
        
        self.bankView.hidden = NO;
        [self.view endEditing:YES];
//        [self performSegueWithIdentifier:@"goCash" sender:nil];
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //    if([segue.identifier isEqualToString:@"goOrderDetail"]){
    //        OrderDetailViewController *detailCtr = segue.destinationViewController;
    //        detailCtr.orderStatus = statusStr;
    //    }
    
}

- (void)requestBankList
{
    [self.hubView showAnimated:YES];
    
    //  http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.wallet.banklist&openid=

    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.wallet.banklist" forKey:@"r"];
    [childDic setValue:self.appMger.userID forKey:@"openid"];
    
    
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        LogInfo(@"responseDic = %@ ",responseDic);
        
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
            
        
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
