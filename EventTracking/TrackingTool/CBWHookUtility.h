//
//  CBWHookUtility.h
//  EventTracking
//
//  Created by chenbowen on 2017/3/20.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBWHookUtility : NSObject
+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;
@end
