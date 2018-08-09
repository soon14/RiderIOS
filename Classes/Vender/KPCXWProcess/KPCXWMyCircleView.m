//
//  MyCircleView.m
//  步骤进度条
//
//  Created by 万俊 on 2017/3/9.
//  Copyright © 2017年 cxw. All rights reserved.
//

#import "KPCXWMyCircleView.h"
#import "UIColor+HEXString.h"

@interface KPCXWMyCircleView ()

@property(nonatomic,strong)UILabel  *statusLabel;

@property(nonatomic,strong)UILabel  *numberLabel;//步骤数值label
@property(nonatomic,assign)BOOL   *isNew;
@end

@implementation KPCXWMyCircleView


-(instancetype)initWithFrame:(CGRect)frame WithProcessStatus:(KPCXWProcessStyle)processStyle AndProcessWidth:(CGFloat)width AndProcessHeight:(CGFloat)height subTitle:(NSArray *)titleArr WithNumberTitle:(NSInteger)numberTitle
{
    if (self =[super initWithFrame:frame])
    {

        [self SetUPUIWithFrame:frame WithProcessStatus:processStyle AndProcessWidth:width AndProcessHeight:height subTitle:titleArr WithTilte:numberTitle];

    
    }
    return self;
}

-(void)setStatus:(NSInteger)status
{
    _status=status;
    
    switch (status)
    {
        case 0://完成
            self.backgroundColor=[UIColor colorWithHexString:@"#14B3F3"];
            self.statusLabel.textColor=[UIColor colorWithHexString:@"#14B3F3"];
            self.statusLabel.hidden=NO;
            self.processView.progress=1;
//            self.isNew=YES;
            [self setNeedsDisplay];
            break;
        case 1:  //进行中
            self.backgroundColor=[UIColor colorWithHexString:@"#108A00"];
            self.statusLabel.textColor=[UIColor colorWithHexString:@"#14B3F3"];
//            self.statusLabel.text=@"进行中";
            self.statusLabel.hidden= NO;
            
            break;
        default:  //还未开始
            self.backgroundColor=[UIColor lightGrayColor];
            self.statusLabel.textColor=[UIColor lightGrayColor];
            self.statusLabel.hidden=NO;
            break;
    }
}


-(void)SetUPUIWithFrame:(CGRect)frame WithProcessStatus:(KPCXWProcessStyle)processStyle AndProcessWidth:(CGFloat)width AndProcessHeight:(CGFloat)height subTitle:(NSArray *)titleArr WithTilte:(NSInteger)numberTitle
{
    NSLog(@"numberTitle == %lu",numberTitle);
    //自身UI
    self.layer.cornerRadius=frame.size.width*0.5;

    self.backgroundColor=[UIColor colorWithHexString:@"#CCCCCC"];
    

//    self.layer.masksToBounds=YES;
    
    self.numberLabel=[[UILabel alloc]initWithFrame:self.bounds];
    self.numberLabel.textColor=[UIColor whiteColor];
    self.numberLabel.font=[UIFont systemFontOfSize:9];
    self.numberLabel.text=[NSString stringWithFormat:@"%ld",(long)numberTitle];
    self.numberLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.numberLabel];
    
    
    //标题label
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(-50+frame.size.width*0.5, frame.size.height+5, 100, 10)];
    
    self.titleLabel.textColor=[UIColor colorWithHexString:@"#727272"];

    self.titleLabel.font=[UIFont systemFontOfSize:9];
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    
    
    
    //状态label
    self.statusLabel=[[UILabel alloc]initWithFrame:CGRectMake(-50+frame.size.width*0.5, CGRectGetMaxY(self.titleLabel.frame)+4, 100, 10)];
    
    self.statusLabel.text=[titleArr objectAtIndex:numberTitle-1];
    self.statusLabel.textColor=[UIColor colorWithHexString:@"108A00"];
    self.statusLabel.font=[UIFont systemFontOfSize:9];
    self.statusLabel.textAlignment=NSTextAlignmentCenter;
    self.statusLabel.hidden=NO;

    
    
    
    [self addSubview:self.statusLabel];
    [self addSubview:self.titleLabel];
    
    
    
    //添加进度条
    self.processView=[[UIProgressView alloc]initWithFrame:CGRectMake(frame.size.width, (frame.size.height-height)*0.5, width, height)];
    self.processView.progressViewStyle=UIProgressViewStyleBar;
    self.processView.progress=0;
    self.processView.tintColor=[UIColor colorWithHexString:@"#14B3F3"];
    self.processView.trackTintColor=[UIColor colorWithHexString:@"#CCCCCC"];
    self.processView.progressViewStyle=UIProgressViewStyleBar;
    
    [self addSubview:self.processView];
    
    self.ProcessLabel=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width+(width-30)*0.5, CGRectGetMaxY(self.processView.frame)+2, 30, 10)];
    
    self.ProcessLabel.textColor=[UIColor redColor];
    self.ProcessLabel.font=[UIFont systemFontOfSize:10];
    self.ProcessLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.ProcessLabel];
    
}

//-(void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    /**
//     
//     画实心圆
//     */
//    //填充当前绘画区域内的颜色
//    [[UIColor whiteColor] set];
//    //填充当前矩形区域
//    CGContextFillRect(ctx, rect);
//    //以矩形frame为依据画一个圆
//    CGContextAddEllipseInRect(ctx, rect);
//    //填充当前绘画区域内的颜色
//    [[UIColor colorWithHexString:@"#CCCCCC"] set];
//    if (self.isNew)
//    {
//        [[UIColor colorWithHexString:@"#14B3F3"] set];
//    }
//    //填充(沿着矩形内围填充出指定大小的圆)
//    CGContextFillPath(ctx);
//    
//}


@end
