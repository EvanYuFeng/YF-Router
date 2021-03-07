//
//  YFRouterUrlCenter.h
//  YFRouter
//
//  Created by 胡玉峰 on 2021/1/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFRouterUrlCenter : NSObject

/// 通过url注册class
/// @param clsUrl url
/// @param clsName 类名称
-(BOOL)yf_registereUrl:(NSString * _Nonnull )clsUrl toClsName:(NSString * _Nonnull)clsName;


/// 通过url获取类名称
/// @param clsUrl url
-(NSString * _Nullable)yf_getClsNameWithUrl:(NSString * _Nonnull)clsUrl;
@end

NS_ASSUME_NONNULL_END
