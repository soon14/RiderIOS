//
//  GrabViewController.h
//  RiderDemo
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface GrabViewController : UIViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKRouteSearchDelegate>
@property(nonatomic,strong)NSString *grabType;
@property(nonatomic,strong)NSString *orderID;
@end
