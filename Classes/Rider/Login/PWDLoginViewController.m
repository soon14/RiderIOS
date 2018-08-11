//
//  PWDLoginViewController.m
//  RiderIOS
//
//  Created by Han on 2018/8/1.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "PWDLoginViewController.h"

@interface PWDLoginViewController ()

@property (nonatomic, strong)  IBOutlet UITextField *nameField;
@property (nonatomic, strong)  IBOutlet UITextField *pwdField;
@property (nonatomic, strong)  AppContextManager *appMger;
@property(nonatomic,strong) MBProgressHUD *hubView;
@property (nonatomic, strong)  NSUserDefaults *defaults;
@end

@implementation PWDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.appMger = [AppContextManager shareManager];
    
    self.hubView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hubView];
    self.hubView.label.text = @"加载中...";
    [self.hubView hideAnimated:YES];
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    self.nameField.text = [self.defaults objectForKey:@"PHONENUM"];
    self.pwdField.secureTextEntry = YES;
//    [self loginPWDRequest];
}

- (IBAction)goHome
{
    [self loginPWDRequest];
}

- (void)loginPWDRequest
{
    [self.hubView showAnimated:YES];
    //17766008291
    //123456qwe
    //  http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.login.pwdapp&mobile=&pwd=
    
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:self.nameField.text forKey:@"mobile"];
    [childDic setValue:@"app.delivery.login.pwdapp" forKey:@"r"];
    [childDic setValue:self.pwdField.text forKey:@"pwd"];
    
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        LogInfo(@"responseDic = %@ ",responseDic);
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
            if ( [[self.defaults objectForKey:@"Location"] isEqualToString:@"YES"]) {
                //第二次进入App直接跳首页
                 [self performSegueWithIdentifier:@"goTabBar" sender:self];
            }
            else
            {
                //第一次进入App跳定位页面
               [self performSegueWithIdentifier:@"goLcationCity" sender:self];
            }
//
            [self.defaults setObject:@"YES" forKey:@"Login"];
            [self.defaults setObject:self.nameField.text forKey:@"PHONENUM"];
            
            NSDictionary *listDic = [responseDic valueForKey:@"list"];
            
            self.appMger.userID = [listDic valueForKey:@"openid"];
            self.appMger.userPhone = [listDic valueForKey:@"mobile"];
            self.appMger.bond_money = [listDic valueForKey:@"bond_money"];
            self.appMger.balance = [listDic valueForKey:@"balance"];
            self.appMger.userName = [listDic valueForKey:@"name"];
            self.appMger.photo = [[listDic valueForKey:@"photo"] objectAtIndex:0];
            self.appMger.photo_front = [[listDic valueForKey:@"photo_front"] objectAtIndex:0];
            self.appMger.riderID = [listDic valueForKey:@"id"];
            self.appMger.health_type = [listDic valueForKey:@"health_type"];
            self.appMger.rider_type = [listDic valueForKey:@"audit"];
            self.appMger.balance = [listDic valueForKey:@"balance"];
            self.appMger.addr = [listDic valueForKey:@"addr"];
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
