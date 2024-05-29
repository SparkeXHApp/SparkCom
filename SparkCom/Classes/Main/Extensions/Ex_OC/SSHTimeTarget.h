//
//  SSHTimeTarget.h
//  自释放Test
//
//  Created by 海神 on 16/6/2.
//  Copyright © 2016年 海神. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TimeBlock)(id userinfo);

@interface SSHTimeTarget : NSObject
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats
                                      block:(void(^)(id userInfo))block;
@end

@interface NSTimer (Block)

@property (nonatomic, copy) TimeBlock block;

@end
