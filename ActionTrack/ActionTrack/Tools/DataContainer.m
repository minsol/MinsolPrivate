//
//  DataContainer.m
//  demo
//
//  Created by Minsol on 2018/12/19.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import "DataContainer.h"

@interface DataContainer ()

@property(nonatomic,strong)NSDictionary * data;

@end

@implementation DataContainer


+(instancetype)dataInstance
{
    static DataContainer * instacne = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instacne = [DataContainer new];
        
//        NSString *configPath = [[NSBundle mainBundle] pathForResource:@"InfoDic" ofType:@"plist"];
//        NSDictionary *dataDic = [NSDictionary dictionaryWithContentsOfFile:configPath];
//        instacne.data = dataDic;
        NSString * path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"json"];
        NSData * JSONData = [NSData dataWithContentsOfFile:path];
        instacne.data = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    });
    return instacne;
}



/**
 处理点击事件

 @param target 事件target
 @param key 事件Key
 @param identifier 事件identifier
 */
-(void)handWithTargetKey:(id)target Key:(NSString *)key Identifier:(NSString *)identifier{
    NSDictionary * dic = [[[DataContainer dataInstance].data objectForKey:key] objectForKey:identifier];
    if (dic) {
        
        NSString * eventid = dic[@"userDefined"][@"eventid"];
        NSString * targetname = dic[@"userDefined"][@"target"];
        NSString * pageid = dic[@"userDefined"][@"pageid"];
        NSString * pagename = dic[@"userDefined"][@"pagename"];
        NSDictionary * pagePara = dic[@"pagePara"];
        __block NSMutableDictionary * uploadDic = [NSMutableDictionary dictionaryWithCapacity:0];
        [pagePara enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            id value = [self captureVarforInstance:target varName:obj[@"propertyName"]];
            if (value && key) {
                [uploadDic setObject:value forKey:key];
            }
        }];
        
        
        NSLog(@"\n event id === %@,\n  target === %@, \n  pageid === %@,\n  pagename === %@,\n pagepara === %@ \n", eventid, targetname, pageid, pagename, uploadDic);
        
    }
}


/**
 遍历查找需要的属性

 @param instance instance
 @param varName 属性名
 @return value
 */
-(id)captureVarforInstance:(id)instance varName:(NSString *)varName{
    id value = [self avoidCrash:instance valueForKey:varName];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([instance class], &count);
    if (!value) {
        NSMutableArray * varNameArray = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < count; i++) {
            objc_property_t property = properties[i];
            NSString* propertyAttributes = [NSString stringWithUTF8String:property_getAttributes(property)];
            NSArray* splitPropertyAttributes = [propertyAttributes componentsSeparatedByString:@"\""];
            if (splitPropertyAttributes.count < 2) {
                continue;
            }
            NSString * className = [splitPropertyAttributes objectAtIndex:1];
            Class cls = NSClassFromString(className);
            NSBundle *bundle2 = [NSBundle bundleForClass:cls];
            if (bundle2 == [NSBundle mainBundle]) {
                const char * name = property_getName(property);
                NSLog(@"自定义的类 ======%@====%s", className,name);
                NSString * varname = [[NSString alloc] initWithCString:name encoding:NSUTF8StringEncoding];
                [varNameArray addObject:varname];
            } else {
                const char * name = property_getName(property);
                NSLog(@"系统的类 ======%@====%s",className,name);
            }
        }
        for (NSString * name in varNameArray) {
            id newValue = [self avoidCrash:instance valueForKey:name];
            if (newValue) {
                value = [self avoidCrash:instance valueForKey:varName];
                if (value) {
                    return value;
                }else{
                    value = [self captureVarforInstance:newValue varName:varName];
                }
            }
        }
    }
    return value;
}


/**
 处理 valueForUndefinedKey 异常

 @param instance instance
 @param key key
 @return value
 */
-(id)avoidCrash:(id)instance valueForKey:(NSString *)key{
    id value = nil;
    @try {
        value = [instance valueForKey:key];
    }
    @catch (NSException *exception) {
        NSLog(@"exception.debugDescription %@",exception.debugDescription);
    }
    @finally {
        return value;
    }
}

@end
