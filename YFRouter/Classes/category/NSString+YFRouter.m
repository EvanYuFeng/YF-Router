//
//  NSString+YFRouter.m
//  Pods
//
//  Created by 胡玉峰 on 2021/1/11.
//

#import "NSString+YFRouter.h"
#import<CommonCrypto/CommonDigest.h>

@implementation NSString (YFRouter)


/// string to MD5
/// @return  返回md5 后的字符串
- (NSString *)yf_stringToMd5{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    [output appendFormat:@"%02x", digest[i]];
    return  output;
}
@end
