//
//  LoginViewController.m
//  RiderIOS
//
//  Created by Han on 2018/7/5.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController ()
{
    NSInteger _count;
    int codeTime;
    int codeNum;
}

@property (nonatomic, strong)  IBOutlet UIButton *loginBtn;
@property (nonatomic, strong)  IBOutlet UIButton *timeBtn;
@property (nonatomic, strong)  IBOutlet UITextField *nameField;
@property (nonatomic, strong)  IBOutlet UITextField *pwdField;
@property (nonatomic, strong)  IBOutlet UIImageView *occlusionView;//遮挡
@property (nonatomic, strong)  IBOutlet UIView *pwdView;//遮挡
@property (nonatomic, strong)  IBOutlet UIButton *registerBtn;
@property (nonatomic, strong)  NSUserDefaults *defaults;
@property (nonatomic, strong)  AppContextManager *appMger;
@property(nonatomic,strong) MBProgressHUD *hubView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    self.nameField.text = [self.defaults objectForKey:@"PHONENUM"];
    
//    if ([[defaults objectForKey:@"Login"]isEqualToString:@"YES"]) {
//        [self performSegueWithIdentifier:@"goHome" sender:self];
//    }
    
    self.appMger = [AppContextManager shareManager];
   
    self.hubView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hubView];
    self.hubView.label.text = @"加载中...";
    [self.hubView hideAnimated:YES];
    
    self.occlusionView.hidden = YES;
    self.pwdView.hidden = YES;
    

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage)];
    [self.occlusionView addGestureRecognizer:tapGesture];
    self.occlusionView.userInteractionEnabled = YES;
    
    NSLog(@"loginView");
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSDate *datenow = [NSDate date];
//    NSString *nowtimeStr = [formatter stringFromDate:datenow];
//    NSLog(@"nowtimeStr == ",nowtimeStr);
}

- (IBAction)showPWDLoginView
{
    self.occlusionView.hidden = NO;
    self.pwdView.hidden = NO;
}

- (IBAction)hiddenPWDLoginView
{
    self.occlusionView.hidden = YES;
    self.pwdView.hidden = YES;
}

-(void)clickImage
{
    [self hiddenPWDLoginView];
}

- (IBAction)goPWDLoginView
{
     [self hiddenPWDLoginView];
    [self performSegueWithIdentifier:@"goPWDLogin" sender:self];
}

- (IBAction)registerpress
{
//    goPWDLogin
    //    [self performSegueWithIdentifier:@"ToIndividualAndMerchant" sender:self];
}

- (IBAction)loginPress
{
    
     [self loginRequest];
}

- (IBAction)countDown
{
    if ([self.nameField.text isEqualToString:@""]||(self.nameField.text==NULL)) {
        
    }
    
    [self performSelector:@selector(countClick) withObject:nil];
}

-(void)countClick
{
    [self verificationCodeRequest];
    
    self.timeBtn.enabled =NO;
    [ self.timeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _count = 60;
    [ self.timeBtn setTitle:@"60秒重新获取" forState:UIControlStateDisabled];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}

-(void)timerFired:(NSTimer *)timer
{
    if (_count !=1) {
        _count -=1;
        [self.timeBtn setTitle:[NSString stringWithFormat:@"%ld秒重新获取",_count] forState:UIControlStateDisabled];
        
    }
    else
    {
        [timer invalidate];
        self.timeBtn.enabled = YES;
        [self.timeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        [self.timeBtn setTitleColor:[UIColor colorWithHexString:@"2196d9"] forState:UIControlStateNormal];
    }
    
   
}

- (void)verificationCodeRequest
{
    
    [self.hubView showAnimated:YES];
    
    //    http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=account.appverifycode&mobile=&temp=
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:self.nameField.text forKey:@"mobile"];
    [childDic setValue:@"sms_forget" forKey:@"temp"];
    [childDic setValue:@"account.appverifycode" forKey:@"r"];
    
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
//        LogInfo(@"responseDic = %@ ",responseDic);
        int errorCode = [[responseDic valueForKey:@"status"] intValue];
        if (errorCode == 0)
        {
            [self performSegueWithIdentifier:@"goLocationcity" sender:self];
            [self.defaults setObject:@"YES" forKey:@"Login"];
            [self.defaults setObject:self.nameField.text forKey:@"PHONENUM"];

            NSDictionary *resultDic = [responseDic valueForKey:@"result"];

            self->codeTime = [[[resultDic valueForKey:@"info"]valueForKey:@"verifycodesendtime"] intValue];
            self->codeNum = [[[resultDic valueForKey:@"info"]valueForKey:@"code"] intValue];
    
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

- (void)loginRequest
{
     [self.hubView showAnimated:YES];
    
//   http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.login.loginapp&code1=&phone=&code2=&verifycodesendtime=
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:self.nameField.text forKey:@"phone"];
    [childDic setValue:@"app.delivery.login.loginapp" forKey:@"r"];
    [childDic setValue:self.pwdField.text forKey:@"code1"];
    [childDic setValue:[NSString stringWithFormat:@"%d",codeNum] forKey:@"code2"];
    [childDic setValue:[NSString stringWithFormat:@"%d",codeTime] forKey:@"verifycodesendtime"];

    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        LogInfo(@"responseDic = %@ ",responseDic);
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
            //第一次进入App跳定位页面
            [self performSegueWithIdentifier:@"goLocationcity" sender:self];
            //第二次进入App直接跳首页
//              [self performSegueWithIdentifier:@"goHome" sender:self];
            [self.defaults setObject:@"YES" forKey:@"Login"];
            [self.defaults setObject:self.nameField.text forKey:@"PHONENUM"];
            
            NSDictionary *listDic = [responseDic valueForKey:@"list"];
           
            self.appMger.userID = [listDic valueForKey:@"openid"];
            self.appMger.userPhone = [listDic valueForKey:@"mobile"];
            self.appMger.bond_money = [listDic valueForKey:@"bond_money"];
            self.appMger.balance = [listDic valueForKey:@"balance"];
            self.appMger.addr = [listDic valueForKey:@"addr"];
            self.appMger.photo = [[listDic valueForKey:@"photo"] objectAtIndex:0];
    
            self.appMger.photo_front = [[listDic valueForKey:@"photo_front"] objectAtIndex:0];
            
            self.appMger.riderID = [listDic valueForKey:@"id"];
            self.appMger.health_type = [listDic valueForKey:@"health_type"];
            self.appMger.rider_type = [listDic valueForKey:@"audit"];
            self.appMger.closed = [listDic valueForKey:@"closed"];
        
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



- (void)viewWillAppear:(BOOL)animated {
    [  super viewWillAppear:animated];
    
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
