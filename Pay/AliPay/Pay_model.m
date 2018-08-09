//
//  Pay_model.m
//  RoseGarden
//
//  Created by 憧憬云天888 on 2017/6/26.
//  Copyright © 2017年 吕志杰. All rights reserved.
//

#import "Pay_model.h"
#import "APOrderInfo.h"
#import "APRSASigner.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation Pay_model
+(void)doAlipayPay:(NSString *)order_id order_price:(NSString *)order_price body_str:(NSString *)body_str
{
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = @"2017121300672959";
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCIxL0+DFYBUa5ew2JREb8WPMm4jzrRl9gT0qsWIOa+mwmQBBIIlbM/a7i0D3+/1TN5WIgv79EgT1vrW2yHpFie1kK9WUoATdG/fc/xmyIqDuGnHP8epczXVxQMNDM+w1VX2RSdN+yCnhcHr5y1xaT1pCVZ576oOlFSE1c975PkxhWQde+hEay9sIfGX98cwzSTEeNLjXotXR77UgQG12Bf/XxLlpXDo9oPK+EHJte+o6yXnVpSY0y6ihXdtX1N4IGgpjAWlRFYrgkL3E3cPFUXsS1AQ/TKLN50Q14p2YK9Wgu0EOHRDc4AcZ87vKeWMga3qhzkk2FtpPv5gyXwWzLFAgMBAAECggEAU+jgcgD/gy+p21nkJ/jLU8lXuXOmkpCmcQL/FER7TNWxuDnHFp1Bq9dbKp2XswoK2pgGdeKcW0ZVDsC4hT+/XzP1HlZ5oFYeKW329jRHcaZPq0eO/i6azkMOea5NAmS1J4B3tT1qTXjQiFalvp/T5SEgCVi1EGE3IzPagpVKF0DKsVHjtLCeur2ob1ULwWWQCbnr4AQdf87J2FIzc1RA1j+05WObfFuJtEfogTeikBblU+DUNe72IvpoN+1GGFVa8xTOWuYLe38ZlT0Xc61TVwrvqhHJHuYfPejWxDSMYA5AnTvI8qksNUXLsokEH9gTyW+mxdzBwZcF+bU5BY/EwQKBgQC/WnEnbZZj118/S6WRhtaVTGfvfR/eQKh/ZoKplpB7gRYnJ3FtODV5djhPvUJq5s8m7GrVkB6HEWCCSydYR5AbsgC6+/aUV8ZOAXK3laTzQiP0lw/mUk/vo6lyOe4gYogtJYRHhhoUNcqaD8iEky9GOtTQ23TsCsFwq6LZkniaPwKBgQC2+W15AYmgb49NSVYyJDqLNk0c5g/nfMYVZmHeoYh40kStOf49BVM9wkztoHsrSpPm4uGVA9pXuvx6f15hS9GMfMHEqqK56YJwcaqZ8CzH+3VXSsKnkytIb12VrAB3t9yPvOxSR8fTrTL72TR589sz/7bwNyRRidlpLEofx+BJ+wKBgQCZh9B4SSY8T2adm21puR1cxuQxtFwocAqBxdcaiLK+VVFX8v7AGjRVkzQVTo4Gxc/5tAD3/11vE9MyV2hnHWwTvJt3a4hpd4+lsOXBRPEHOM8uhTH9o5d9d/wRqUdVdpk6V/qthHxSMOKw/+7r6Egq+jMcrKhAZ1TTuPK9zRa08wKBgQCkHLHIr81eHdF9M4LhNEdiJ5Egk2S+btZHyW2MvntmSsoYSQS0fHs90HEpTSBMIvbnRqWn/y2uNGNSB72CLPvFMvykxZtwfnVlHz4yFg5ETFDhu4c9wC05KdHZdc1xk3J7Zarc3c7oF9e7tgRwQX1hdUEC0aJ8k9RxlaziNmcAUwKBgG5VQ1bnDB1hy75u6wkQwZPjcP5nSkxPhuAJdluPHElhf+9xbnMSJg9wW8NF5s+tVSl8Bc1diKqlBBhixqMkBRn2t13UlxoCiUwKnbscR7CooF0KkuhmctBfD4LtmERu3gspX9ap1zxlNq2wo8yqb9285WA1zPMJcX3gCuuTqEIu";
    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少appId或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    APOrderInfo* order = [APOrderInfo new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    order.notify_url = @"http://www.pujiante.cn/notifyalipay.php";
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1) ? @"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [APBizContent new];
    order.biz_content.body = body_str;
    order.biz_content.subject = [NSString stringWithFormat:@"订单号：%@",order_id];
    order.biz_content.out_trade_no = [NSString stringWithFormat:@"%@",order_id]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = order_price; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"InternetWorlddemo";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }

}
@end
