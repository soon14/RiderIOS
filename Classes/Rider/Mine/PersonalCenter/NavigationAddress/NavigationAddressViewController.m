//
//  NavigationAddressViewController.m
//  RiderDemo
//
//  Created by mac on 2018/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "NavigationAddressViewController.h"
#import "NavigationAddressTableViewCell.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "AppContextManager.h"
#import "MapAddressMode.h"


static NSString *const navAddressCellIndentifier = @"NavigationAddressTableViewCell";

@interface NavigationAddressViewController ()<BMKMapViewDelegate,BMKOfflineMapDelegate,NavigationAddressTableViewCellDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate>
{
   
    BMKMapView* m_mapView;
    BMKLocationService* m_locService;
    BMKGeoCodeSearch *m_geocodesearch;
    AppContextManager *m_appMger;
    
    NSArray *m_currentLoc;
    NSMutableArray *m_arrayCurrentCity;//当前城市
    NSMutableArray * m_arrayHotCityData;//热门城市
    NSMutableArray * m_arrayOfflineCityData;//全国支持离线地图的城市
    NSMutableArray * m_arraylocalDownLoadMapInfo;//本地下载的离线地图
    IBOutlet UISegmentedControl *m_tableviewChangeCtrl;
    NSString *tableType;//切换数据类型
    NSString *fistGeo;//获取当前位置信息
    BOOL isClickBtn;
    NSIndexPath *path;
    NSMutableArray *contrastArr;
    NSMutableDictionary *dicData;   //变化的
    NSMutableDictionary *fileDic;        //最终保存
    NSString *filePath;
}
@property(nonatomic,weak) IBOutlet UITableView *m_navAddressTaleView;
@property(nonatomic,strong)BMKOfflineMap *m_offlineMap;
@end

@implementation NavigationAddressViewController
@synthesize type;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    fistGeo = @"0";
    
    contrastArr = [[NSMutableArray alloc]initWithCapacity:0];
    m_mapView = [[BMKMapView alloc]init];
    m_geocodesearch = [[BMKGeoCodeSearch alloc]init];
    
    //定位
    m_locService = [[BMKLocationService alloc]init];
    [m_locService startUserLocationService];
    
    m_appMger  = [AppContextManager shareManager];
    [self.m_navAddressTaleView registerNib:[UINib nibWithNibName:@"NavigationAddressTableViewCell" bundle:nil] forCellReuseIdentifier:navAddressCellIndentifier];
    self.m_navAddressTaleView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.m_navAddressTaleView.backgroundColor = [UIColor colorWithHexString:@"eff3f8"];
    
    m_currentLoc = [[NSArray alloc]init];
    //初始化离线地图服务
    self.m_offlineMap = [[BMKOfflineMap alloc]init];
    
    //城市数据源
   dicData = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    fileDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    //当前城市
    m_arrayCurrentCity = [NSMutableArray arrayWithCapacity:0];

    isClickBtn = YES;
    m_tableviewChangeCtrl.selectedSegmentIndex = 0;
    tableType = @"cityList";

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    m_mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    m_locService.delegate = self;
    m_geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.m_offlineMap.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"City.plist"];
    NSFileManager *fileM = [NSFileManager defaultManager];
    
    //    判断文件是否存在，不存在则直接创建，存在则直接取出文件中的内容
    if (![fileM fileExistsAtPath:filePath]) {
        [fileM createFileAtPath:filePath contents:nil attributes:nil];
        
        //    获取路径
        NSMutableDictionary * dic = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        if ([dic count] <3) {
            //获取热门城市
            m_arrayHotCityData = [NSMutableArray arrayWithCapacity:0];
            for (int i = 0; i < [[self.m_offlineMap getHotCityList] count]; i ++) {
                BMKOLSearchRecord* offlineData = [[self.m_offlineMap getHotCityList] objectAtIndex:i];
                MapAddressMode *mode = [[MapAddressMode alloc]init];
                mode.title = offlineData.cityName;
                mode.dataSize = offlineData.size;
                mode.cityID = offlineData.cityID;
                mode.loadState = @"Unload";
                mode.progress = @"0";
                [m_arrayHotCityData addObject:mode];
            }
            
            
            
            [dicData setObject:m_arrayHotCityData forKey:@"1"];
            NSLog(@"m_arrayHotCityData == %@",m_arrayHotCityData);
            NSLog(@"dicData1 == %@",dicData);
            
            //获取支持离线下载城市列表
            m_arrayOfflineCityData = [[NSMutableArray alloc]initWithCapacity:0];
            for (int j = 0; j < [[self.m_offlineMap getOfflineCityList] count]; j ++) {
                BMKOLSearchRecord* offlineData = [[self.m_offlineMap getOfflineCityList] objectAtIndex:j];
                MapAddressMode *mode = [[MapAddressMode alloc]init];
                mode.title = offlineData.cityName;
                mode.dataSize = offlineData.size;
                mode.loadState = @"Unload";
                mode.progress = @"0";
                mode.cityID = offlineData.cityID;
                [m_arrayOfflineCityData addObject:mode];
            }
            [dicData setObject:m_arrayOfflineCityData forKey:@"2"];
            NSLog(@"m_arrayOfflineCityData == %@",m_arrayOfflineCityData);
            [NSKeyedArchiver archiveRootObject:dicData toFile:filePath];
            NSLog(@"dicData2 == %@",dicData);
        }
        else
        {
            
        }
        
        //获取本地离线下载城市列表
        //    m_arraylocalDownLoadMapInfo = [NSMutableArray arrayWithArray:[self.m_offlineMap getAllUpdateInfo]];
        //    if ([m_arraylocalDownLoadMapInfo count] >0) {
        //        for (int i = 0; i < [m_arraylocalDownLoadMapInfo count]; i ++) {
        //            BMKOLUpdateElement* item = [m_arraylocalDownLoadMapInfo objectAtIndex:i];
        //            [contrastArr addObject:[NSString stringWithFormat:@"%d",item.cityID]];
        //        }
        //    }
        
        
        [self.m_navAddressTaleView reloadData];
    }
    
    dicData = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"dicData2 == %@",dicData);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    
   
    
}

-(IBAction)segmentChanged:(id)sender
{
    UISegmentedControl* control = (UISegmentedControl*)sender;
    switch (control.selectedSegmentIndex) {
            
        case 0:
        {
            tableType = @"cityList";

            m_arraylocalDownLoadMapInfo = [NSMutableArray arrayWithArray:[self.m_offlineMap getAllUpdateInfo]];
            if ([m_arraylocalDownLoadMapInfo count] >0) {
                for (int i = 0; i < [m_arraylocalDownLoadMapInfo count]; i ++) {
                    BMKOLUpdateElement* item = [m_arraylocalDownLoadMapInfo objectAtIndex:i];
                    [contrastArr addObject:[NSString stringWithFormat:@"%d",item.cityID]];
                }
            }
            [self.m_navAddressTaleView reloadData];
        }
            break;
        case 1:
        {
            tableType = @"offLineList";
            //获取各城市离线地图更新信息
            m_arraylocalDownLoadMapInfo = [NSMutableArray arrayWithArray:[self.m_offlineMap getAllUpdateInfo]];
            if ([m_arraylocalDownLoadMapInfo count] >0) {
                for (int i = 0; i < [m_arraylocalDownLoadMapInfo count]; i ++) {
                    BMKOLUpdateElement* item = [m_arraylocalDownLoadMapInfo objectAtIndex:i];
                    [contrastArr addObject:[NSString stringWithFormat:@"%d",item.cityID]];
                }
            }
            [self.m_navAddressTaleView reloadData];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UItableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableType isEqualToString:@"cityList"]) {
        return 3;
    }
    else
    {
        return 1;
    }
    
}

//定义section标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    if ([tableType isEqualToString:@"cityList"]) {
        //定义每个section的title
        NSString *provincName=@"";
        if(section==0)
        {
            provincName = @"当前位置";
        }
        else if(section==1)
        {
            provincName=@"热门城市";
            
        }
        else
        {
            provincName=@"全国";
        }
        return  provincName;
    }
    else
    {
        return nil;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

     if ([tableType isEqualToString:@"cityList"]) {
         if (section == 0) {
             return 1;
         }
         else if (section == 1)
         {
             return [[dic valueForKey:@"1"] count];
         }
         else
         {
             return [[dic valueForKey:@"2"] count];
         }
     }
    else
    {
         return [m_arraylocalDownLoadMapInfo count];
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        NavigationAddressTableViewCell *cell = (NavigationAddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:navAddressCellIndentifier];
    
        if (cell == nil)
        {
            cell = [[NavigationAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:navAddressCellIndentifier];
        }
        cell.delegate =self;
        if ([tableType isEqualToString:@"cityList"]) {

            if (indexPath.section == 0) {
                
            }
            else{
                NSString *sectionStr = [NSString stringWithFormat:@"%lu",indexPath.section];
                MapAddressMode *mode = [[dicData valueForKey:sectionStr] objectAtIndex:indexPath.row];
                [cell setData:mode withIndexPath:indexPath];
            }
            
        }
        else
        {
            if(m_arraylocalDownLoadMapInfo!=nil&&m_arraylocalDownLoadMapInfo.count>indexPath.row)
            {
                BMKOLUpdateElement* item = [m_arraylocalDownLoadMapInfo objectAtIndex:indexPath.row];
                [cell setDownData:item withIndexPath:indexPath];
            }
            else
            {
                cell.textLabel.text = @"";
            }
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //    typeStr = @"";
    //    if([segue.identifier isEqualToString:@"PayToCoupon"]){
    //        QQKCouponViewController *couponCtr = segue.destinationViewController;
    //        couponCtr.delegate = self;
    //    }
}

- (void)downBtnTag:(NSString *)btnTag withBtnString:(NSString *)string
{
   
    if (!isClickBtn) {
//        [XHToast showCenterWithText:@"下载中..."];
        [XHToast showCenterWithText:@"下载中..." duration:2.0];
        return;
    }

    NSArray *arr = [btnTag componentsSeparatedByString:@","];
    NSLog(@"1 === %@，%@",[arr objectAtIndex:0],[arr objectAtIndex:1]);

//    [m_navAddressTaleView reloadData];

    NSMutableDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    MapAddressMode *mode = [[dic valueForKey:[arr objectAtIndex:0]] objectAtIndex:[[arr objectAtIndex:1] intValue]];

    [self.m_offlineMap start:mode.cityID];

    path = [NSIndexPath indexPathForRow:[[arr objectAtIndex:1]integerValue] inSection:[[arr objectAtIndex:0]integerValue]];
}


#pragma mark - 离线地图delegate
- (void)onGetOfflineMapState:(int)type withState:(int)state
{
    if (type == TYPE_OFFLINE_UPDATE) {
        //id为state的城市正在下载或更新，start后会毁掉此类型
        BMKOLUpdateElement* updateInfo;
        updateInfo = [self.m_offlineMap getUpdateInfo:state];
        NSLog(@"城市名：%@,下载比例:%d",updateInfo.cityName,updateInfo.ratio);
//        NSLog(@"%d",state);
       
        MapAddressMode *mode = [[dicData valueForKey:[NSString stringWithFormat:@"%lu",path.section]] objectAtIndex:path.row];
        
        if (updateInfo.ratio == 100) {
            isClickBtn = YES;
            mode.loadState = @"Loaded";
            [NSKeyedArchiver archiveRootObject:dicData toFile:filePath];
        }
        else
        {
            isClickBtn = NO;
            mode.loadState = @"Loading" ;
            mode.progress = [NSString stringWithFormat:@"下载进度%d%@",updateInfo.ratio,@"%"];
        }
        
       [NSKeyedArchiver archiveRootObject:dicData toFile:filePath];
        __weak typeof(self)weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.m_navAddressTaleView reloadData];
        });
        
       
    }
    
    if (type == TYPE_OFFLINE_NEWVER) {
        //id为state的state城市有新版本,可调用update接口进行更新
        BMKOLUpdateElement* updateInfo;
        updateInfo = [self.m_offlineMap getUpdateInfo:state];
        NSLog(@"是否有更新%d",updateInfo.update);
    }
    if (type == TYPE_OFFLINE_UNZIP) {
        //正在解压第state个离线包，导入时会回调此类型
    }
    if (type == TYPE_OFFLINE_ZIPCNT) {
        //检测到state个离线包，开始导入时会回调此类型
        NSLog(@"检测到%d个离线包",state);
        if(state==0)
        {
            [self showImportMesg:state];
        }
    }
    if (type == TYPE_OFFLINE_ERRZIP) {
        //有state个错误包，导入完成后会回调此类型
        NSLog(@"有%d个离线包导入错误",state);
    }
    if (type == TYPE_OFFLINE_UNZIPFINISH) {
        NSLog(@"成功导入%d个离线包",state);
        //导入成功state个离线包，导入成功后会回调此类型
        [self showImportMesg:state];
    }
}

//导入提示框
- (void)showImportMesg:(int)count
{
    NSString* showmeg = [NSString stringWithFormat:@"成功导入离线地图包个数:%d", count];
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"导入离线地图" message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

//获取当前位置信息
- (void)reverseGeocode
{
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){[m_appMger.locY floatValue], [m_appMger.locX floatValue]};
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [m_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
        
    }
    else
    {
        NSLog(@"反geo检索发送失败");
        
    }
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0) {
        fistGeo = @"1";
        //获取当前城市信息
        m_currentLoc = [self.m_offlineMap searchCity:result.addressDetail.city];
        
        if ([self.m_offlineMap searchCity:result.addressDetail.city] > 0) {
            for (int z = 0; z < [m_currentLoc count]; z ++) {
                BMKOLSearchRecord* offlineData = [m_currentLoc objectAtIndex:z];
                MapAddressMode *mode = [[MapAddressMode alloc]init];
                mode.title = offlineData.cityName;
                mode.dataSize = offlineData.size;
                mode.loadState = @"Unload";
                mode.progress = @"0";
                mode.cityID = offlineData.cityID;
                [m_arrayCurrentCity addObject:mode];
            }
            
            [dicData setObject:m_arrayCurrentCity forKey:@"0"];
            [NSKeyedArchiver archiveRootObject:dicData toFile:filePath];
        }
//        m_appMger.locCityName = result.addressDetail.city;
//        m_appMger.cityID = result.cityCode;
        [self.m_navAddressTaleView reloadData];
    }
}

#pragma mark 百度地图委托方法
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //        NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //    m_appMger.locX = [NSString  CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    m_appMger.locX = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    m_appMger.locY = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    [m_mapView updateLocationData:userLocation];
    
   
    
        if([fistGeo isEqualToString:@"0"])
        {
           NSMutableDictionary * dic = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
            if ([dic count] <3) {
                //获取本地地址信息
                [self reverseGeocode];
            }
           
        }
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


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    m_mapView.delegate = nil; // 不用时，置nil
    m_locService.delegate = nil;
    m_geocodesearch.delegate = nil; // 不用时，置nil
    self.m_offlineMap.delegate = nil; // 不用时，置nil
}

- (void)dealloc {
     NSLog(@"m_geocodesearch:%lu",CFGetRetainCount((__bridge CFTypeRef)(m_geocodesearch)));
    if (m_geocodesearch) {
        m_geocodesearch = nil;
    }
     NSLog(@"m_mapView:%lu",CFGetRetainCount((__bridge CFTypeRef)(m_mapView)));
    if (m_mapView) {
        m_mapView = nil;
    }
    
    NSLog(@"m_offlineMap:%lu",CFGetRetainCount((__bridge CFTypeRef)(self.m_offlineMap)));
    if (self.m_offlineMap != nil) {
        self.m_offlineMap = nil;
    }
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
