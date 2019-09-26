//
//  NSString+EncoderTransfrom.m
//  test
//
//  Created by Minsol on 2019/9/26.
//  Copyright © 2019 Mvm. All rights reserved.
//

#import "NSString+EncoderTransfrom.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (EncoderTransfrom)

-(NSString *)urlEncodeString{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //    [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    //    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    //    [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
}

-(NSString *)base64String{
    //1、先转换成二进制数据
    //2、对二进制数据进行base64编码，完成后返回字符串
    return [self.utfData base64EncodedStringWithOptions:0];
}

-(NSString *)deBase64String{
    //注意：该字符串是base64编码后的字符串
    //1、转换为二进制数据（完成了解码的过程）
    NSData *data=[[NSData alloc]initWithBase64EncodedString:self options:0];
    //2、把二进制数据转换成字符串
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

-(NSString *)unicodeString{
    NSUInteger length = [self length];
    NSMutableString *str = [NSMutableString stringWithCapacity:0];
    for (int i = 0;i < length; i++){
        NSMutableString *s = [NSMutableString stringWithCapacity:0];
        unichar _char = [self characterAtIndex:i];
        // 判断是否为英文和数字
        if (_char <= '9' && _char >='0'){
            [s appendFormat:@"%@",[self substringWithRange:NSMakeRange(i,1)]];
        }else if(_char >='a' && _char <= 'z'){
            [s appendFormat:@"%@",[self substringWithRange:NSMakeRange(i,1)]];
        }else if(_char >='A' && _char <= 'Z')
        {
            [s appendFormat:@"%@",[self substringWithRange:NSMakeRange(i,1)]];
        }else{
            // 中文和字符
            [s appendFormat:@"\\u%x",[self characterAtIndex:i]];
            // 不足位数补0 否则解码不成功
            if(s.length == 4) {
                [s insertString:@"00" atIndex:2];
            } else if (s.length == 5) {
                [s insertString:@"0" atIndex:2];
            }
        }
        [str appendFormat:@"%@", s];
    }
    return str;
}

-(NSString *)deUnicodeString{
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    //tempStr3现在的值为  @"\"\\ue670\""
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    //通过NSPropertyListSerialization将NSData数据对象归档提取成String，这时候的returnStr就是 @"\ue670"了
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

-(NSString *)md5Of32BitString{
    //传入参数,转化成char
    const char * str = [self UTF8String];
    //开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    unsigned char md[CC_MD5_DIGEST_LENGTH];
    /*
     extern unsigned char * CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     把str字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了md这个空间中
     */
    CC_MD5(str, (int)strlen(str), md);
    //创建一个可变字符串收集结果
    NSMutableString * ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        /**
         X 表示以十六进制形式输入/输出
         02 表示不足两位，前面补0输出；出过两位不影响
         printf("%02X", 0x123); //打印出：123
         printf("%02X", 0x1); //打印出：01
         */
        [ret appendFormat:@"%02X",md[i]];
    }
    //返回一个长度为32的字符串
    return ret;
}

-(NSString *)md5Of16BitString{
    NSString *md5Str = self.md5Of32BitString;
    NSString *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}

-(NSData *)utfData{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSData *)hexData{
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= self.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [self substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}


-(NSData *)byteData{
    Byte bytes[4];
    for (int i = 0; i < 4; i++) {
        bytes[i] = (Byte) ((self.intValue >> INT32_C(8 * i)) & 0xFF);
    }
    NSData *data = [NSData dataWithBytes:bytes length:4];
    return data;
}

@end

@implementation NSData (EncoderTransfrom)

- (NSString *)utfString{
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

- (NSString *)hexString{
    Byte *bytes = (Byte *)[self bytes];
    NSString *hexStr=@"";
    for(int i=0;i<[self length];i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff]; ///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

- (NSString *)decimalString{
    Byte *bytes = (Byte *)[self bytes];
    int intValue = 0;
    for (int i = 0; i < [self length]; i++){
        intValue += (bytes[i] & 0xFF) << (8 * (i));
    }
    return [NSString stringWithFormat:@"%d",intValue];
}

@end

