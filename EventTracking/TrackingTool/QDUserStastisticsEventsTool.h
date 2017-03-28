//
//  QDUserStastisticsEventsTool.h
//  Ewallet
//
//  Created by Kk Yuen on 16/8/5.
//  Copyright © 2016年 UCSMY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDUserStastisticsEventsTool : NSObject

/** 进入页面统计*/
+ (void)beginLogPageView:(NSString *)pageName;
/** 离开页面统计*/
+ (void)endLogPageView:(NSString *)pageName;
/** 点击事件统计*/
+ (void)event:(NSString *)eventId;

@end
