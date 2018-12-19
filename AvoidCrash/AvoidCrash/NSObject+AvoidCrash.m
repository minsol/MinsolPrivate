//
//  NSObject+avoid.m
//  demo
//
//  Created by Minsol on 2018/12/5.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import "NSObject+AvoidCrash.h"
#import "CrashAvoidConst.h"

@implementation NSObject (AvoidCrash)
+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        //valueForKey:
        Class anClass = [self class];
        SEL method1Sel = @selector(valueForKey:);
        SEL method2Sel = @selector(safe_valueForKey:);

        [CrashAvoidManager exchangeInstanceMethod:anClass method1Sel:method1Sel method2Sel:method2Sel];
    });
}


-(id)safe_valueForKey:(NSString *)key
{
    id object = nil;
    
    @try {
        object = [self safe_valueForKey:key];
    }
    @catch (NSException *exception) {
        [CrashAvoidManager noteErrorWithException:exception defaultToDo:@""];
//        NSLog(@"exception.debugDescription %@",exception.debugDescription);
    }
    @finally {
        return object;
    }
}
@end
