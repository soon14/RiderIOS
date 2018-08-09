//
//  AppDelegate.h
//  RiderIOS
//
//  Created by Han on 2018/6/4.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>

static NSString *appKey = @"ca74668a3cf7327b88dc3dbb";
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

