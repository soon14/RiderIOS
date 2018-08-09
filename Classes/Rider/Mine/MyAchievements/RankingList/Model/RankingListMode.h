//
//  RankingListMode.h
//  RiderDemo
//
//  Created by mac on 2018/2/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicModel.h"

@interface RankingListMode : BasicModel
{
    NSString *ranking;
    NSString *distance;
    UIImageView *rankImage;
    NSString *name;
    NSString *num;
}
@property(nonatomic,strong)NSString *ranking;
@property(nonatomic,strong)NSString *distance;
@property(nonatomic,strong)UIImageView *rankImage;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *num;
@end
