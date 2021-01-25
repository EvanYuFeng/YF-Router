//
//  YFRouterSlotDate.m
//  YFRouter
//
//  Created by 胡玉峰 on 2021/1/12.
//  插槽配置信息

#import "YFRouterSlotData.h"
#import "YFRouterConstants.h"
#import "YFRouterManager.h"
@class YFRouterManager;

@implementation YFRouterSlotData

-(instancetype)initWithClsName:(NSString *)clsName andRouterCode:(NSString *)routerCode andParams:(_Nullable id)params{
    if (self = [super init]) {
        _clsName = clsName;
        _routerCode = routerCode;
        _params = params;
    }
    return self;
}

-(void)dealloc{
    [YFRouterGlobleInstance performSelectorOnMainThread:@selector(yf_clearRouterInfoWithRouterCode:)
                                             withObject:_routerCode
                                          waitUntilDone:[NSThread isMainThread]];
    YFLog(@"\n%@ 's soltData is dealloc \n %@",_clsName,[self toString]);
}

-(NSString * )toString{                                                                                                 
    return  [NSString stringWithFormat:@"clsName   ---  is:  %@ \n routerCode --- is:  %@  \n params   ---   is:  \n%@ \n",_clsName,_routerCode,_params];
}

@end
