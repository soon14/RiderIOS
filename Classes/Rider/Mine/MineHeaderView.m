//
//  MineHeaderView.m
//  RiderIOS
//
//  Created by Han on 2018/6/8.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "MineHeaderView.h"
#import "UIImageView+WebCache.h"

static MineHeaderView *defaultView;

@interface MineHeaderView()
{
    
}
@property(nonatomic,weak)IBOutlet UIImageView *txImage;
@end

@implementation MineHeaderView

+ (id)defaultView{
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"MineHeaderView" owner:nil options:nil];
    defaultView = [nibView firstObject];
    
    return defaultView;
}

- (void)setTXImage:(NSString *)imgUrl
{
//     [self.txImage sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    
    self.txImage.clipsToBounds = YES;
    [self.self.txImage sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

        NSLog(@"错误信息:%@",error);
        
    }];
}

- (IBAction)buttonClick:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if (self.didHeaderButton) {
        self.didHeaderButton((int)btn.tag-110);
    }
   
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
