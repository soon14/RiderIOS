//
//  ServiceManagement.h
//  RiderIOS
//
//  Created by Han on 2018/7/4.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceManagement : NSObject

/*!单利模式获取Setting管理类对象
 *\param    无
 *\returns  返回Setting管理对象
 */
+ (ServiceManagement *)shareManagement;

/*!获取服务器地址
 *\param    key: 键
 *\returns  返回服务器地址
 */
- (NSString *)getHostUrl:(NSString *)key;

@end
