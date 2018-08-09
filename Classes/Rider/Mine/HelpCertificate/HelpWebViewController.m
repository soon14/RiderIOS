//
//  HelpWebViewController.m
//  RiderIOS
//
//  Created by Han on 2018/7/24.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "HelpWebViewController.h"

@interface HelpWebViewController ()

@property(nonatomic,weak)IBOutlet UIWebView *helpWebView;

@property(nonatomic,strong) MBProgressHUD *hubView;
@end

@implementation HelpWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.titleStr;
    
    self.hubView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hubView];
    self.hubView.label.text = @"加载中...";
    [self.hubView hideAnimated:YES];
    
    [self requestHelpWebList];
}

//即将加载某个请求的时候调用
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@",request.URL.absoluteString);
//    //简单的请求拦截处理
//    NSString *strM = request.URL.absoluteString;
//    if ([strM containsString:@"360"]) {
//        return NO;
//    }
    return YES;
}

//1.开始加载网页的时候调用
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
}

//2.加载完成的时候调用
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
    [self.hubView hideAnimated:YES];
}

//3.加载失败的时候调用
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError");
    [self.hubView hideAnimated:YES];
}

- (void)requestHelpWebList
{
    [self.hubView showAnimated:YES];
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.service.serdetail" forKey:@"r"];
    [childDic setValue:self.cateID forKey:@"cid"];
    
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        LogInfo(@"responseDic = %@ ",responseDic);
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
            NSString *urlStr = [responseDic valueForKey:@"url"];
            NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",urlStr,self.cateID]];
            NSURLRequest * request = [NSURLRequest requestWithURL:url];
            [self.helpWebView loadRequest:request];
        
        }
        else
        {
            NSString *errorMessage = [responseDic valueForKey:@"message"];
            [ShowErrorMgs sendErrorCode:errorMessage withCtr:self];
            [self.hubView hideAnimated:YES];
        }
        
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
