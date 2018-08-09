//
//  PersonalCenterViewController.h
//  RiderIOS
//
//  Created by Han on 2018/6/19.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalCenterViewController : UIViewController

@property (nonatomic, copy) void(^URLBlock)(NSString * url);

@end
