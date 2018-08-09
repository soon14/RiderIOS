//
//  NavigationAddressTableViewCell.h
//  RiderDemo
//
//  Created by mac on 2018/1/18.
//  Copyright © 2018年 mac. All rights reserved.

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "MapAddressMode.h"

@protocol NavigationAddressTableViewCellDelegate <NSObject>
- (void)downBtnTag:(NSString *)btnTag withBtnString:(NSString *)string;
@end
@interface NavigationAddressTableViewCell : UITableViewCell
{
    __weak id<NavigationAddressTableViewCellDelegate>delegate;
    
}
@property(nonatomic,weak) id<NavigationAddressTableViewCellDelegate>delegate;
- (void)setData:(MapAddressMode *)mode withIndexPath:(NSIndexPath *)path;

- (void)setDownData:(BMKOLUpdateElement *)oflineData withIndexPath:(NSIndexPath *)path;

@end
