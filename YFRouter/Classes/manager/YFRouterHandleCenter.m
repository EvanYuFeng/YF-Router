//
//  YFRouterHandleCenter.m
//  YFRouter
//
//  Created by 胡玉峰 on 2021/1/12.
//  回调时间管理中心

#import "YFRouterHandleCenter.h"
#import "YFRouterConstants.h"


@implementation YFRouterHandleCenter


-(void)registerHanleWithRouterCode:(NSString * _Nonnull )routerCode andHandle:(YFRouterHandleBlock)handleBlock{
//    检测routercode是否合法
    if (![self checkRouterCodeIsLegal:routerCode]) return YFLog(@"illegal routerCode be use !!!!");
//    不存在开始注册
    if (![self checkHandleIsExist:routerCode])  self.yf_handleData[routerCode] = [handleBlock copy];
}

-(void)removeHandleWithRouterCode:(NSString * _Nonnull )routerCode{
    if (![self checkRouterCodeIsLegal:routerCode]) return YFLog(@"illegal routerCode be use !!!!");
    if ([self checkHandleIsExist:routerCode]) [self.yf_handleData removeObjectForKey:routerCode];
}

-(_Nullable YFRouterHandleBlock)getHandleBlockWithRouterCode:(NSString * _Nonnull)routerCode{
    if (![self checkRouterCodeIsLegal:routerCode]) {
        YFLog(@"illegal routerCode be use !!!!");
        return nil;
    }
    return self.yf_handleData[routerCode];
}


#pragma mark private-method
-(BOOL)checkRouterCodeIsLegal:(NSString *)routerCode{
    if (!routerCode || routerCode.length != KKYFRouterCodelength)return NO;
    return YES;
}
-(BOOL)checkHandleIsExist:(NSString * _Nonnull)routerCode{
    if (!self.yf_handleData[routerCode]) return NO;
    return YES;
}

#pragma mark layz load
- (NSMutableDictionary *)yf_handleData{
    if (!_yf_handleData) {
        _yf_handleData = [[NSMutableDictionary alloc]init];
    }
    return _yf_handleData;
}

@end
