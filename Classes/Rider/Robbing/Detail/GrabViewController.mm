//
//  GrabViewController.m
//  RiderDemo
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GrabViewController.h"
#import "DistributionPointAnnotation.h"
#import "AppContextManager.h"
#import "UIView+SDAutoLayout.h"
#import "GrabTableViewCell.h"
#import "GrabHeaderView.h"
#import "TitleHeaderView.h"
#import "OrderDetailTableViewCell.h"
#import "OrderInfoTableViewCell.h"
#import "StatusTimeTableViewCell.h"
#import "OrderDetailMode.h"

#import "UIImage+Rotate.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import "PromptInfo.h"


static NSString *const grabCellIndentifier = @"GrabTableViewCell";
static NSString *const orderDetailCellIndentifier = @"OrderDetailTableViewCell";
static NSString *const orderInfoCellIndentifier = @"OrderInfoTableViewCell";
static NSString *const statusCellIndentifier = @"StatusTimeTableViewCell";


@interface GrabViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
//    UIScrollView *m_contentScroller;
    NSMutableArray *grabArr;
    BMKMapView* m_mapView;
    BMKLocationService* m_locService;
    BMKRouteSearch* m_routesearch;
    BMKPolyline* colorfulPolyline;
    NSMutableArray *annotatioss;                //坐标数组
    
    CLLocationCoordinate2D  myPoint;            //现在的坐标位置
    CLLocationCoordinate2D  startPoint;         //商家的坐标位置
    int firstLine;                             //第一次请求路径
    
    float currentY;
    BOOL isNotUp;
    
    UIView *bottomView;                         //地步接单按钮视图
   
    NSArray *infoArr;
    
}
@property(nonatomic,strong)UITableView *m_grabTableView;
@property(nonatomic,weak)IBOutlet UIView *m_distributionView;
@property(nonatomic,weak)IBOutlet UIButton *contactBtn;
@property(nonatomic,weak)IBOutlet UIButton *statusBtn;
@property(nonatomic,strong) UIButton *upBtn;
@property(nonatomic,strong) GrabHeaderView *headerView;

//顶部视图高度，默认为屏幕的2/3
@property (nonatomic) float heightOfTopView;
@property (nonatomic, strong) AppContextManager *appMger;
@property(nonatomic,strong) MBProgressHUD *hubView;
@property(nonatomic,strong)NSMutableArray *infoKeyArr;
@property(nonatomic,strong)NSMutableArray *detailArr;
@property(nonatomic,strong)NSMutableArray *otherArr;
@end

@implementation GrabViewController
@synthesize grabType;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.appMger = [AppContextManager shareManager];

    infoArr = [[NSArray alloc]initWithObjects:@"订单编号",@"期望送达",@"发票",@"备注信息",nil];
    self.detailArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.infoKeyArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.otherArr = [[NSMutableArray alloc]initWithCapacity:0];
//    NSArray *nameArr = [[NSArray alloc]initWithObjects:@"燕麦面包",@"法式长棍",@"甜甜圈",@"汉堡",@"配送费",@"餐盒费",@"63.30", nil];
//    NSArray *numArr = [[NSArray alloc]initWithObjects:@"1",@"2",@"1",@"3",@"1",@"",@"", nil];
//    NSArray *moneyArr = [[NSArray alloc]initWithObjects:@"20.00",@"16.00",@"20.30",@"25.00", @"16.00",@"20.30",@"25.00",nil];
    
//    for (int i = 0; i< [nameArr count]; i ++) {
//        OrderDetailMode *mode = [[OrderDetailMode alloc]init];
//        mode.name = [nameArr objectAtIndex:i];
//        mode.num = [numArr objectAtIndex:i];
//        mode.money = [moneyArr objectAtIndex:i];
//        [detailArr addObject:mode];
//    }
//
    firstLine = 0;
    
     self.headerView = [GrabHeaderView defaultView];
    
      UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(heiddenTableView)];
      [self.headerView addGestureRecognizer:tapGesture];
    
     m_mapView = [[BMKMapView alloc]init];
     [self.view addSubview:m_mapView];
    
     self.m_grabTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
     self.m_grabTableView.delegate = self;
     self.m_grabTableView.dataSource = self;
     self.m_grabTableView.backgroundColor = [UIColor clearColor];
     self.m_grabTableView.showsVerticalScrollIndicator = NO;
     [self.m_grabTableView registerNib:[UINib nibWithNibName:@"GrabTableViewCell" bundle:nil] forCellReuseIdentifier:grabCellIndentifier];
     [self.m_grabTableView registerNib:[UINib nibWithNibName:@"OrderDetailTableViewCell" bundle:nil] forCellReuseIdentifier:orderDetailCellIndentifier];
     [self.m_grabTableView registerNib:[UINib nibWithNibName:@"OrderInfoTableViewCell" bundle:nil] forCellReuseIdentifier:orderInfoCellIndentifier];
    [self.m_grabTableView registerNib:[UINib nibWithNibName:@"StatusTimeTableViewCell" bundle:nil] forCellReuseIdentifier:statusCellIndentifier];
    
      self.m_grabTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     [self.view addSubview:self.m_grabTableView];
    
    

    grabArr = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"", nil];
    
    //定位
    m_locService = [[BMKLocationService alloc]init];
    [m_locService startUserLocationService];
    m_mapView.showsUserLocation = NO;//先关闭显示的定位图层
    m_mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    m_mapView.showsUserLocation = YES;//显示定位图层
    m_mapView.delegate = self;
    
    //自定义定位图标
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
    displayParam.isRotateAngleValid = false;//跟随态旋转角度是否生效
    displayParam.isAccuracyCircleShow = false;//精度圈是否显示
    displayParam.canShowCallOut = false;
    displayParam.locationViewImgName= @"icon_center_point";//定位图标名称
    displayParam.locationViewOffsetX = 0;//定位偏移量(经度)
    displayParam.locationViewOffsetY = 0;//定位偏移量（纬度）
    [m_mapView updateLocationViewWithParam:displayParam];
    
    //地图比例尺等级设置
    [m_mapView setZoomEnabled:YES];
    [m_mapView setZoomLevel:18];
    
    //路线规划
    m_routesearch = [[BMKRouteSearch alloc]init];
    
    m_mapView.sd_layout
    .widthIs(Screen_width)
    .bottomSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0);
    
    self.m_grabTableView.sd_layout
    .widthIs(Screen_width)
    .bottomSpaceToView(self.view, 70)
    .topSpaceToView(self.view, 0);

    
    bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomView];
    [self.view bringSubviewToFront:self.m_distributionView];
    
    if ([grabType isEqualToString:@"new"]) {
        bottomView.hidden = NO;
        self.m_distributionView.hidden = YES;
    }
    else
    {
        bottomView.hidden = YES;
        self.m_distributionView.hidden = NO;
        
        if ([grabType isEqualToString:@"stay"]) {
            [self.contactBtn setTitle:@"联系商家" forState:UIControlStateNormal];
            [self.statusBtn setTitle:@"我已取货" forState:UIControlStateNormal];
        }
        else
        {
            [self.contactBtn setTitle:@"联系顾客" forState:UIControlStateNormal];
            [self.statusBtn setTitle:@"我已送达" forState:UIControlStateNormal];
        }
    }

    UIButton *jdBtn = [[UIButton alloc]init];
    jdBtn.backgroundColor = [UIColor colorWithHexString:@"2196d9"];
    jdBtn.layer.cornerRadius = 3;
    [jdBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [jdBtn setTitle:@"接 单" forState:UIControlStateNormal];
    [bottomView addSubview:jdBtn];

    bottomView.sd_layout
    .widthIs(self.view.frame.size.width)
    .bottomSpaceToView(self.view, 10)
    .heightIs(60);
    
    self.m_distributionView.sd_layout
    .widthIs(self.view.frame.size.width)
    .bottomSpaceToView(self.view, 10)
    .heightIs(60);

    jdBtn.sd_layout
    .centerYEqualToView(bottomView)
    .rightSpaceToView(bottomView, 10)
    .leftSpaceToView(bottomView, 10)
    .topSpaceToView(bottomView, 10)
    .bottomSpaceToView(bottomView, 10);

   
    self.upBtn = [[UIButton alloc]init];
    self.upBtn.backgroundColor = [UIColor clearColor];
    [self.upBtn setTitle:@"" forState:UIControlStateNormal];
    [self.upBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [self.upBtn addTarget:self action:@selector(showTableView) forControlEvents:UIControlEventTouchUpInside];
    self.upBtn.hidden = YES;
    [self.view addSubview:self.upBtn];

    if (KIsiPhoneX) {
        self.upBtn.sd_layout
        .leftSpaceToView(self.view, 10)
        .topSpaceToView(self.view, 94)
        .widthIs(35)
        .heightIs(35);
    }
    else
    {
        self.upBtn.sd_layout
        .leftSpaceToView(self.view, 10)
        .topSpaceToView(self.view, 74)
        .widthIs(35)
        .heightIs(35);
    }

    [self getAnnotation];
    
    self.hubView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hubView];
    self.hubView.label.text = @"加载中...";
    [self.hubView hideAnimated:YES];
    
}


- (void)heiddenTableView
{
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration: 1 animations: ^{
        weakself.m_grabTableView.frame = CGRectMake(0, Screen_height, Screen_width, Screen_height-70);
       weakself.upBtn.hidden = NO;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showTableView
{
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration: 1 animations: ^{
        weakself.m_grabTableView.frame = CGRectMake(0, 0, Screen_width, Screen_height-70);
        weakself.upBtn.hidden = YES;
    } completion: nil];
}

- (void)getAnnotation
{
//    [m_mapView removeAnnotations:m_mapView.annotations];
    annotatioss = [[NSMutableArray alloc]initWithCapacity:0];
    //    for (int i =0; i < [m_mapInfoArr count]; i ++) {
    
    DistributionPointAnnotation *item = [[DistributionPointAnnotation alloc]init];
    //        MapMode *model = [m_mapInfoArr objectAtIndex:i];
//    item.title = @"";
    item.index = @"1";
    item.subtitle = @"1";
    //        item.index = @"1";
    //        item.cxStr = @"";
    //        NSArray *arr = [model.location componentsSeparatedByString:@","];
    //        NSLog(@"location == %@",model.location);
    //        CLLocationDegrees y = [model.m_lat floatValue];
    //        CLLocationDegrees x = [model.m_lng floatValue];
    CLLocationDegrees y = 32.381854;
    CLLocationDegrees x = 119.406362;
    item.coordinate = CLLocationCoordinate2DMake(y,x);
    
    //        item.img = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"smallDefualt.png"]];
    //        [item.img setImageURL:[NSURL URLWithString:model.filePath]];
    //        NSLog(@"path == %@",model.filePath);
    
    [annotatioss addObject:item];
    
    DistributionPointAnnotation *item1 = [[DistributionPointAnnotation alloc]init];
    
    //        MapMode *model = [m_mapInfoArr objectAtIndex:i];
//    item1.title = @"";
    
    item1.index = @"2";
    item1.subtitle = @"2";
    
    //        item.index = @"1";
    //        item.cxStr = @"";
    //        NSArray *arr = [model.location componentsSeparatedByString:@","];
    //        NSLog(@"location == %@",model.location);
    //        CLLocationDegrees y = [model.m_lat floatValue];
    //        CLLocationDegrees x = [model.m_lng floatValue];
    
    CLLocationDegrees y1 = 32.382854;
    CLLocationDegrees x1 = 119.405362;
    item1.coordinate = CLLocationCoordinate2DMake(y1,x1);
    [annotatioss addObject:item1];
    //    }
    
    [m_mapView addAnnotations:annotatioss];
    //    [_mapView showAnnotations:annotatioss animated:YES];
    
}

- (void)onRidingSearch{
    
    CLLocationDegrees y = [self.appMger.locY floatValue];
    CLLocationDegrees x = [self.appMger.locX floatValue];
    
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.pt = CLLocationCoordinate2DMake(y,x);
    
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    
    DistributionPointAnnotation *endPoint = [annotatioss objectAtIndex:0];
//    endPoint = [annotatioss objectAtIndex:0];
    end.pt = endPoint.coordinate;
   
    
    BMKRidingRoutePlanOption *option = [[BMKRidingRoutePlanOption alloc]init];
    option.from = start;
    option.to = end;
    BOOL flag = [m_routesearch ridingSearch:option];
    if (flag)
    {
        NSLog(@"骑行规划检索发送成功");

            firstLine = 1;
    }
    else
    {
    NSLog(@"骑行规划检索发送失败");
    }
}

#pragma mark 百度地图委托方法
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    self.appMger.locX = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    self.appMger.locY = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];

//    NSArray* array = [NSArray arrayWithArray:m_mapView.annotations];
//    [m_mapView removeAnnotation:[array objectAtIndex:0]];
//     [m_mapView removeAnnotation:[array objectAtIndex:[array count]-1]];
    
    [self.infoKeyArr removeAllObjects];
    [self.detailArr removeAllObjects];
    [self.otherArr removeAllObjects];
    [self requestDetail];
    [m_mapView removeAnnotations:m_mapView.annotations];

    [self onRidingSearch];
    [m_mapView updateLocationData:userLocation];
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

#pragma mark 设置大头针
//根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[DistributionPointAnnotation class]]) {

        return [(DistributionPointAnnotation*)annotation getRouteAnnotationView:view];
    }
    
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"annotationViewID";
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
       
        // 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
    
    // 设置位置
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    DistributionPointAnnotation *ann =  annotation;
    //    ann=annotationView.annotation  ;
    annotationView.annotation = ann;
    
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    annotationView.canShowCallout = NO;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    
    m_mapView.centerCoordinate = annotation.coordinate;
    [m_locService startUserLocationService];
    return annotationView;
}

//规划路径
- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{

    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
         if (overlay == colorfulPolyline) {
             polylineView.fillColor = [UIColor colorWithHexString:@"e84408"];
             polylineView.strokeColor = [UIColor colorWithHexString:@"e84408"];
         }
        else
        {
            polylineView.fillColor = [UIColor colorWithHexString:@"ff8a00"];
            polylineView.strokeColor = [UIColor colorWithHexString:@"ff8a00"];
   
        }
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}

/**
 *返回骑行搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果，类型为BMKRidingRouteResult
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetRidingRouteResult:(BMKRouteSearch *)searcher result:(BMKRidingRouteResult *)result errorCode:(BMKSearchErrorCode)error {
    NSLog(@"onGetRidingRouteResult error:%d", (int)error);
    
   
    
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKRidingRouteLine* plan = (BMKRidingRouteLine*)[result.routes objectAtIndex:0];
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
       
         CLLocationCoordinate2D coords[2] = {0};
        for (int i = 0; i < size; i++) {
            BMKRidingStep* transitStep = [plan.steps objectAtIndex:i];
    
           
            coords[0].latitude = transitStep.entrace.location.latitude;
            coords[0].longitude = transitStep.entrace.location.longitude;
            if (i == 0) {
                 DistributionPointAnnotation* item = [[DistributionPointAnnotation alloc]init];
                 item.coordinate = plan.starting.location;
                if (firstLine == 1)
                {
//                    item.title = @"起点";
                    item.type = 4;
                  
                }
                else
                {
                    item.title = @"起点";
                    item.type = 0;
                   
                }
                
                [m_mapView addAnnotation:item]; // 添加起点标注
            }
            if(i==size-1){
             
                
                DistributionPointAnnotation* item = [[DistributionPointAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
              
                if (firstLine == 1)
                {
                    //                    item.title = @"起点";
                    item.type = 4;
                    
                }
                else
                {
                    item.title = @"终点";
                    item.type = 1;
                    
                }
                [m_mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            DistributionPointAnnotation* item = [[DistributionPointAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.instruction;
            item.degree = (int)transitStep.direction * 30;
            item.type = 4;
            [m_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKRidingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
        }
        
        if (firstLine == 1)
        {
            // 通过points构建BMKPolyline
            BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
            [m_mapView addOverlay:polyLine]; // 添加路线overlay
        }
        else
        {
            colorfulPolyline = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
            [m_mapView addOverlay:colorfulPolyline]; // 添加路线overlay
        }

        delete []temppoints;
        
        if (firstLine == 1) {

            DistributionPointAnnotation *point = [annotatioss objectAtIndex:0];
            
            BMKPlanNode* start = [[BMKPlanNode alloc]init];
            start.name = @"sss";
//            point = [annotatioss objectAtIndex:0];
            start.pt = point.coordinate;
            
            BMKPlanNode* end = [[BMKPlanNode alloc]init];
            
            point = [annotatioss objectAtIndex:1];
            end.pt = point.coordinate;
            end.name = @"bbb";
            
            BMKRidingRoutePlanOption *option = [[BMKRidingRoutePlanOption alloc]init];
            option.from = start;
            option.to = end;
            BOOL flag = [m_routesearch ridingSearch:option];
            if (flag)
            {
                NSLog(@"骑行规划检索发送成功");
                firstLine = 2;
            }
            else
            {
                NSLog(@"骑行规划检索发送失败");
            }
        }
        else
        {
//            NSArray* array = [NSArray arrayWithArray:m_mapView.annotations];
//            [m_mapView removeAnnotations:array];
//            array = [NSArray arrayWithArray:m_mapView.overlays];
//            [m_mapView removeOverlays:array];
        }
        
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR) {
     
    }
}

//根据polyline设置地图范围
- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat leftTopX, leftTopY, rightBottomX, rightBottomY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    // 左上角顶点
    leftTopX = pt.x;
    leftTopY = pt.y;
    // 右下角顶点
    rightBottomX = pt.x;
    rightBottomY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        leftTopX = pt.x < leftTopX ? pt.x : leftTopX;
        leftTopY = pt.y < leftTopY ? pt.y : leftTopY;
        rightBottomX = pt.x > rightBottomX ? pt.x : rightBottomX;
        rightBottomY = pt.y > rightBottomY ? pt.y : rightBottomY;
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(leftTopX, leftTopY);
    rect.size = BMKMapSizeMake(rightBottomX - leftTopX, rightBottomY - leftTopY);
    UIEdgeInsets padding = UIEdgeInsetsMake(30, 0, 100, 0);
    BMKMapRect fitRect = [m_mapView mapRectThatFits:rect edgePadding:padding];
    [m_mapView setVisibleMapRect:fitRect];
}

#pragma mark - UItableView delegate
//设置表头
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if(KIsiPhoneX)
        {
            return Screen_height-140-40;
        }
        else
        {
            return Screen_height-50;
        }
    }
    if (section == 3) {
        return 10;
    }
    else
    {
        return 35;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        return self.headerView;
    }
    else
    {
       
//        [grabHeaderView addSubview:titleView];
        TitleHeaderView *view= [TitleHeaderView defaultView];
        if (section == 1) {
            view.titleLbl.text = @"订单详情";
        }
        else if (section == 2) {
            view.titleLbl.text = @"订单信息";
        }
//        else if (section == 3) {
//            view.titleLbl.text = @"收入详情";
//        }
        else
        {
            view.titleLbl.text = @"";
        }
        return view;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    else if (section == 1) {
        return [self.detailArr count];
    }
    else if (section == 2) {
        return [infoArr count];
    }
//    else if (section == 3) {
//        return 1;
//    }
//
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 3)
    {
        return 80;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        OrderDetailTableViewCell *cell = (OrderDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:orderDetailCellIndentifier];
        
        if (cell == nil)
        {
            cell = [[OrderDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:orderDetailCellIndentifier];
        }
       
        [cell setData:self.detailArr count:[self.detailArr count] index:indexPath.row withIsLast:true];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.section == 2)
    {
        OrderInfoTableViewCell *cell = (OrderInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:orderInfoCellIndentifier];
        
        if (cell == nil)
        {
            cell = [[OrderInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:orderInfoCellIndentifier];
        }
        
        if (self.infoKeyArr.count > indexPath.row) {
            [cell setTitle:[infoArr objectAtIndex:indexPath.row] withData:self.infoKeyArr[indexPath.row]];
        }
        

        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
//    else if (indexPath.section == 3)
//    {
//        GrabTableViewCell *cell = (GrabTableViewCell *)[tableView dequeueReusableCellWithIdentifier:grabCellIndentifier];
//
//        if (cell == nil)
//        {
//            cell = [[GrabTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                            reuseIdentifier:grabCellIndentifier];
//        }
//
//        cell.backgroundColor = [UIColor whiteColor];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }
    
    StatusTimeTableViewCell *cell = (StatusTimeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:statusCellIndentifier];

    if (cell == nil)
    {
        cell = [[StatusTimeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:statusCellIndentifier];
    }
    
    if (self.otherArr.count > indexPath.row) {
        [cell sendData:self.otherArr];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        //        [self performSegueWithIdentifier:@"ToMineInfo" sender:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //    typeStr = @"";
    //    if([segue.identifier isEqualToString:@"PayToCoupon"]){
    //        QQKCouponViewController *couponCtr = segue.destinationViewController;
    //        couponCtr.delegate = self;
    //    }
    
}


- (void)requestDetail
{
    [self.hubView showAnimated:YES];
    
    // http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.lists.detailapp&order_id=&type=1&lat=&lng=&openid=
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.lists.detailapp" forKey:@"r"];
    [childDic setValue:self.orderID forKey:@"order_id"];
    [childDic setValue:@"1" forKey:@"type1"];
    [childDic setValue:self.appMger.locY forKey:@"lat"];
    [childDic setValue:self.appMger.locX forKey:@"lng"];
    [childDic setValue:self.appMger.userID forKey:@"openid"];
    
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        LogInfo(@"responseDic = %@ ",responseDic);
        
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
            NSMutableArray *orderArray = [[NSMutableArray alloc] initWithCapacity:0];
            NSDictionary *orderDic = [responseDic valueForKey:@"order"];
            [orderArray addObject:[orderDic valueForKey:@"logistics_price"]];
            [orderArray addObject:[orderDic valueForKey:@"expect_time"]];
            [orderArray addObject:[orderDic valueForKey:@"shop_name"]];
            [orderArray addObject:[orderDic valueForKey:@"addr"]];
            [orderArray addObject:[orderDic valueForKey:@"d2"]];
            [self.headerView sendDataArr:orderArray];
            
//            NSDictionary *infoDic = [responseDic valueForKey:@"order"];
            
            [self.infoKeyArr  addObject:[orderDic valueForKey:@"create_time"]];
            [self.infoKeyArr  addObject:[orderDic valueForKey:@"hope_time"]];
            [self.infoKeyArr  addObject:[orderDic valueForKey:@"invoice"]];
            [self.infoKeyArr  addObject:[orderDic valueForKey:@"remark"]];
            
            [self.otherArr  addObject:[orderDic valueForKey:@"update_time"]];
            [self.otherArr  addObject:[orderDic valueForKey:@"get_time"]];
            [self.otherArr  addObject:[orderDic valueForKey:@"end_time"]];
        

            NSArray *listArray = [responseDic valueForKey:@"lists"];
            NSMutableArray *requestArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i = 0; i<[listArray count]; i++)
            {
                OrderDetailMode *listModel = [[OrderDetailMode alloc] init];
                [listModel parseFromDictionary:[listArray objectAtIndex:i]];
                [requestArray addObject:listModel];
            }
//
            [self.detailArr addObjectsFromArray:requestArray];
            
            
            [self.m_grabTableView reloadData];
        }
        else
        {
            NSString *errorMessage = [responseDic valueForKey:@"message"];
            [ShowErrorMgs sendErrorCode:errorMessage withCtr:self];
        }
        
        [self.hubView hideAnimated:YES];
    } FailureBlock:^(id error) {
        NSLog(@"error == %@",error);
        [self.hubView hideAnimated:YES];
        [ShowErrorMgs sendErrorCode:@"服务器错误，请稍后重试！" withCtr:self];
    }];
}

//抢单
- (void)requestQD:(NSString *)sid
{
    
    [self.hubView showAnimated:YES];
    
    //  http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.lists.handleapp&openid=&sid=
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.lists.handleapp" forKey:@"r"];
    [childDic setValue:sid forKey:@"sid"];
    [childDic setValue:self.appMger.userID forKey:@"openid"];
    
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        LogInfo(@"responseDic = %@ ",responseDic);
        
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
            
        }
        else
        {
            NSString *errorMessage = [responseDic valueForKey:@"message"];
            [ShowErrorMgs sendErrorCode:errorMessage withCtr:self];
        }
        
        [self.hubView hideAnimated:YES];
    } FailureBlock:^(id error) {
        NSLog(@"error == %@",error);
        [self.hubView hideAnimated:YES];
        [ShowErrorMgs sendErrorCode:@"服务器错误，请稍后重试！" withCtr:self];
    }];
}


- (void)dealloc {
    if (m_mapView) {
        m_mapView = nil;
    }
    
    if (m_locService) {
        m_locService = nil;
    }
    
    if (m_routesearch) {
        m_routesearch = nil;
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
//    m_mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    m_locService.delegate = self;
     m_routesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    m_mapView.delegate = nil; // 不用时，置nil
    m_locService.delegate = nil;
    m_routesearch.delegate = nil; // 不用时，置nil
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
