//
//  YFRouterConstants.h
//  Pods
//
//  Created by 胡玉峰 on 2021/1/11.
//

#ifndef YFRouterConstants_h
#define YFRouterConstants_h


#define  KKYFRouterCodelength 32
typedef void(^YFRouterHandleBlock)(_Nullable id callBackParams);
typedef void(^YFRouterHookHandleBlock)( NSString * _Nullable  clsName, _Nullable id params);

// 转场类型
typedef NS_ENUM(NSInteger, YF_Transitions_Type) {
    YF_Transitions_push, //push 进入
    YF_Transitions_present // present 进入
};

#import "YFRouterManager.h"

#define YFRouterGlobleInstance [YFRouterManager shareInstance]
#define YFIsLog [[YFRouterManager shareInstance] isLog]

// log 宏
#ifdef DEBUG
#define YFLog(fmt, ...) YFIsLog? (NSLog((@"%s\n" @"YFRouter *********************** Log\n " fmt @"\nYFRouter *********************** Log"), __PRETTY_FUNCTION__,  ##__VA_ARGS__)):[NSString stringWithFormat:@"%@",fmt]
#else
# define YFLog(...) {}
#endif


#endif /* YFRouterConstants_h */
