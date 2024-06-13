//
//  NSMutableArray+Safe.m
//  SparkBase
//
//  Created by 宋时成 on 2024/6/12.
//  Copyright © 2024 Spark. All rights reserved.
//

#import "NSMutableArray+Safe.h"
#import <objc/runtime.h>

@implementation NSMutableArray (Safe)
+ (void)initialize{
    if (self == [NSMutableArray class]) {
        //objectAtIndex
        Method m_objcAtIndex = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(objectAtIndex:));
        Method m_safeObjcAtIndex = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(jk_safeGetObjectAtIndex:));
        method_exchangeImplementations(m_objcAtIndex, m_safeObjcAtIndex);
        
        //[index]
        Method m_quick_objcAtIndex = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(objectAtIndexedSubscript:));
        Method m_quick_safeObjcAtIndex = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(jk_safeGetObjectAtIndexedSubscript:));
        method_exchangeImplementations(m_quick_objcAtIndex, m_quick_safeObjcAtIndex);
        
        //insertObjectAtIndex
        Method m_insetObjcAtIndex = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(insertObject:atIndex:));
        Method m_safeInsertObjectAtIndex = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(jk_safeInsertObject:atIndex:));
        method_exchangeImplementations(m_insetObjcAtIndex, m_safeInsertObjectAtIndex);
        
        //removeObjectAtIndex
        Method m_removeObjcAtIndex = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(removeObjectAtIndex:));
        Method m_safeRemoveObjectAtIndex = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(jk_safeRemoveAtIndex:));
        method_exchangeImplementations(m_removeObjcAtIndex, m_safeRemoveObjectAtIndex);
    }
}

//objectAtIndex:index
- (id)jk_safeGetObjectAtIndex:(NSInteger)index{
    if (index >= self.count || index < 0) {
        NSLog(@"index out of range");
        return nil;
    }
    return [self jk_safeGetObjectAtIndex:index];
}

//[index]
- (id)jk_safeGetObjectAtIndexedSubscript:(NSInteger)index{
    if (index >= self.count || index < 0) {
        NSLog(@"[index] out of range");
        return nil;
    }
    return [self jk_safeGetObjectAtIndexedSubscript: index];
}

//insertObject:objc atIndex:index
- (void)jk_safeInsertObject:(id)object atIndex:(NSInteger)index{
    if (!object) {
        NSLog(@"insertObject is nil");
        return;
    }
    if (index > self.count || index < 0 ) {
        NSLog(@"insertIndex = %ld out of range",(long)index);
        return;
    }
    [self jk_safeInsertObject:object atIndex:index];
}

//removeAtIndex:index
- (void)jk_safeRemoveAtIndex:(NSInteger)index{
    if (self.count <= 0) {
        NSLog(@"array is empty, fail to removeAtIndex:%ld",index);
        return;
    }
    if (index >= self.count || index < 0 ) {
        NSLog(@"fail to remove index = %ld out of range",(long)index);
        return;
    }
    [self jk_safeRemoveAtIndex:index];
}

@end
