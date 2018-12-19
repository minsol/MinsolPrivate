//
//  DataContainer.h
//  demo
//
//  Created by Minsol on 2018/12/19.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface DataContainer : NSObject

+(instancetype)dataInstance;

/**
 处理点击事件
 
 @param target 事件target
 @param key 事件Key
 @param identifier 事件identifier
 */
-(void)handWithTargetKey:(id)target Key:(NSString *)key Identifier:(NSString *)identifier;

@end
