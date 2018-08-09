//
//  AddBankCardViewController.m
//  RiderIOS
//
//  Created by Han on 2018/7/3.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "AddBankCardViewController.h"
#import "AddBankCardTableViewCell.h"
#import "BankModel.h"

static NSString *const cellIndentifier = @"AddBankCardTableViewCell";

@interface AddBankCardViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray *titleArr;
}

@property(nonatomic , strong)NSMutableArray *bankArr;
@property(nonatomic,weak)IBOutlet UITableView *m_addTaleView;
@property(nonatomic,weak)IBOutlet UIView *bankView;
@property(nonatomic,weak)IBOutlet UIPickerView *m_bankPicker;
@property(nonatomic,strong) AppContextManager *appMger;
@property(nonatomic,strong) MBProgressHUD *hubView;
@property(nonatomic,strong) NSString *khhStr;
@property(nonatomic,strong) NSString *cardNumStr;
@property(nonatomic,strong) NSString *bankName;

@end

@implementation AddBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.bankName = @"请选择您的开户银行";
    
    titleArr = [[NSMutableArray alloc]initWithObjects:@"持卡人",@"选择银行",@"开户行",@"卡号",nil];
    
    [self.m_addTaleView registerNib:[UINib nibWithNibName:@"AddBankCardTableViewCell" bundle:nil] forCellReuseIdentifier:cellIndentifier];
    self.m_addTaleView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.m_addTaleView.scrollEnabled = NO;
    
    self.bankView.hidden = YES;
    
    self.appMger = [AppContextManager shareManager];
    
    self.hubView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hubView];
    self.hubView.label.text = @"加载中...";
    
    [self.hubView hideAnimated:YES];
    
    [self requestBankList];
}

// 数据数组的懒加载
-(NSMutableArray *)bankArr
{
    if (_bankArr == nil) {
        _bankArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _bankArr;
}

- (IBAction)cancel:(id)sender
{
    self.bankView.hidden = YES;
}

- (IBAction)confirm:(id)sender
{
    self.bankView.hidden = YES;
    
    [self.m_addTaleView reloadData];
}

- (IBAction)submit:(id)sender
{
    self.bankView.hidden = YES;
    [self.view endEditing:YES];
    
    [self requestYanzhengCard];
//
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
    
    return self.bankArr.count;
    
}

#pragma mark UIPickerViewDelegate 代理方法

//// 返回每行的标题
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    BankModel *mode = self.bankArr[row];
    return mode.name;
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
    
    BankModel *mode = self.bankArr[row];
    self.bankName = mode.name;

//    bankName = self.bankArr[row];
}



#pragma mark - UItableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [titleArr count];
    
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
    return 0.1f;//把高度设置很小，效果可以看成footer的高度等于0
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddBankCardTableViewCell *cell = (AddBankCardTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (cell == nil)
    {
        cell = [[AddBankCardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:cellIndentifier];
    }
     __weak typeof(self) weakSelf = self;
    
    cell.beginEditingBlock = ^{
         weakSelf.bankView.hidden = YES;
    };
    
    cell.returnBlock = ^(NSString *number) {
        NSLog(@"return == %@",number);
    };
    
    cell.endEditingBlock = ^(NSString *number,NSInteger tag) {
        if (tag == 2) {
            weakSelf.khhStr = number;
        }
        else if (tag == 3)
        {
             weakSelf.cardNumStr = number;
        }
    };
    
    [cell setData:titleArr[indexPath.row] bankName:self.bankName withIndexRow:indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 1) {
        self.bankView.hidden = NO;
        [self.view endEditing:YES];
        
        BankModel *mode = self.bankArr[0];
        self.bankName = mode.name;
    }
    
    //        [self performSegueWithIdentifier:@"goChangeNumber" sender:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //    typeStr = @"";
    //    if([segue.identifier isEqualToString:@"PayToCoupon"]){
    //        QQKCouponViewController *couponCtr = segue.destinationViewController;
    //        couponCtr.delegate = self;
    //    }
}

//银行列表
- (void)requestBankList
{
    
    [self.hubView showAnimated:YES];
    
    //    http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.set.banklistapp
    
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.set.banklistapp" forKey:@"r"];
//    [childDic setValue:self.appMger.userID forKey:@"openid"];
    
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        LogInfo(@"responseDic = %@ ",responseDic);
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
            NSArray *listArray = [responseDic valueForKey:@"banklist"];
            NSMutableArray *requestArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i = 0; i<[listArray count]; i++)
            {

                BankModel *listModel = [[BankModel alloc] init];
                [listModel parseFromDictionary:[listArray objectAtIndex:i]];
                [requestArray addObject:listModel];
            }

            [self.bankArr addObjectsFromArray:requestArray];

            [self.m_bankPicker reloadAllComponents];
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

//验证银行卡卡号
- (void)requestYanzhengCard
{
    
    [self.hubView showAnimated:YES];
    
    //   http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.set.bankcardinfoapp&cardid=
    
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.set.bankcardinfoapp" forKey:@"r"];
    [childDic setValue:self.cardNumStr forKey:@"cardid"];
    
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        LogInfo(@"responseDic = %@ ",responseDic);
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
            [self requestAddRiderCard];
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

//添加骑手银行卡
- (void)requestAddRiderCard
{
    
    [self.hubView showAnimated:YES];
    
    //  http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.set.setbankcardapp
    
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.set.setbankcardapp" forKey:@"r"];
    [childDic setValue:self.appMger.userName forKey:@"name"];
     [childDic setValue:self.appMger.userID forKey:@"openid"];
    [childDic setValue:self.cardNumStr forKey:@"cardid"];
    [childDic setValue:self.bankName forKey:@"bankname"];
    [childDic setValue:self.khhStr forKey:@"openingbank"];
    
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        LogInfo(@"responseDic = %@ ",responseDic);
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
            if(self.refreshBlock)
            {
                self.refreshBlock();
            }
            
            [self.navigationController popViewControllerAnimated:YES];
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
