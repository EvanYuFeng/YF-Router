//
//  YFRouterManager+Chain.h
//  YFRouter
//
//  Created by 胡玉峰 on 2021/1/13.
//


#import "YFRouterManager.h"
#import "YFRouterConstants.h"

typedef YFRouterManager *(^YF_clsName_block)(NSString * clsName);
typedef YFRouterManager *(^YF_params_block)(id params);
typedef YFRouterManager *(^YF_transitionsType_block)(YF_Transitions_Type transitionsType);
typedef YFRouterManager *(^YF_animated_block)(BOOL animated);
typedef YFRouterManager *(^YF_backHandle_block)(YFRouterHandleBlock backHandle);
typedef void(^YF_done_block)(void);

@interface YFRouterManager (Chain)

//链式调用的缓存数据
@property (nonatomic,strong) NSMutableDictionary *yf_chain_config;

@property (nonatomic,copy,readonly)  YF_clsName_block yf_clsName;
@property (nonatomic,copy,readonly)  YF_params_block yf_params;
@property (nonatomic,copy,readonly)  YF_backHandle_block yf_backHandle;
@property (nonatomic,copy,readonly)  YF_transitionsType_block yf_transitionsType;
@property (nonatomic,copy,readonly)  YF_animated_block yf_animated;
@property (nonatomic,copy,readonly)  YF_done_block yf_done;

-(NSMutableDictionary*)yf_chain_config;
-(void)setYf_chain_config:(NSMutableDictionary *)yf_chain_config;


-(YF_clsName_block)yf_clsName;

-(YF_params_block)yf_params;

-(YF_backHandle_block)yf_backHandle;

-(YF_transitionsType_block)yf_transitionsType;

-(YF_animated_block)yf_animated;

-(YF_done_block)yf_done;

@end


