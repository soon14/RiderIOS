//
//  GridScreenCollectionViewCell.h
//  RiderIOS
//
//  Created by Han on 2018/6/7.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridScreenCollectionViewCell : UICollectionViewCell

@property (nonatomic,assign) NSInteger indexRow;

- (void)setData:(NSString *)month withIndex:(NSInteger)index;

@end
