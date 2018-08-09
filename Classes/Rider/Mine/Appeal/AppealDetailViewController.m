//
//  AppealDetailViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/12.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "AppealDetailViewController.h"

@interface AppealDetailViewController ()

@property(nonatomic,weak)IBOutlet UILabel *replyLbl;
@property(nonatomic,weak)IBOutlet UILabel *reasonLbl;
@property(nonatomic,strong) MBProgressHUD *hubView;
@end

@implementation AppealDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.hubView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hubView];
    self.hubView.label.text = @"加载中...";
    [self.hubView hideAnimated:YES];
    
    [self requestAppealDetail];
}

- (void)requestAppealDetail
{
    [self.hubView showAnimated:YES];
    
    //    http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.appeal.detailapp&id=
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.appeal.detailapp" forKey:@"r"];
    [childDic setValue:self.orderID forKey:@"id"];
   
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject)
    {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        LogInfo(@"responseDic = %@ ",responseDic);
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
            
            NSDictionary *detailDic = [responseDic valueForKey:@"detail"];
            self.reasonLbl.text = [NSString stringWithFormat:@"%@：%@",[detailDic valueForKey:@"reason"],[detailDic valueForKey:@"text"]];
            
             self.replyLbl.text = [detailDic valueForKey:@"reply"];
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
