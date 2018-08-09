//
//  AFHttpRequestManagement.h
//  RiderIOS
//
//  Created by Han on 2018/7/6.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessBlock) (id responseObject);
typedef void (^FailedBlock) (id error);

@interface AFHttpRequestManagement : NSObject
/** Post 请求 */
+(void)PostHttpDataWithUrlStr:(NSString *)url Dic:(NSDictionary *)dic SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailedBlock)failureBlock;

/** Get 请求 */
+(void)GetHttpDataWithUrlStr:(NSString *)url Dic:(NSDictionary *)dic SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailedBlock)failureBlock;

@end
