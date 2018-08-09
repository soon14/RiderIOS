//
//  LocationcityViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/14.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "LocationcityViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationcityViewController ()<CLLocationManagerDelegate>
{
    
}

@property (nonatomic,strong ) CLLocationManager *locationManager;//定位服务
@property (nonatomic,copy)    NSString *currentCity;//城市

@property(nonatomic,weak)IBOutlet UILabel *cityLbl;

@end

@implementation LocationcityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self locatemap];
}

- (void)locatemap{
    
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        [_locationManager requestAlwaysAuthorization];
        _currentCity = [[NSString alloc]init];
        [_locationManager requestWhenInUseAuthorization];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 5.0;
        [_locationManager startUpdatingLocation];
    }
}

#pragma mark - 定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication]openURL:settingURL];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - 定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    [_locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //当前的经纬度
    NSLog(@"当前的经纬度 %f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
   
    __weak typeof(self) weakSelf = self;
    //地理反编码 可以根据坐标(经纬度)确定位置信息(街道 门牌等)
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count >0) {
            CLPlacemark *placeMark = placemarks[0];
            weakSelf.currentCity = placeMark.locality;
            if (!weakSelf.currentCity) {
                weakSelf.currentCity = @"无法定位当前城市";
            }
            
            weakSelf.cityLbl.text = weakSelf.currentCity;
            
            //看需求定义一个全局变量来接收赋值
//            NSLog(@"当前国家 - %@",placeMark.country);//当前国家
//            NSLog(@"当前城市 - %@",weakSelf.currentCity);//当前城市
//            NSLog(@"当前位置 - %@",placeMark.subLocality);//当前位置
//            NSLog(@"当前街道 - %@",placeMark.thoroughfare);//当前街道
//            NSLog(@"具体地址 - %@",placeMark.name);//具体地址
//            NSString *message = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",placeMark.country,weakSelf.currentCity,placeMark.subLocality,placeMark.thoroughfare,placeMark.name];
//
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"好", nil];
//            [alert show];
            
            
        }else if (error == nil && placemarks.count){
            
            NSLog(@"NO location and error return");
        }else if (error){
            
            NSLog(@"loction error:%@",error);
        }
    }];
}


- (IBAction)confirmPress:(id)sender
{
    [self performSegueWithIdentifier:@"goTabBar" sender:self];
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
