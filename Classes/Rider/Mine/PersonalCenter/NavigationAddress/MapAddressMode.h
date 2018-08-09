//
//  MapAddressMode.h
//  RiderDemo
//
//  Created by mac on 2018/1/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapAddressMode : NSObject
{
    int cityID;   //城市ID
    NSString *title;      //城市名称 标题
    int dataSize;   //下载包大小
    NSString *progress;     //下载进度
    NSString *loadState; //下载状态
}
@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)int dataSize;
@property(nonatomic,strong)NSString *progress;
@property(nonatomic,strong)NSString *loadState;
@property(nonatomic,assign)int cityID;
@end
