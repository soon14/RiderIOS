//
//  ACQConfig.h
//  AuqaCity
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef ACQConfig_h
#define ACQConfig_h
//#import "NSArray+STAR.h"
//#import "UserDataConfig.h"
//#import "NetWorkConfig.h"
//#import "YTKKeyValueStore.h"
#define  K_SCREENWIDTH_ios              [UIScreen mainScreen].bounds.size.width

#define  K_SCREENHEIGHT_ios             [UIScreen mainScreen].bounds.size.height

#define  K_SCREENSCALE                   [UIScreen mainScreen].bounds.size.width/375

#define ICON_DEFAULT_ios                    [UIImage imageNamed:@"CreatHead"]

#define ICON_LOADING_ios                    [UIImage imageNamed:@"BigLoad"]

#define NETWORK_MESSAGEDEFAULT           @"网络不给力"

//#define REQUEST_BASE_URL_ios         @"http://www.xiaooo.cn:8080/photo/api/appFunction"
#define REQUEST_BASE_URL_ios1          @"http://api.aquacity-nj.com:9821/aquacity/modilb/appFunction"//@"http://api.aquacity-nj.com/cowboy/app_func.php" //
#define REQUEST_BASE_URL_ios  @"http://api.aquacity-nj.com:9821/aquacity/modilb/appFunction"//@"http://192.168.11.152:9821/aquacity/modilb/appFunction"//

#define K_QQAPIKEY_ios                  @"1104748592"

#define K_WEIXIN_id                     @"wxad781e7f48d39055"

#define K_WEIXIN_secret                 @"4463b5e1c8e54072e06e41b87ec864c5"

#define  MEITUANURL                     @"http://i.meituan.com/cinema/719787.html"

typedef enum {
	
	KRDefultFailedTimeOut = 1, //网络不给力
	
	KRDefaultSuccess = 0, //请求成功
	
	KRDefaultFailedServer = 2, // 服务器故障
	
	KRDefaultFailedUserInfo = 3, // 服务器故障
	
}CustomError;
typedef enum {
	
	APBannerRequestBegin,
	
	APBannerRequestFailed,
	
	APBannerRequestSuccess,
	
	APBannerRequestTimeOut,
	
}APBanner;
typedef enum {
	
	APSkipTopic , //话题跳转
	
	APSkipGuild , //圈子跳转
	
	APSkipGallery, //照片墙跳转
	
}APSkipEnum;
typedef enum {
	
	KRshareWeb = 1, //分享网页
	
	KRShareImage = 0, //分享图片
	
}KRShareEnum;
typedef enum {
	APPhotoInform, //照片举报
	APPostInform, //帖子举报
	
	
	APCommentInform, // 评论举报
	APFriendInform, //好友举报
	
}APInform;
typedef enum {
	
	KRSupport,
	
	KRCancelSupport = 0,
	
	KRComment,
	
	KRDeleteComment,
	
	KRDeleteNote,
	
	KROPerateFailed,
	
	KRFunction,
	
	KRSkip,
	
	KRSpaceType,
	
	KRPhotoType,
	
	KRTotalType,
	
	KRHotType,
	
	KRCollect,
	
	KRCancelCollect,
	
	KRMarkType,
	
	KRHasBlack,
	
	KRBlacked,
	
	KRReplyCommnet,
	
}KRNoteOperate;
typedef NS_ENUM(NSUInteger,IndoorMapType) {
	E_IndoorMapMain = 0,
	E_IndoorMapSearch,
};
#endif /* ACQConfig_h */
