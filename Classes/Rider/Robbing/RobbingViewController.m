//
//  RobbingViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/4.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "RobbingViewController.h"
#import "ZWMSegmentController.h"
#import "NewTaskViewController.h"
#import "StayDistributionViewController.h"
#import "DistributioningViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface RobbingViewController ()<BMKMapViewDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate>
{
    UIImageView *navBarHairlineImageView;
    BMKMapView* m_mapView;
    BMKLocationService* m_locService;
    BMKGeoCodeSearch *m_geocodesearch;
}

@property (nonatomic, strong) ZWMSegmentController *segmentVC;

@end

@implementation RobbingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    //新任务
    NewTaskViewController *newVC = [[NewTaskViewController alloc] init];
    
    //待配送
    StayDistributionViewController *stayVC = [[StayDistributionViewController alloc] init];
    //配送中
    DistributioningViewController *distributioningVC = [[DistributioningViewController alloc] init];
    NSArray *array = @[newVC,stayVC,distributioningVC];
    
    self.segmentVC = [[ZWMSegmentController alloc] initWithFrame:self.view.bounds titles:@[@"新任务",@"待配送",@"配送中"]];
    self.segmentVC.segmentView.style=ZWMSegmentStyleDefault;
    self.segmentVC.segmentView.showSeparateLine = YES;
    self.segmentVC.segmentView.backgroundColor = [UIColor colorWithHexString:@"2196d9"];
    self.segmentVC.segmentView.segmentNormalColor = [UIColor whiteColor];
    self.segmentVC.segmentView.segmentTintColor = [UIColor whiteColor];
    self.segmentVC.viewControllers = [array copy];
    //    if (array.count==1) {
    //        self.segmentVC.segmentView.style=ZWMSegmentStyleDefault;
    //    } else {

    //    }
    //    [self.segmentVC  enumerateBadges:@[@(1),@10]];
    [self addSegmentController:self.segmentVC];
    
    [self.segmentVC  setSelectedAtIndex:0];
    
    __weak typeof(self) weakSelf = self;
    newVC.prohibitSlide = ^(BOOL isSlide) {
        weakSelf.segmentVC.containerView.scrollEnabled = isSlide;
    };
    
    m_mapView = [[BMKMapView alloc]init];
    
    m_geocodesearch = [[BMKGeoCodeSearch alloc]init];
    
    //定位
    m_locService = [[BMKLocationService alloc]init];
    [m_locService startUserLocationService];
}


- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}


#pragma mark 百度地图委托方法
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //    m_appMger.locX = [NSString  CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);

}


/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     navBarHairlineImageView.hidden = YES;
    self.navigationController.navigationBar.translucent = NO;
    
    m_mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    m_locService.delegate = self;
    m_geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
     navBarHairlineImageView.hidden = NO;
    
    m_mapView.delegate = nil; // 不用时，置nil
    m_locService.delegate = nil;
    m_geocodesearch.delegate = nil; // 不用时，置nil
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
