//
//  YFRouterManager+YFUrl.h
//  YFRouter
//
//  Created by 胡玉峰 on 2021/1/23.
//
#import "YFRouterManager.h"
#import "YFRouterConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface YFRouterManager (YFUrl)

// --------------------------------------------------------------------------------------------- //
#pragma mark 以下通过url打开VC,注意通过url打开VC必须提前注册url

/// 通过url注册类名
/// @param clsUrl url
/// @param clsName 类名称
-(BOOL)yf_registereUrl:(NSString * _Nonnull )clsUrl toClsName:(NSString * _Nonnull)clsName;

/// 通过url直接打开一个VC 无参 无回调  默认push操作
/// @param clsUrl VC类名称
/// @return 成功打开YES 反之NO
-(BOOL)yf_openVCWithUrl:(nonnull NSString *)clsUrl;


/// 通过url直接打开一个VC  带参 无回调  默认push操作
/// @param clsUrl  VC类名称
/// @param params 带给目标VC的参数
/// @return 成功打开YES 反之NO
-(BOOL)yf_openVCWithUrl:(nonnull NSString *)clsUrl
               andParams:(_Nullable id)params;

/// 通过url直接打开一个VC  带参 带回调
/// @param clsUrl  VC类名称
/// @param params 带给目标VC的参数
/// @param callBack  回调
/// @return 成功打开YES 反之NO
-(BOOL)yf_openVCWithUrl:(nonnull NSString *)clsUrl
            andParams:(_Nullable id)params
    andCallBackHandle:(_Nullable YFRouterHandleBlock)callBack;


/// 通过url直接打开一个VC  带参 带回调
/// @param clsUrl  VC类名称
/// @param params 带给目标VC的参数
/// @param transition 转场类型
/// @param animated 是否动画
/// @param callBack  回调
/// @return 成功打开YES 反之NO
-(BOOL)yf_openVCWithUrl:(nonnull NSString *)clsUrl
            andParams:(_Nullable id)params
    andTransitionType:(YF_Transitions_Type)transition
          andAnimated:(BOOL)animated
    andCallBackHandle:(_Nullable YFRouterHandleBlock)callBack;
@end

NS_ASSUME_NONNULL_END
