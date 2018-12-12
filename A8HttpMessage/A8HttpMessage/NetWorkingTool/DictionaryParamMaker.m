//
//  DictionaryParamMaker.m
//  demo
//
//  Created by Minsol on 2018/12/12.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import "DictionaryParamMaker.h"
#import "NSDictionary+AddParams.h"

@implementation DictionaryParamMaker

- (instancetype)initDictionary:(NSDictionary*)dicTionary{
    self = [super init];
    if (self) {
        self.paramDictionary = [NSMutableDictionary dictionaryWithDictionary:dicTionary];
    }
    return self;
}

#pragma mark - Chaining
- (AddParamSetBlock)addParam{
    return ^DictionaryParamMaker *(NSString *key, id object) {
        [self.paramDictionary addParam:object forKey:key];
        return self;
    };
}


@end
