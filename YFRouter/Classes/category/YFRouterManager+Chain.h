//
//  YFRouterManager+Chain.h
//  YFRouter
//
//  Created by 胡玉峰 on 2021/1/13.
//


#import "YFRouterManager.h"
#import "YFRouterConstants.h"

typedef YFRouterManager *(^YF_clsName_block)(NSString * clsName);
typedef YFRouterManager *(^YF_url_block)(NSString * url);
typedef YFRouterManager *(^YF_params_block)(id params);
typedef YFRouterManager *(^YF_transitionsType_block)(YF_Transitions_Type transitionsType);
typedef YFRouterManager *(^YF_animated_block)(BOOL animated);
typedef YFRouterManager *(^YF_backHandle_block)(YFRouterHandleBlock backHandle);

typedef void(^YF_done_block)(void);
typedef UIViewController *(^YF_getvc_block)(void);

@interface YFRouterManager (Chain)

//链式调用的缓存数据
@property (nonatomic,strong) NSMutableDictionary *yf_chain_config;

@property (nonatomic,copy,readonly)  YF_clsName_block yf_clsName;
@property (nonatomic,copy,readonly)  YF_params_block yf_params;
@property (nonatomic,copy,readonly)  YF_backHandle_block yf_backHandle;
@property (nonatomic,copy,readonly)  YF_transitionsType_block yf_transitionsType;
@property (nonatomic,copy,readonly)  YF_animated_block yf_animated;
@property (nonatomic,copy,readonly)  YF_url_block yf_url;

@property (nonatomic,copy,readonly)  YF_done_block yf_done;
@property (nonatomic,copy,readonly)  YF_getvc_block yf_getvc;


-(NSMutableDictionary*)yf_chain_config;
-(void)setYf_chain_config:(NSMutableDictionary *)yf_chain_config;

/// 设置vc类名
-(YF_clsName_block)yf_clsName;

/// 设置传递的参数
-(YF_params_block)yf_params;

/// 设置回调
-(YF_backHandle_block)yf_backHandle;

/// 设置跳转类型
-(YF_transitionsType_block)yf_transitionsType;

/// 设置跳转是否动画
-(YF_animated_block)yf_animated;

/// 设置跳转的url
-(YF_url_block)yf_url;

/// 配置完成完成直接获取vc
-(YF_getvc_block)yf_getvc;

/// 配置完成开始跳转（使用链式调用必须执行此句或者yf_getvc）
-(YF_done_block)yf_done;

@end


