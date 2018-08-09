//
//  KPCXWProcessView.m
//  步骤进度条
//
//  Created by 万俊 on 2017/3/10.
//  Copyright © 2017年 cxw. All rights reserved.
//

#import "KPCXWProcessView.h"
#import "UIColor+HEXString.h"

@implementation KPCXWProcessView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame])
    {
        self.progressViewStyle=UIProgressViewStyleBar;
        self.progress=1;
        self.tintColor=[UIColor colorWithHexString:@"#14B3F3"];
        self.trackTintColor=[UIColor colorWithHexString:@"#14B3F3"];
        self.progressViewStyle=UIProgressViewStyleBar;
    }
    return self;
}

@end
