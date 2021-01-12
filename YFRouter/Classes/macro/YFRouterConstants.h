//
//  YFRouterConstants.h
//  Pods
//
//  Created by 胡玉峰 on 2021/1/11.
//

#ifndef YFRouterConstants_h
#define YFRouterConstants_h

// log 宏
#ifndef __OPTIMIZE__
#define YFLog(fmt, ...)  NSLog((@"%s\n" @"YFRouter *********************** Log\n " fmt @"\nYFRouter *********************** Log"), __PRETTY_FUNCTION__,  ##__VA_ARGS__)
#else
# define YFLog(...) {}
#endif


#define  KKYFRouterCodelength 32
typedef void(^YFRouterHandleBlock)(_Nullable id callBackParams);


// 转场类型
typedef NS_ENUM(NSInteger, YF_Transitions_Type) {
    YF_Transitions_push, //push 进入
    YF_Transitions_present // present 进入
};


#endif /* YFRouterConstants_h */
