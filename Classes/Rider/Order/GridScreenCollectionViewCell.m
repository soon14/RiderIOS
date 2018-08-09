//
//  GridScreenCollectionViewCell.m
//  RiderIOS
//
//  Created by Han on 2018/6/7.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "GridScreenCollectionViewCell.h"

@interface GridScreenCollectionViewCell()
{
    
}
@property(nonatomic,strong)IBOutlet UILabel *monthLbl;
@end

@implementation GridScreenCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(NSString *)month withIndex:(NSInteger)index
{
    self.monthLbl.text = month;
    if (self.indexRow == index) {
        self.backgroundColor = [UIColor colorWithHexString:@"2196d9"];
        self.monthLbl.textColor = [UIColor whiteColor];
    }
    else
    {
        
        self.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        self.monthLbl.textColor = [UIColor blackColor];
    }
}

@end
