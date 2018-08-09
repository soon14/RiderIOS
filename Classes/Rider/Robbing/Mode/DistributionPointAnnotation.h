//
//  DistributionPointAnnotation.h
//  RiderDemo
//
//  Created by mac on 2018/1/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface DistributionPointAnnotation : BMKPointAnnotation
{
 
    //    UIimge  *img;
    NSString *index;
    NSString *cxStr;
    NSString *buildDate;
    NSString *area;

}
@property (nonatomic,strong)NSString *index;
@property (nonatomic,strong)NSString *cxStr;
@property (nonatomic,strong)NSString *buildDate;
@property (nonatomic,strong)NSString *area;

@property (nonatomic) NSInteger degree;
///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点  6:楼梯、电梯
@property (nonatomic) NSInteger type;
//获取该RouteAnnotation对应的BMKAnnotationView
- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview;
@end
