//
//  WalletHeaderView.h
//  RiderIOS
//
//  Created by Han on 2018/6/11.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalletHeaderView : UIView
+ (id)defaultView;

- (void)getBalanceData:(NSString *)balance;
@end
