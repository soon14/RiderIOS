//
//  PersonalCenterViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/19.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "PersonalCenterTableViewCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

static NSString *const cellIndentifier = @"PersonalCenterTableViewCell";

@interface PersonalCenterViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
     NSMutableArray *listArr;
     UIImagePickerController *m_imagePickerController;
    
}
@property(nonatomic,weak)IBOutlet UITableView *m_personalTaleView;
@property(nonatomic,strong) MBProgressHUD *hubView;
@property(nonatomic,strong) AppContextManager *appMger;
@property(nonatomic,strong) NSString *base64Image;
@property(nonatomic,strong) UIImage *imageData;
@end

@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.appMger = [AppContextManager shareManager];
    
    listArr = [[NSMutableArray alloc]initWithObjects:@"头像",@"工作城市",@"手机号",@"我的银行卡",@"我的二维码",nil];
    
    [self.m_personalTaleView registerNib:[UINib nibWithNibName:@"PersonalCenterTableViewCell" bundle:nil] forCellReuseIdentifier:cellIndentifier];
    self.m_personalTaleView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    m_imagePickerController = [[UIImagePickerController alloc] init];
    m_imagePickerController.delegate = self;
    m_imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    m_imagePickerController.allowsEditing = YES;
    
    self.hubView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hubView];
    self.hubView.label.text = @"头像更新上传中...";
    [self.hubView hideAnimated:YES];
    
    NSData *data = [NSData  dataWithContentsOfURL:[NSURL URLWithString:self.appMger.photo]];
    UIImage *image =  [UIImage imageWithData:data];
    self.imageData = image;

}

#pragma mark - UItableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [listArr count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    //    return 12;//这个方法不写，或者return 0跟return 12的效果一样
    return 0.1f;//把高度设置很小，效果可以看成footer的高度等于0
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalCenterTableViewCell *cell = (PersonalCenterTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (cell == nil)
    {
        cell = [[PersonalCenterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:cellIndentifier];
    }
    
    __weak typeof(self) weakSelf = self;
    cell.showActionSheet = ^{
        [weakSelf showActionSheet];
    };
    [cell setData:listArr[indexPath.row] image:self.imageData phoneNum:self.appMger.userPhone adddr:self.appMger.addr withIndex:indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(indexPath.row == 2)
    {
        [self performSegueWithIdentifier:@"goChangeNumber" sender:nil];
    }
    else if (indexPath.row == 3)
    {
        [self performSegueWithIdentifier:@"goBankCard" sender:nil];
    }
    else if (indexPath.row == 4)
    {
        [self performSegueWithIdentifier:@"goQRCode" sender:nil];
    }
    else
    {
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //    typeStr = @"";
    //    if([segue.identifier isEqualToString:@"PayToCoupon"]){
    //        QQKCouponViewController *couponCtr = segue.destinationViewController;
    //        couponCtr.delegate = self;
    //    }
    
}

- (void)requestUpDataImage:(UIImage *)imaeg
{
    //   http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.set.submitapp&sid=&photo=
    
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.set.submitapp" forKey:@"r"];
    [childDic setValue:self.appMger.riderID forKey:@"sid"];
    [childDic setValue:self.appMger.userID forKey:@"openid"];
    [childDic setValue:self.base64Image forKey:@"photo"];
    
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        LogInfo(@"responseDic = %@ ",responseDic);
        
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
            
            self.imageData = imaeg;

            self.appMger.photo = [[responseDic valueForKey:@"show"] objectAtIndex:0];
            
            if(self.URLBlock){
                self.URLBlock([[responseDic valueForKey:@"show"] objectAtIndex:0]);
            }
            
            [self.m_personalTaleView reloadData];
            
//            [self performSegueWithIdentifier:@"ToExamineHealth" sender:nil];
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


- (IBAction)showActionSheet
{
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectImageFromAlbum];
        
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectImageFromCamera];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [actionSheetController addAction:cameraAction];
    [actionSheetController addAction:albumAction];
    [actionSheetController addAction:cancelAction];
    
    [self presentViewController:actionSheetController animated:YES completion:nil];
}

#pragma mark 从摄像头获取图片或视频
- (void)selectImageFromCamera
{
    m_imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //录制视频时长，默认10s
    //    m_imagePickerController.videoMaximumDuration = 15;
    
    //相机类型（拍照、录像...）字符串需要做相应的类型转换
    //    m_imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage];
    m_imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    //视频上传质量
    //UIImagePickerControllerQualityTypeHigh高清
    //UIImagePickerControllerQualityTypeMedium中等质量
    //UIImagePickerControllerQualityTypeLow低质量
    //UIImagePickerControllerQualityType640x480
    m_imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    
    //设置摄像头模式（拍照，录制视频）为录像模式
    //    m_imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    [self presentViewController:m_imagePickerController animated:NO completion:nil];
}

#pragma mark 从相册获取图片或视频
- (void)selectImageFromAlbum
{
    //NSLog(@"相册");
    m_imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:m_imagePickerController animated:NO completion:nil];
}


#pragma mark UIImagePickerControllerDelegate
//适用获取所有媒体资源，只需判断资源类型
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    //判断资源类型
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        //如果是图片
        //        UIImage *image = info[UIImagePickerControllerEditedImage];
        UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        
        [self.hubView showAnimated:YES];
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            // 处理耗时操作的代码块...
            NSData *data = UIImageJPEGRepresentation(image, 1.0f);
            self.base64Image = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            
            //通知主线程刷新（防止主线程堵塞）
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                
                [self requestUpDataImage:image];
            });
        });
        
//        cameraImageView.image = image;
        //        //压缩图片
        //        NSData *fileData = UIImageJPEGRepresentation(image, 1.0);
        //        //保存图片至相册
        //        UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        //        //上传图片
        //        [self uploadImageWithData:fileData];
        [self.m_personalTaleView reloadData];
    }
    //    else{
    //        //如果是视频
    //        NSURL *url = info[UIImagePickerControllerMediaURL];
    //        //播放视频
    ////        _moviePlayer.contentURL = url;
    ////        [_moviePlayer play];
    //        //保存视频至相册（异步线程）
    //        NSString *urlStr = [url path];
    //
    //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
    //
    //                UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
    //            }
    //        });
    //        NSData *videoData = [NSData dataWithContentsOfURL:url];
    //        //视频上传
    ////        [self uploadVideoWithData:videoData];
    //    }
    [self dismissViewControllerAnimated:NO completion:nil];
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
