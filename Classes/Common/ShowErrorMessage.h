//
//  ShowErrorMessage.h
//  RiderIOS
//
//  Created by Han on 2018/7/8.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowErrorMessage : NSObject

/**
 *    @brief    初始化单例
 */
+ (id)shareManager;

- (void)sendErrorCode:(NSString *)errorCode withCtr:(UIViewController *)viewCtr;
@end
