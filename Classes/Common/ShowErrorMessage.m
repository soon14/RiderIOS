//
//  ShowErrorMessage.m
//  RiderIOS
//
//  Created by Han on 2018/7/8.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "ShowErrorMessage.h"

@implementation ShowErrorMessage

static ShowErrorMessage *m_manger;

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

+ (id)shareManager
{
    
    static dispatch_once_t onceTocken;
    dispatch_once(&onceTocken, ^{
        if (!m_manger)
        {
            m_manger = [[ShowErrorMessage alloc] init];
        }
       
    });
    return m_manger;
}

- (void)sendErrorCode:(NSString *)errorCode withCtr:(UIViewController *)viewCtr
{
//    NSString *errorStr = @"";
//    if ([errorCode isEqualToString:@"0"]) {
//        errorStr = @"请求成功";
//    }
//    else if ([errorCode isEqualToString:@"服务器错误，请稍后重试！"])
//    {
//        errorStr = @"服务器错误，请稍后重试！";
//
//    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:errorCode preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
     
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel];
    [alert addAction:ok];
    [viewCtr presentViewController:alert animated:YES completion:nil];
}

@end
