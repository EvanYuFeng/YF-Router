//
//  NSObject+YFRouter.m
//  Pods
//
//  Created by 胡玉峰 on 2021/1/11.
//

#import "NSObject+YFRouter.h"

@implementation NSObject (YFRouter)


-(NSString *)yf_routerCode{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setYf_routerCode:(NSString *)routerCode{
    objc_setAssociatedObject(self, @selector(yf_routerCode), routerCode, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
