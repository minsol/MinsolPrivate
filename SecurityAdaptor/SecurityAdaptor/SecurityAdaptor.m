//
//  SecurityAdaptor.m
//  demo
//
//  Created by Minsol on 2018/12/4.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import "SecurityAdaptor.h"
#import "NSString+Hash.h"
#import "NSData+DES.h"
#import "NSData+AES.h"

#define APP_PASSWORDKEY     @""

@implementation SecurityAdaptor

/**
 将二进制数据转为字符串

 @param data 二进制
 @return UTF8编码的字符串
 */
static NSString *convertNSDataToNSString(NSData *data){
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

/**
 将字符串转为二进制数据
 
 @param sting 字符串
 @return 二进制
 */
static NSData *convertNSStringToNSData(NSString *sting){
    NSData *data = [sting dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}

#pragma mark - base64
+ (NSString*)encodeBase64String:(NSString * )input {
    NSData *data = convertNSStringToNSData(input);
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    return base64String;
}

+ (NSString*)decodeBase64String:(NSString * )input {
    NSData *baseData = [[NSData alloc] initWithBase64EncodedString:input options:0];
    return convertNSDataToNSString(baseData);
}

+ (NSString*)encodeBase64Data:(NSData *)data {
    data = [data base64EncodedDataWithOptions:0];
    return convertNSDataToNSString(data);
}

+ (NSString*)decodeBase64Data:(NSData *)data {
    NSData *baseData = [[NSData alloc] initWithBase64EncodedData:data options:0];
    return convertNSDataToNSString(baseData);
}

#pragma mark - MD5 加密
//String转化为md5加密String
+ (NSString *)md5:(NSString *)str{
    return [str md5String];
}

#pragma mark - SHA512加密
//SHA512加密
+ (NSString*)SHA512String:(NSString*)str{
    return [str sha512String];
}


#pragma mark - DES加密、解密
+ (NSData *)encryptDESData:(NSString *)string {
    //将nsstring转化为nsdata
    NSData *data = convertNSStringToNSData(string);
    //使用密码对nsdata进行加密
    NSData *encryptedData = [data DESEncryptWithKey:APP_PASSWORDKEY];
    return encryptedData;
}

+ (NSString *)decryptDESData:(NSData *)data {
    //使用密码对data进行解密
    NSString *decryptJsonString = [data DESDecryptWithKey:APP_PASSWORDKEY];
    return decryptJsonString;
}

#pragma mark - AES加密
//将string转成带密码的data
+(NSData*)encryptAESData:(NSString*)string {
    //将nsstring转化为nsdata
    NSData *data = convertNSStringToNSData(string);
    //使用密码对nsdata进行加密
    NSData *encryptedData = [data AES256EncryptWithKey:APP_PASSWORDKEY];
    return encryptedData;
}

//将带密码的data转成string
+(NSString*)decryptAESData:(NSData*)data {
    //使用密码对data进行解密
    NSData *decryData = [data AES256DecryptWithKey:APP_PASSWORDKEY];
    //将解了密码的nsdata转化为nsstring
    NSString *string = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
    return string;
}

@end
