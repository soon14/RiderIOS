//
//  GBWXPayManagerConfig.h
//  微信支付
//
//  Created by 张国兵 on 15/7/25.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.
//

#ifndef _____GBWXPayManagerConfig_h
#define _____GBWXPayManagerConfig_h
//===================== 微信账号帐户资料=======================

#import "payRequsestHandler.h"         //导入微信支付类
#import "WXApi.h"

#define APP_ID          @"wxd91de7b5376a5aa3"               //APPID
//商户号，填写商户对应参数
#define MCH_ID          @"1494512652"
//商户API密钥，填写相应参数
#define PARTNER_ID      @"mMsadfjklkljsdflkDFDFSA122165454"
//支付结果回调页面
#define NOTIFY_URL      @"http://cs.5d.com.cn/wx/wx_notice.do"
//获取服务器端支付数据地址（商户自定义）
#define SP_URL          @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php"

#endif
