//
//  NavigationAddressTableViewCell.m
//  RiderDemo
//
//  Created by mac on 2018/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "NavigationAddressTableViewCell.h"

@interface NavigationAddressTableViewCell()
{
    IBOutlet UILabel *cityNameLbl;
    IBOutlet UILabel *sizeLbl;
    IBOutlet UIButton *downBtn;
    NSString *btnTag;
    NSString *downLoadState;
}
@end

@implementation NavigationAddressTableViewCell
@synthesize delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
}

- (void)setData:(MapAddressMode *)mode withIndexPath:(NSIndexPath *)path;
{
    cityNameLbl.text = mode.title;
    sizeLbl.text = [self getDataSizeString:mode.dataSize];

    downBtn.hidden = NO;
    
     if ([mode.loadState isEqualToString:@"Loading"])
    {
        [downBtn setTitle:mode.progress forState:UIControlStateNormal];
        [downBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
       downLoadState = @"Loading";
    }
    else if ([mode.loadState isEqualToString:@"Loaded"])
    {
        [downBtn setTitle:@"下载完成" forState:UIControlStateNormal];
        [downBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        downLoadState = @"Loaded";
        downBtn.enabled = NO;
    }
    else
    {
        [downBtn setTitle:@"下载" forState:UIControlStateNormal];
         [downBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        downBtn.enabled = YES;
        downLoadState = @"UnLoad";
    }
    
    btnTag = [NSString stringWithFormat:@"%lu,%lu",path.section,path.row];

}

- (void)setDownData:(BMKOLUpdateElement *)oflineData withIndexPath:(NSIndexPath *)path
{
    
    cityNameLbl.text = oflineData.cityName;
    sizeLbl.text = [self getDataSizeString:oflineData.size];
    btnTag = [NSString stringWithFormat:@"%lu,%lu",path.section,path.row];
    downBtn.hidden = YES;
}

#pragma mark 包大小转换工具类（将包大小转换成合适单位）
-(NSString *)getDataSizeString:(int) nSize
{
    NSString *string = nil;
    if (nSize<1024)
    {
        string = [NSString stringWithFormat:@"%dB", nSize];
    }
    else if (nSize<1048576)
    {
        string = [NSString stringWithFormat:@"%dK", (nSize/1024)];
    }
    else if (nSize<1073741824)
    {
        if ((nSize%1048576)== 0 )
        {
            string = [NSString stringWithFormat:@"%dM", nSize/1048576];
        }
        else
        {
            int decimal = 0; //小数
            NSString* decimalStr = nil;
            decimal = (nSize%1048576);
            decimal /= 1024;
            
            if (decimal < 10)
            {
                decimalStr = [NSString stringWithFormat:@"%d", 0];
            }
            else if (decimal >= 10 && decimal < 100)
            {
                int i = decimal / 10;
                if (i >= 5)
                {
                    decimalStr = [NSString stringWithFormat:@"%d", 1];
                }
                else
                {
                    decimalStr = [NSString stringWithFormat:@"%d", 0];
                }
                
            }
            else if (decimal >= 100 && decimal < 1024)
            {
                int i = decimal / 100;
                if (i >= 5)
                {
                    decimal = i + 1;
                    
                    if (decimal >= 10)
                    {
                        decimal = 9;
                    }
                    
                    decimalStr = [NSString stringWithFormat:@"%d", decimal];
                }
                else
                {
                    decimalStr = [NSString stringWithFormat:@"%d", i];
                }
            }
            
            if (decimalStr == nil || [decimalStr isEqualToString:@""])
            {
                string = [NSString stringWithFormat:@"%dMss", nSize/1048576];
            }
            else
            {
                string = [NSString stringWithFormat:@"%d.%@M", nSize/1048576, decimalStr];
            }
        }
    }
    else    // >1G
    {
        string = [NSString stringWithFormat:@"%dG", nSize/1073741824];
    }
    
    return string;
}



- (IBAction)doDownload
{

    
    if (self.delegate && [self.delegate respondsToSelector:@selector(downBtnTag:withBtnString:)]) {
        [self.delegate downBtnTag:btnTag withBtnString:@""];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
