//
//  AFHttpRequestManagement.m
//  RiderIOS
//
//  Created by Han on 2018/7/6.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "AFHttpRequestManagement.h"
#import "ServiceManagement.h"

@implementation AFHttpRequestManagement

/** Post 请求 */
+(void)PostHttpDataWithUrlStr:(NSString *)url Dic:(NSDictionary *)dic SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailedBlock)failureBlock
{
    ServiceManagement *service = [ServiceManagement shareManagement];
        NSString *urlString = [service getHostUrl:@"ServiceURL"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];
    
    [manager POST:urlString parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        

        /** 这里是处理事件的回调 */
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        /** 这里是处理事件的回调 */
        if (failureBlock) {
            failureBlock(error);
        }
    }
     ];
    
    
}


/** Get 请求 */
+(void)GetHttpDataWithUrlStr:(NSString *)url Dic:(NSDictionary *)dic SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailedBlock)failureBlock{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"text/html",@"text/plain",nil];
    
    [manager GET:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        /** 这里是处理事件的回调 */
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        /** 这里是处理事件的回调 */
        if (failureBlock) {
            failureBlock(error);
        }
    }
     
     ];
    
}


@end
