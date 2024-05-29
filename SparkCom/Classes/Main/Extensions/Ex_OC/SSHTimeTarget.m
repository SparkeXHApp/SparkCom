//
//  SSHTimeTarget.m
//  自释放Test
//
//  Created by 海神 on 16/6/2.
//  Copyright © 2016年 海神. All rights reserved.
//

#import "SSHTimeTarget.h"
#import <objc/message.h>

@interface SSHTimeTarget()
@property (nonatomic, weak) NSTimer* timer;
@end
@implementation SSHTimeTarget
- (void)fire:(NSTimer *)timer {
    [self _timerBlockInvoke:timer.block];
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats
                                      block:(TimeBlock)block{
    SSHTimeTarget* timerTarget = [[SSHTimeTarget alloc] init];
    timerTarget.timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                         target:timerTarget
                                                       selector:@selector(fire:)
                                                       userInfo:userInfo
                                                        repeats:repeats];
    timerTarget.timer.block = block;
    return timerTarget.timer;
}

- (void)_timerBlockInvoke:(TimeBlock)block{
    if (block) {
        id userInfo = self.timer.userInfo;
        block(userInfo);
    }
}

- (void)dealloc
{
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
    NSLog(@"%s", __func__);
}

@end


@implementation NSTimer(Block)
@dynamic block;

- (TimeBlock)block{
    TimeBlock block = objc_getAssociatedObject(self, @"timeBlock");
    return block;
}

- (void)setBlock:(TimeBlock)block{
    objc_setAssociatedObject(self, @"timeBlock", block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end