//
//  HealthCertificateViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/11.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "HealthCertificateViewController.h"
#import "ExamineHealthViewController.h"

@interface HealthCertificateViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSString *dateStr;
    UIImagePickerController *m_imagePickerController;
    UIImage *txImage;
    NSString *base64Image;
  
}
@property(nonatomic,weak)IBOutlet UIDatePicker *datePicker;
@property(nonatomic,weak)IBOutlet UIView *timeView;
@property(nonatomic,weak)IBOutlet UILabel *timeLbl;
@property(nonatomic,weak)IBOutlet UIImageView *arrowImage;
@property(nonatomic,weak)IBOutlet UIView *datePicView;
@property(nonatomic,weak)IBOutlet UIImageView *uploadImageView;
@property(nonatomic,strong) MBProgressHUD *hubView;
@property(nonatomic,strong) AppContextManager *appMger;

@end

@implementation HealthCertificateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    base64Image = @"";
    self.datePicView.hidden = YES;
    self.timeLbl.hidden = YES;
    self.arrowImage.hidden = NO;
    [self.datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage)];
    [self.uploadImageView addGestureRecognizer:tapGesture];
    self.uploadImageView.userInteractionEnabled = YES;
    
    m_imagePickerController = [[UIImagePickerController alloc] init];
    m_imagePickerController.delegate = self;
    m_imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    m_imagePickerController.allowsEditing = YES;
    
    self.appMger = [AppContextManager shareManager];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *datenow = [NSDate date];
    NSString *nowtimeStr = [formatter stringFromDate:datenow];
//    self.timeLbl.text = nowtimeStr;
    dateStr = nowtimeStr;
    
    self.hubView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hubView];
    self.hubView.label.text = @"上传中...";
    [self.hubView hideAnimated:YES];
}

- (void)dateChange:(UIDatePicker *)datePicker {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置时间格式
    formatter.dateFormat = @"yyyy-MM-dd";
    dateStr = [formatter  stringFromDate:datePicker.date];
}

- (IBAction)showDateView:(id)sender {
    self.datePicView.hidden = NO;
    
}

- (IBAction)cancelPress:(id)sender {
    self.datePicView.hidden = YES;
    if ([dateStr isEqualToString:@""]) {
        dateStr = @"";
        self.timeLbl.hidden = YES;
    }

}

- (IBAction)confirmPress:(id)sender {
    
    if ([dateStr isEqualToString:@""]) {
        self.timeLbl.text = dateStr;
    }
    
    self.timeLbl.hidden = NO;
    self.arrowImage.hidden = NO;
    self.timeLbl.text = dateStr;
    self.datePicView.hidden = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([touch view] == self.view)
    {
         self.datePicView.hidden = YES;
    }

}

- (IBAction)submit:(id)sender {
    self.datePicView.hidden = YES;
    
    [self.hubView showAnimated:YES];
    
    NSData *data = UIImageJPEGRepresentation(txImage, 1.0f);
    base64Image = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    
    if (self.timeLbl.hidden)
    {
        [self.hubView hideAnimated:YES];
        [ShowErrorMgs sendErrorCode:@"发证日期不能为空" withCtr:self];
        
    }
    else if (data.bytes==0) {
        [self.hubView hideAnimated:YES];
        [ShowErrorMgs sendErrorCode:@"健康证不能为空" withCtr:self];
    }
    else
    {
        [self requestUploadImage];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"ToExamineHealth"]){
        ExamineHealthViewController *examineCtr = segue.destinationViewController;
        examineCtr.status = 1;
//        examineCtr.imgUrl = self.imageUrl;
    }
}

- (void)requestUploadImage
{
//    http://www.pujiante.cn/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile&r=app.delivery.health.submitapp&sid=&photo_time=&photo=
    
    NSMutableDictionary *childDic = [[NSMutableDictionary alloc]init];
    [childDic setValue:@"3" forKey:@"i"];
    [childDic setValue:@"entry" forKey:@"c"];
    [childDic setValue:@"ewei_shopv2" forKey:@"m"];
    [childDic setValue:@"mobile" forKey:@"do"];
    [childDic setValue:@"app.delivery.health.submitapp" forKey:@"r"];
    [childDic setValue:self.appMger.riderID forKey:@"sid"];
    [childDic setValue:dateStr forKey:@"photo_time"];
    [childDic setValue:base64Image forKey:@"photo"];
    
    [AFHttpRequestManagement PostHttpDataWithUrlStr:@"" Dic:childDic SuccessBlock:^(id responseObject) {
        
        SBJsonParser *json = [[SBJsonParser alloc]init];
        NSDictionary *responseDic = [json objectWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        LogInfo(@"responseDic = %@ ",responseDic);
        
        int errorCode = [[responseDic valueForKey:@"error"] intValue];
        if (errorCode == 0)
        {
           
            [self performSegueWithIdentifier:@"ToExamineHealth" sender:nil];
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

- (void)clickImage
{
     self.datePicView.hidden = YES;
    [self showActionSheet];
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
        self.uploadImageView.image = image;
        txImage = image;
        
        //        //压缩图片
        //        NSData *fileData = UIImageJPEGRepresentation(image, 1.0);
        //        //保存图片至相册
        //        UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        //        //上传图片
        //        [self uploadImageWithData:fileData];
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
