//
//  UIButton+UserStastics.m
//  EventTracking
//
//  Created by chenbowen on 2017/3/20.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "UIButton+UserStastics.h"
#import "CBWHookUtility.h"
#import "QDUserStastisticsEventsTool.h"
@implementation UIButton (UserStastics)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(sendAction:to:forEvent:);
        SEL swizzledSelector = @selector(swiz_sendAction:to:forEvent:);
        [CBWHookUtility swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
    });
}

#pragma mark - Method Swizzling
- (void)swiz_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;
{
    //插入埋点代码
    [self performUserStastisticsAction:action to:target forEvent:event];
    [self swiz_sendAction:action to:target forEvent:event];
}

- (void)performUserStastisticsAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;
{
//    NSLog(@"n***hook success.n[1]action:%@n[2]target:%@ n[3]event:%ld", NSStringFromSelector(action), target, (long)event);
    
   NSString *eventID = [self controlEventIDAction:action target:target event:event];
    
    [QDUserStastisticsEventsTool event:eventID];
}





- (NSString *)controlEventIDAction:(SEL )action target:(id)target event:(UIEvent *)event{
    
    NSString *actionString = NSStringFromSelector(action);//获取SEL string
    NSString *targetName = NSStringFromClass([target class]);//viewController name
    NSDictionary *configDict = [self dictionaryFromUserStatisticsConfigPlist];
    NSString *eventID = configDict[targetName][@"ControlEventIDs"][actionString];
    
    return eventID;
    
}

- (NSDictionary *)dictionaryFromUserStatisticsConfigPlist
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CBWGlobalUserStatisticsConfig" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return dic;
}
@end
