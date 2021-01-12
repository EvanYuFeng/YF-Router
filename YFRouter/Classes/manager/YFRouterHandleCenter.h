//
//  YFRouterHandleCenter.h
//  YFRouter
//
//  Created by 胡玉峰 on 2021/1/12.
//

#import <Foundation/Foundation.h>
#import "YFRouterConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface YFRouterHandleCenter : NSObject

@property (nonatomic,strong) NSMutableDictionary *yf_handleData;


/// 注册handle
/// @param routerCode  路由节点唯一标识
/// @param handleBlock 回调block
-(void)registerHanleWithRouterCode:(NSString * _Nonnull )routerCode andHandle:(YFRouterHandleBlock)handleBlock;


/// 移除handle
/// @param routerCode 路由节点唯一标识
-(void)removeHandleWithRouterCode:(NSString * _Nonnull )routerCode;


/// 通过routerCode获取执行把柄
/// @param routerCode 路由节点唯一标识
-(_Nullable YFRouterHandleBlock)getHandleBlockWithRouterCode:(NSString * _Nonnull)routerCode;

@end

NS_ASSUME_NONNULL_END
