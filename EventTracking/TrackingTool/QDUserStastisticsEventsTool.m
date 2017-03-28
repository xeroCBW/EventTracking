//
//  QDUserStastisticsEventsTool.m
//  Ewallet
//
//  Created by Kk Yuen on 16/8/5.
//  Copyright © 2016年 UCSMY. All rights reserved.
//

#import "QDUserStastisticsEventsTool.h"
//#import "UMMobClick/MobClick.h"

@implementation QDUserStastisticsEventsTool

+ (void)beginLogPageView:(NSString *)pageName{
    
//    [MobClick beginLogPageView:pageName];
    
    NSLog(@"开始统计%@",pageName);
    
}

+ (void)endLogPageView:(NSString *)pageName{
    
     NSLog(@"结束统计%@",pageName);
    
//    [MobClick endLogPageView:pageName];
}

+ (void)event:(NSString *)eventId{
    
//    [MobClick event:eventId];
    
    NSLog(@"按钮点击事件---- %@",eventId);
    
}

@end
