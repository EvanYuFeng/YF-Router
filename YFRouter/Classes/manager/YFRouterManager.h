//
//  YFRouterManager.h
//  YFRouter
//
//  Created by 胡玉峰 on 2021/1/11.
//

#import <Foundation/Foundation.h>
#import "NSObject+YFRouter.h"
#import "NSString+YFRouter.h"

typedef void(^callBackHandleBlock)(_Nullable id callBackParams);

NS_ASSUME_NONNULL_BEGIN

@interface YFRouterManager : NSObject

-(BOOL)openVCWithClass:(Class)cls andParams:(_Nullable id)params andCallBackHandle:(_Nullable callBackHandleBlock)callBack;

@end

NS_ASSUME_NONNULL_END
