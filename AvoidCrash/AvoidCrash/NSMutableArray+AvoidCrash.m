//
//  NSMutableArray+safe.m
//  demo
//
//  Created by Minsol on 2018/12/5.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import "NSMutableArray+AvoidCrash.h"
#import "CrashAvoidConst.h"

@implementation NSMutableArray (AvoidCrash)
+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class __NSArrayM = NSClassFromString(@"__NSArrayM");
        //objectAtIndex:
        [CrashAvoidManager exchangeInstanceMethod:__NSArrayM method1Sel:@selector(objectAtIndex:) method2Sel:@selector(avoidCrashObjectAtIndex:)];
        
        //objectAtIndexedSubscript
        if (AvoidCrashIsiOS(11.0)) {
            [CrashAvoidManager exchangeInstanceMethod:__NSArrayM method1Sel:@selector(objectAtIndexedSubscript:) method2Sel:@selector(avoidCrashObjectAtIndexedSubscript:)];
        }
        
        //setObject:atIndexedSubscript:
        [CrashAvoidManager exchangeInstanceMethod:__NSArrayM method1Sel:@selector(setObject:atIndexedSubscript:) method2Sel:@selector(avoidCrashSetObject:atIndexedSubscript:)];
        
        
        //removeObjectAtIndex:
        [CrashAvoidManager exchangeInstanceMethod:__NSArrayM method1Sel:@selector(removeObjectAtIndex:) method2Sel:@selector(avoidCrashRemoveObjectAtIndex:)];
        
        //insertObject:atIndex:
        [CrashAvoidManager exchangeInstanceMethod:__NSArrayM method1Sel:@selector(insertObject:atIndex:) method2Sel:@selector(avoidCrashInsertObject:atIndex:)];
        
        //getObjects:range:
        [CrashAvoidManager exchangeInstanceMethod:__NSArrayM method1Sel:@selector(getObjects:range:) method2Sel:@selector(avoidCrashGetObjects:range:)];
    
    });
}

//=================================================================
//                    array set object at index
//=================================================================
#pragma mark - get object from array
- (void)avoidCrashSetObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    @try {
        [self avoidCrashSetObject:obj atIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        [CrashAvoidManager noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}


//=================================================================
//                    removeObjectAtIndex:
//=================================================================
#pragma mark - removeObjectAtIndex:

- (void)avoidCrashRemoveObjectAtIndex:(NSUInteger)index {
    @try {
        [self avoidCrashRemoveObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        [CrashAvoidManager noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}


//=================================================================
//                    insertObject:atIndex:
//=================================================================
#pragma mark - set方法
- (void)avoidCrashInsertObject:(id)anObject atIndex:(NSUInteger)index {
    @try {
        [self avoidCrashInsertObject:anObject atIndex:index];
    }
    @catch (NSException *exception) {
        [CrashAvoidManager noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}


//=================================================================
//                           objectAtIndex:
//=================================================================
#pragma mark - objectAtIndex:

- (id)avoidCrashObjectAtIndex:(NSUInteger)index {
    id object = nil;
    
    @try {
        object = [self avoidCrashObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [CrashAvoidManager noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}

//=================================================================
//                     objectAtIndexedSubscript:
//=================================================================
#pragma mark - objectAtIndexedSubscript:
- (id)avoidCrashObjectAtIndexedSubscript:(NSUInteger)idx {
    id object = nil;
    
    @try {
        object = [self avoidCrashObjectAtIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [CrashAvoidManager noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
    
}


//=================================================================
//                         getObjects:range:
//=================================================================
#pragma mark - getObjects:range:

- (void)avoidCrashGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    
    @try {
        [self avoidCrashGetObjects:objects range:range];
    } @catch (NSException *exception) {
        
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [CrashAvoidManager noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        
    }
}

@end
