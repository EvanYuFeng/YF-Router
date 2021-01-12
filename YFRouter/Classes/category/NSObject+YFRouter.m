//
//  NSObject+YFRouter.m
//  Pods
//
//  Created by 胡玉峰 on 2021/1/11.
//

#import "NSObject+YFRouter.h"

@implementation NSObject (YFRouter)


-(YFRouterSlotData *)yf_routerSoletData{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setYf_routerSoletData:(YFRouterSlotData * _Nonnull)yf_routerSoletData;{
    objc_setAssociatedObject(self, @selector(yf_routerSoletData), yf_routerSoletData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
