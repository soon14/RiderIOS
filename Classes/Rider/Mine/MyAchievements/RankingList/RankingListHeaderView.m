//
//  RankingListHeaderView.m
//  RiderDemo
//
//  Created by mac on 2018/2/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RankingListHeaderView.h"

static RankingListHeaderView *defaultView;

@interface RankingListHeaderView()
{
    IBOutlet UIImageView *firstImageView;
    IBOutlet UIImageView *secondImageView;
    IBOutlet UIImageView *thirdImageView;
}
@end

@implementation RankingListHeaderView

+ (id)defaultView{
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"RankingListHeaderView" owner:nil options:nil];
    defaultView = [nibView firstObject];
    
    return defaultView;
}

- (void)sendData:(NSMutableArray *)titleArr withImage:(NSMutableArray *)imageArr
{
//    firstImageView.layer.cornerRadius = firstImageView.frame.size.width/2;
//    firstImageView.image = [UIImage imageNamed:@"testHeard"];
//    
//    secondImageView.layer.cornerRadius = secondImageView.frame.size.width/2;
//    secondImageView.image = [UIImage imageNamed:@"testHeard"];
//    
//    thirdImageView.layer.cornerRadius = thirdImageView.frame.size.width/2;
//    thirdImageView.image = [UIImage imageNamed:@"testHeard"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
