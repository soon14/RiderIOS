//
//  ChangeNumberViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/20.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "ChangeNumberViewController.h"
#import "LoginViewController.h"

@interface ChangeNumberViewController ()
{
    IBOutlet UIButton *submitBtn;
    IBOutlet UIButton *timeBtn;
    
   
    NSInteger _count;
//    int codeTime;
//    int codeNum;
}
@property (nonatomic, weak)IBOutlet UITextField *nameField;
@property (nonatomic, weak) IBOutlet UITextField *pwdField;
@property (nonatomic, strong) AppContextManager *appMger;
@property(nonatomic,strong) MBProgressHUD *hubView;
@property (nonatomic, strong) NSString *codeTime;
@property (nonatomic, strong) NSString *codeNum;
@end

@implementation ChangeNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.appMger = [AppContextManager shareManager];
    
    self.hubView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hubView];
    self.hubView.label.text = @"加载中...";
    [self.hubView hideAnimated:YES];
}

- (IBAction)confirmPress
{
    [self requestBindingPhone];
    
//    [self.navigationController dismissViewControllerAnimated:NO completion:^{
//
//    }];
   
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
    
    timeBtn.enabled =NO;
    _count = 60;
    [timeBtn setTitle:@"60秒" forState:UIControlStateDisabled];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}

-(void)timerFired:(NSTimer *)timer
{
    if (_count !=1) {
        _count -=1;
        [timeBtn setTitle:[NSString stringWithFormat:@"%ld秒",_count] forState:UIControlStateDisabled];
    }
    else
    {
        [timer invalidate];
        timeBtn.enabled = YES;
        [timeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

//获取手机信息验证码
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
        LogInfo(@"responseDic = %@ ",responseDic);
        int errorCode = [[responseDic valueForKey:@"status"] intValue];
        if (errorCode == 1)
        {
            
//            [self performSegueWithIdentifier:@"goLocationcity" sender:self];
//            [self.defaults setObject:@"YES" forKey:@"Login"];
//            [self.defaults setObject:self.nameField.text forKey:@"PHONENUM"];
//
            NSDictionary *resultDic = [responseDic valueForKey:@"result"];
//
            self.codeTime = [[resultDic valueForKey:@"info"]valueForKey:@"verifycodesendtime"];
            self.codeNum = [[resultDic valueForKey:@"info"]valueForKey:@"code"];
            
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

//绑定手机号
- (void)requestBindingPhone
{
    [self.hubView showAnimated:YES];
    
    //  http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.set.changephoneapp

    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:self.nameField.text forKey:@"mobile"];
    [childDic setValue:@"app.delivery.set.changephoneapp" forKey:@"r"];
    [childDic setValue:self.appMger.userID forKey:@"openid"];
    [childDic setValue:self.pwdField.text forKey:@"code1"];
    [childDic setValue:self.codeNum forKey:@"code2"];
    [childDic setValue:self.codeTime forKey:@"verifycodesendtime"];
    
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        LogInfo(@"responseDic = %@ ",responseDic);
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:@"NO" forKey:@"Login"];
            
            [ShowErrorMgs sendErrorCode:@"绑定银行卡成功" withCtr:self];
            
            UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vc = [mainStory instantiateViewControllerWithIdentifier:@"Login"];
            self.view.window.rootViewController = vc;
            
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
