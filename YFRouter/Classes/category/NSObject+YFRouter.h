//
//  NSObject+YFRouter.h
//  Pods
//
//  Created by 胡玉峰 on 2021/1/11.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "YFRouterSlotData.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (YFRouter)

@property (nonatomic,strong) YFRouterSlotData *yf_routerSoletData;
-(YFRouterSlotData *)yf_routerSoletData;
-(void)setYf_routerSoletData:(YFRouterSlotData * _Nonnull)yf_routerSoletData;
@end

NS_ASSUME_NONNULL_END
