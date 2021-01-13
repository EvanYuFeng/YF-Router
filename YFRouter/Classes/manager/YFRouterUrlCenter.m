//
//  YFRouterUrlCenter.m
//  YFRouter
//
//  Created by 胡玉峰 on 2021/1/13.
//

#import "YFRouterUrlCenter.h"
#import "YFRouterConstants.h"

@implementation YFRouterUrlCenter


-(BOOL)yf_registereUrl:(NSString * _Nonnull )clsUrl toClsName:(NSString * _Nonnull)clsName{
    if (self.yf_urlData[clsUrl] && ((NSString *)self.yf_urlData[clsUrl]).length > 0) {
        YFLog(@"you are trying to register url 《%@》,but it has been registe ,please check!!!",clsUrl);
        return NO;
    }
    self.yf_urlData[clsUrl] = clsName;
    return YES;
}

-(NSString * _Nullable)yf_getClsNameWithUrl:(NSString * _Nonnull)clsUrl{
    return  self.yf_urlData[clsUrl];
}

- (NSMutableDictionary *)yf_urlData{
    if (!_yf_urlData) {
        _yf_urlData = [NSMutableDictionary new];
    }
    return _yf_urlData;
}
@end
