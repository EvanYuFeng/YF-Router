//
//  YFRouterManager.h
//  YFRouter
//
//  Created by 胡玉峰 on 2021/1/11.
//

#import <Foundation/Foundation.h>
#import "NSObject+YFRouter.h"
#import "NSString+YFRouter.h"
#import "YFRouterConstants.h"



#define YFRouterGlobleInstance [YFRouterManager shareInstance]

NS_ASSUME_NONNULL_BEGIN

@interface YFRouterManager : NSObject

@property (nonatomic,copy) YFRouterHookHandleBlock yf_hook_handle;

+(YFRouterManager *)shareInstance;
+(instancetype) alloc __attribute__((unavailable("call sharedInstance instead")));
+(instancetype) new __attribute__((unavailable("call sharedInstance instead")));
-(instancetype) copy __attribute__((unavailable("call sharedInstance instead")));
-(instancetype) mutableCopy __attribute__((unavailable("call sharedInstance instead")));



#pragma mark 以下通过类名打开VC,无需提前注册

/// 通过类名直接打开一个VC 无参 无回调  默认push操作
/// @param clsName VC类名称
/// @return 成功打开YES 反之NO
-(BOOL)yf_openVCWithName:(nonnull NSString *)clsName;


/// 通过类名直接打开一个VC  带参 无回调  默认push操作
/// @param clsName  VC类名称
/// @param params 带给目标VC的参数
/// @return 成功打开YES 反之NO
-(BOOL)yf_openVCWithName:(nonnull NSString *)clsName
               andParams:(_Nullable id)params;


/// 通过类名直接打开一个VC  带参 带回调
/// @param clsName  VC类名称
/// @param params 带给目标VC的参数
/// @param callBack  回调
/// @return 成功打开YES 反之NO
-(BOOL)yf_openVCWithName:(nonnull NSString *)clsName
            andParams:(_Nullable id)params
    andCallBackHandle:(_Nullable YFRouterHandleBlock)callBack;


/// 通过类名直接打开一个VC  带参 带回调
/// @param clsName  VC类名称
/// @param params 带给目标VC的参数
/// @param transition 转场类型
/// @param animated 是否动画
/// @param callBack  回调
/// @return 成功打开YES 反之NO
-(BOOL)yf_openVCWithName:(nonnull NSString *)clsName
            andParams:(_Nullable id)params
    andTransitionType:(YF_Transitions_Type)transition
          andAnimated:(BOOL)animated
    andCallBackHandle:(_Nullable YFRouterHandleBlock)callBack;



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



// --------------------------------------------------------------------------------------------- //
#pragma mark 以下通用方法


/// 通过传入参数创建vc实例
/// @param clsName vc类名称
/// @param params 带给目标VC的参数
/// @param callBack  回调
-(UIViewController * _Nullable)yf_createVCWithClassName:(nonnull NSString *)clsName andParams:(_Nullable id)params andCallBackHandle:(_Nullable YFRouterHandleBlock)callBack;


/// 清除对应routerCode 的相关信息
/// @param routerCode 路由VC唯一标识
/// 注意：目前此方法只是库内部使用 不建议开发者主动去清楚
-(void)yf_clearRouterInfoWithRouterCode:(NSString * )routerCode;


/// 执行目标VC的回调
/// @param targetVC 目标VC的实例对象
/// @param params 回调的参数 可为空
-(void)yf_executCallBackHandle:(_Nonnull id)targetVC andParams:(_Nullable id)params;


/// 获取目标VC 绑定的参数
/// @param targetVC 目标VC实例
-(_Nonnull id)yf_getTargetVCParams:(_Nonnull id)targetVC;


/// hook 函数 全局设置 此函数会在目标vc创建成功后执行
/// 可用于全局拦截vc跳转的函数，在vc即将跳转之前做一些事情
/// @param yf_hook_handle hook block
-(void)setYf_hook_handle:(YFRouterHookHandleBlock _Nonnull)yf_hook_handle;


-(NSString * )yf_getClsNameWithUrl:(NSString * )url;




@end

NS_ASSUME_NONNULL_END
