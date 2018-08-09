//
//  CommonDeal.h
//  TestDZAPI
//
//  Created by wangjun on 13-10-31.
//  Copyright (c) 2013年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "UserModel.h"
//#import "ErrorModel.h"
//#import "CityModel.h"


#define SCREEN_HEIGHT    ([UIScreen mainScreen].bounds.size.height-20)
#define MAIN_BOUNDS       CGRectMake(0.0f, 0.0f, 320.0f, SCREEN_HEIGHT)
#define MAIN_NAV_BOUNDS   CGRectMake(0.0f, 0.0f, 320.0f, SCREEN_HEIGHT-49+20)
#define MAIN_TAB_BOUNDS   CGRectMake(0.0f, 0.0f, 320.0f, SCREEN_HEIGHT-44-48)

#define kAFNetworkingManager        [AFNetworkingManagement shareManagement]
//#define kChinaYZManagement          [ChinaYZManagement shareManagement]
#define kSettingManager             [SettingManagement shareManagement]

#define kRecordCountPerPage 10
//iOS 屏幕适配，定制宏
#pragma mark - iPhone5屏幕适配
#ifndef iPhone5
#   define iPhone5 ([[UIScreen mainScreen] bounds].size.height == 568)
#endif

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define IsIOS7 (IOS_VERSION >= 7)
#define NEW_SCREEN_HEIGHT (IsIOS7?(SCREEN_HEIGHT-29):SCREEN_HEIGHT)

//沙盒文件的操作
#define Document [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define kRecoder [Document stringByAppendingPathComponent:@"Recoder"]
#define kRecoderFile [kRecoder stringByAppendingPathComponent:@"recoder.plist"]

//大众点评key
#define kAPIKEY         @"34195104"
#define KAPISECRET      @"750bf0e21d0146faaa1e1d74dc8479fa"

#define Document [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//自定义日志开关
#define isPrintLog  1   // 仅当  isPrintLog 值是1的时候才输出日志
#ifndef LogInfo
#   define LogInfo(format, ...)         \
    {                                   \
        if(isPrintLog == 1)             \
        {                               \
            NSLog((@"%@:%d " format),   \
            [[[NSString stringWithUTF8String:__FILE__] componentsSeparatedByString:@"/"] lastObject],\
                __LINE__,               \
                ## __VA_ARGS__);        \
        }                               \
    }
#endif


@interface CommonDeal : NSObject
//{
//    UserModel       *m_curLoginUser;    // 当前已登录用户
//    CityModel       *m_curCity;         // 当前所在城市
//    NSArray         *m_allCity;         // 获取到的城市列表（未排序）
//    NSMutableArray  *m_categoryArray;   // 获取当前城市所有分类
//    NSMutableArray  *m_regionArray;     // 获取当前城市的所有分区
//    NSMutableArray  *m_hotDistrictArray;// 热门分区的数组
//    NSMutableArray  *m_hotCategoryArray;// 热门分类的数组
//}
//@property(nonatomic ,retain) UserModel      *m_curLoginUser;
//@property(nonatomic ,retain) CityModel      *m_curCity;
//@property(nonatomic ,retain) NSArray        *m_allCity;
//@property(nonatomic ,retain) NSMutableArray *m_categoryArray;
//@property(nonatomic ,retain) NSMutableArray *m_regionArray;
//@property(nonatomic ,retain) NSMutableArray *m_hotDistrictArray;
//@property(nonatomic ,retain) NSMutableArray *m_hotCategoryArray;

/*!         获取CommonDeal单例
 *\param    无
 *\returns  返回CommonDeal对象
 */
+ (id)shareCommon;


@end
