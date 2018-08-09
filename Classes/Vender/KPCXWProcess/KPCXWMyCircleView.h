//
//  MyCircleView.h
//  步骤进度条
//
//  Created by 万俊 on 2017/3/9.
//  Copyright © 2017年 cxw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KPCXWProcessStyle) {
    KPCXWProcessStyleDefault,     // normal progress bar
    KPCXWProcessStyleShort __TVOS_PROHIBITED,     // for use in a toolbar
};



@interface KPCXWMyCircleView : UIView



@property(nonatomic,strong)UILabel  *titleLabel;//标题label 前端 测试 上线

@property(nonatomic,assign)NSInteger   status;//该进度的状态


@property(nonatomic,strong)UIProgressView  *processView;//进度条

@property(nonatomic,strong)UILabel  *ProcessLabel;//进度百分数值


//根据进度圆圈的frame 和进度条的类型（正常还是结束短的）还有进度条的长度和高度
-(instancetype)initWithFrame:(CGRect)frame WithProcessStatus:(KPCXWProcessStyle)processStyle AndProcessWidth:(CGFloat)width AndProcessHeight:(CGFloat)height subTitle:(NSArray *)titleArr WithNumberTitle:(NSInteger)numberTitle;

@end
