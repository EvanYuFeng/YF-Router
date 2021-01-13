//
//  YFRouterManager+Chain.m
//  YFRouter
//
//  Created by 胡玉峰 on 2021/1/13.
//


#define yf_chain_cls_name  @"yf_chain_cls_name"
#define yf_chain_params  @"yf_chain_params"
#define yf_chain_transition_type @"yf_chain_transition_type"
#define yf_chain_back_handle @"yf_chain_back_handle"
#define yf_chain_animated @"yf_chain_animated"

#import "YFRouterManager+Chain.h"


@implementation YFRouterManager (Chain)

@dynamic yf_clsName;
@dynamic yf_params;
@dynamic yf_backHandle;
@dynamic yf_transitionsType;
@dynamic yf_animated;
@dynamic yf_done;

-( NSMutableDictionary*)yf_chain_config{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setYf_chain_config:(NSMutableDictionary * _Nonnull)yf_chain_config{
    objc_setAssociatedObject(self, @selector(yf_chain_config), yf_chain_config, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(YF_clsName_block)yf_clsName{
    return  ^YFRouterManager *(NSString *clsName) {
        self.yf_chain_config[yf_chain_cls_name] = clsName;
        return self;
    };
}

-(YF_params_block)yf_params{
    return ^YFRouterManager *(id params){
        self.yf_chain_config[yf_chain_params] = params;
        return self;
    };
}

-(YF_backHandle_block)yf_backHandle{
    return ^YFRouterManager *(YFRouterHandleBlock handleBlock){
        self.yf_chain_config[yf_chain_back_handle] = handleBlock;
        return self;
    };
}
//
-(YF_transitionsType_block)yf_transitionsType{
    return  ^YFRouterManager *(YF_Transitions_Type transitionsType){
        self.yf_chain_config[yf_chain_transition_type] = @(transitionsType);
        return self;
    };
}
//
-(YF_animated_block)yf_animated{
    return ^YFRouterManager *(BOOL animated){
        NSNumber *animateNum = animated?@(1):@(0);
        self.yf_chain_config[yf_chain_animated] = animateNum;
        return self;
    };
}

-(YF_done_block)yf_done{
    return  ^{
        NSMutableDictionary * chainConfig = self.yf_chain_config;
        if (self.yf_chain_config[yf_chain_cls_name]) {
            NSString * clsName = self.yf_chain_config[yf_chain_cls_name];
            id params = self.yf_chain_config[yf_chain_params];
            YF_Transitions_Type transiTionsType = [self.yf_chain_config[yf_chain_transition_type] intValue];
            BOOL animated ;
            if (self.yf_chain_config[yf_chain_animated] == nil) {
                animated = YES;
            }else{
                if ( [self.yf_chain_config[yf_chain_animated] integerValue] == 0) {
                    animated = NO;
                }else{
                    animated = YES;
                }
            }
            YFRouterHandleBlock backHandle = self.yf_chain_config[yf_chain_back_handle];
            [self yf_openVCWithName:clsName andParams:params andTransitionType:transiTionsType andAnimated:animated andCallBackHandle:backHandle];
            [self.yf_chain_config removeAllObjects];
        }else{
            YFLog(@"《clsName》must be given when you use chain call !! please check");
        }
    };
}
@end
