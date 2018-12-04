//
//  NSData+DES.h
//  demo
//
//  Created by Minsol on 2018/12/4.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (DES)

- (NSData *)DESEncryptWithKey:(NSString *)key;
- (NSString *)DESDecryptWithKey:(NSString *)key;

@end
