//
//  UIViewController+UserStastistics.m
//  EventTracking
//
//  Created by chenbowen on 2017/3/20.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "UIViewController+UserStastistics.h"
#import "CBWHookUtility.h"
#import "QDUserStastisticsEventsTool.h"

@implementation UIViewController (UserStastistics)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(swiz_viewWillAppear:);
        [CBWHookUtility swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
        
        SEL originalSelector1 = @selector(viewWillDisappear:);
        SEL swizzledSelector1 = @selector(swiz_viewWillDisappear:);
        [CBWHookUtility swizzlingInClass:[self class] originalSelector:originalSelector1 swizzledSelector:swizzledSelector1];
    });
}
#pragma mark - Method Swizzling
- (void)swiz_viewWillAppear:(BOOL)animated
{
    //插入需要执行的代码
//    NSLog(@"我在viewWillAppear执行前偷偷插入了一段代码");
    //不能干扰原来的代码流程，插入代码结束后要让本来该执行的代码继续执行
     [QDUserStastisticsEventsTool beginLogPageView:[self pageEventID:YES]];

    [self swiz_viewWillAppear:animated];
}

- (void)swiz_viewWillDisappear:(BOOL)animated
{
   
    [QDUserStastisticsEventsTool endLogPageView:[self pageEventID:NO]];
//    NSLog(@"我在viewDidDisappear执行前偷偷插入了一段代码");
     [self swiz_viewWillDisappear:animated];
}


#pragma mark - Event Tracking

- (NSString *)pageEventID:(BOOL)bEnterPage
{
    NSDictionary *configDict = [self dictionaryFromUserStatisticsConfigPlist];
    NSString *selfClassName = NSStringFromClass([self class]);
    return configDict[selfClassName][@"PageEventIDs"][bEnterPage ? @"Enter" : @"Leave"];
}

- (NSDictionary *)dictionaryFromUserStatisticsConfigPlist
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CBWGlobalUserStatisticsConfig" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return dic;
}

@end
