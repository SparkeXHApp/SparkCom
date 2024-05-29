//
//  NSArray+ErrorHandle.m
//  SparkBase
//
//  Created by apple on 2021/3/8.
//  Copyright © 2021 Spark. All rights reserved.
//

#import "NSArray+ErrorHandle.h"

@implementation NSArray (ErrorHandle)

/**
 *  防止数组越界
 */
- (id)objectAtIndexVerify:(NSUInteger)index{
    if (index < self.count) {
        return [self objectAtIndex:index];
    }else{
        return nil;
    }
}
/**
 *  防止数组越界
 */
- (id)objectAtIndexedSubscriptVerify:(NSUInteger)idx{
    if (idx < self.count) {
        return [self objectAtIndexedSubscript:idx];
    }else{
        return nil;
    }
}

@end
