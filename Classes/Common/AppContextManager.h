//
//  AppContextManager.h
//  ChinaYZ
//
//  Created by yons on 14-7-1.
//  Copyright (c) 2014年 yons. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _ServiceType
{
    MY = 0, //母婴
    WX = 1, //维修
    QC = 2, //汽车
    MC = 3, //萌宠
    JZ = 3, //家政
    BJ = 4, //搬家
    JK = 5, //健康
    
}ServiceType;

typedef enum _RankListType
{
    dayMileage = 0, //日里程
    dayOrders = 1, //日接单
    monthMileage = 2, //月里程
    monthOrders = 3, //月接单
    
}RankListType;

@interface AppContextManager : NSObject
{
    NSString *isLogin;
    NSString *locX;
    NSString *locY;
    NSString *locCityName;
    NSString *cityID;
    NSString *userAccopunt;
    NSString *userID;
    NSString *userPhone;
    NSString *userStatus;
    NSString *token;
    NSString *imageURl;
    NSString *isRider;
    
}

@property(nonatomic,strong)NSString *isLogin;
@property(nonatomic,strong)NSString *locX;
@property(nonatomic,strong)NSString *locY;
@property(nonatomic,strong)NSString *locCityName;
@property(nonatomic,strong)NSString *cityID;
@property(nonatomic,strong)NSString *userAccopunt;
@property(nonatomic,strong)NSString *userID;
@property(nonatomic,strong)NSString *userPhone;
@property(nonatomic,strong)NSString *userStatus;
@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)NSString *imageURl;

@property(nonatomic,strong)NSString *bond_money;
@property(nonatomic,strong)NSString *balance;
@property(nonatomic,strong)NSString *photo;
@property(nonatomic,strong)NSString *photo_front;
@property(nonatomic,strong)NSString *riderID;
@property(nonatomic,strong)NSString *health_type;
@property(nonatomic,strong)NSString *rider_type;
@property(nonatomic,strong)NSString *addr;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *closed;

/**
 *	@brief	初始化单例
 */
+ (id)shareManager;

@end
