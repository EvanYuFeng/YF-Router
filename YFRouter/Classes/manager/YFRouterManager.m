//
//  YFRouterManager.m
//  YFRouter
//
//  Created by 胡玉峰 on 2021/1/11.
//

#import "YFRouterManager.h"
#import "YFRouterConstants.h"
#import "YFRouterHandleCenter.h"
#import "YFRouterUrlCenter.h"
#import "YFRouterManager+Help.h"
#import "YFRouterManager+Chain.h"
#import "YFUrlComponent.h"

#define yf_root_url_component_key @"yf_root_url_component_key"

@interface YFRouterManager()
@property (nonatomic,strong) YFRouterHandleCenter *yf_handleCenter;
@property (nonatomic,strong) YFRouterUrlCenter *yf_urlCenter ;
// vc创建之后 push之前执行的hook
@property (nonatomic,copy) YFRouterHookHandleBlock yf_hook_handle;
@end

@implementation YFRouterManager

+(YFRouterManager *)shareInstance{
    static YFRouterManager * k_instance_singleton = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (k_instance_singleton == nil) {
            k_instance_singleton = [[YFRouterManager alloc] init];
//          默认开启打印log
            k_instance_singleton.isLog = true;
//          初始化链式调用的字典
            [k_instance_singleton setYf_chain_config:[NSMutableDictionary new]];
        }
    });
    return (YFRouterManager *)k_instance_singleton;
}

-(instancetype)init{
    if (self = [super init]) {
        _yf_root_url_component = [[YFUrlComponent alloc]init];
        _yf_root_url_component.yf_componentKey = yf_root_url_component_key;
    }
    return self;
}



-(BOOL)yf_openVCWithName:(nonnull NSString *)clsName{
    return  [self yf_openVCWithName:clsName
                          andParams:nil];
}
-(BOOL)yf_openVCWithName:(nonnull NSString *)clsName
               andParams:(_Nullable id)params{
    return  [self yf_openVCWithName:clsName
                          andParams:params
                  andCallBackHandle:nil];
}
-(BOOL)yf_openVCWithName:(nonnull NSString *)clsName
               andParams:(_Nullable id)params
       andCallBackHandle:(_Nullable YFRouterHandleBlock)callBack{
    return   [self yf_openVCWithName:clsName
                           andParams:params
                   andTransitionType:YF_Transitions_push
                         andAnimated:YES
                   andCallBackHandle:callBack];
}
-(BOOL)yf_openVCWithName:(nonnull NSString *)clsName
            andParams:(_Nullable id)params
    andTransitionType:(YF_Transitions_Type)transitionType
          andAnimated:(BOOL)animated
    andCallBackHandle:(_Nullable YFRouterHandleBlock)callBack {
    if (![self checkClassIsVCClass:clsName]) {
        YFLog(@"<< %@ >>  is not a subclass of UIViewController or class is not found please check",clsName);
        return NO;
    }
    UIViewController * toVC = [self yf_createVCWithClassName:clsName andParams:params andCallBackHandle:callBack];
    if (toVC)
    return [self yf_beginJumpVC:toVC andTransitionType:transitionType andAnimated:animated];
    return NO;
}

-(BOOL)yf_beginJumpVC:(id)toVC
 andTransitionType:(YF_Transitions_Type)transitionType
       andAnimated:(BOOL)animated {
    if ([self yf_topViewController].navigationController && transitionType == YF_Transitions_push) {
        [[self yf_topViewController].navigationController pushViewController:toVC animated:animated];
    }else{
        if ([self yf_topViewController].navigationController) {
            [[self yf_topViewController].navigationController presentViewController:toVC animated:animated completion:nil];
        }else{
            [[self yf_topViewController] presentViewController:toVC animated:animated completion:nil];
        }
    }
    return YES;
}

-(UIViewController * _Nullable)yf_createVCWithClassName:(nonnull NSString *)clsName andParams:(_Nullable id)params andCallBackHandle:(_Nullable YFRouterHandleBlock)callBack{
    if (!NSClassFromString(clsName)) { YFLog(@"%@ class is not found !!!",clsName);  return nil;}
    id clsObj = [[NSClassFromString(clsName) alloc]init];
    if (![clsObj isKindOfClass:[UIViewController class]]) {
        YFLog(@"%@ is not a class or subclass of UIViewController",clsName) ;
        return nil ;
        }
    UIViewController * toVC = (UIViewController *)clsObj;
//  创建插槽数据 将回调注册到时间管理中心
    YFRouterSlotData * toVCSlotData = [self yf_createRouterSlotDataWithClassName:clsName andParams:params andCallBackHandle:callBack];
//  将插槽数据 关联给目标VC
    [toVC setYf_routerSoletData:toVCSlotData];
//  尝试将参数动态映射到目标VC上
    [self yf_tryToMapParams:params toTargetVC:toVC];
//  执行hook如果存在的话
    if (self.yf_hook_handle) self.yf_hook_handle(clsName, params);
    return toVC;
}

-(_Nonnull id)yf_getTargetVCParams:(_Nonnull id)targetVC{
    YFRouterSlotData * targetSlotData = [targetVC yf_routerSoletData];
    if (!targetSlotData) {
        YFLog(@"《 %@ 》 class has no slotData!!! because it not be created by YFRouter",NSStringFromClass([targetVC class]));
        return nil;
    }
    return [targetSlotData params];
}

-(void)yf_tryToMapParams:(_Nullable id)params toTargetVC:(id)toVC{
//   如过params非字典类型数据则不映射    if params is not kind of dictionary direct return
    if (!params || ![params isKindOfClass:[NSDictionary class]]) return;
    NSDictionary * paramsDic = (NSDictionary *)params;
    [self yf_mapToPropertyWithParams:paramsDic andTargetVC:toVC];
}

-(void)yf_mapToPropertyWithParams: (NSDictionary *)params andTargetVC:(id)toVC{
    if (params == nil) {
        return;
    }
   NSArray *dicKeys = [params allKeys];
     for (int i = 0; i < dicKeys.count; i ++) {
         SEL setSel = [self yf_creatSetterWithPropertyName:dicKeys[i]];
         if ([toVC respondsToSelector:setSel]) {
             [toVC performSelectorOnMainThread:setSel
                                    withObject:params[dicKeys[i]]
                                 waitUntilDone:[NSThread isMainThread]];
         }
     }
 }

 - (SEL)yf_creatSetterWithPropertyName: (NSString *) propertyName{
     propertyName =  [propertyName stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[propertyName substringToIndex:1] capitalizedString]];
     propertyName = [NSString stringWithFormat:@"set%@:", propertyName];
     return NSSelectorFromString(propertyName);
 }

-(void)yf_safetySaveHandle:(NSString *)routerCode andHandle:(YFRouterHandleBlock)callBack{
    [self.yf_handleCenter registerHanleWithRouterCode:routerCode andHandle:callBack];
}

-(YFRouterSlotData *)yf_createRouterSlotDataWithClassName:(nonnull NSString *)clsName andParams:(_Nullable id)params andCallBackHandle:(_Nullable YFRouterHandleBlock)callBack{
    NSString * routerCode = [self createRouterCode:clsName];
    if (callBack) [self yf_safetySaveHandle:routerCode andHandle:callBack];
    return  [[YFRouterSlotData alloc]initWithClsName:clsName andRouterCode:routerCode andParams:params];
}

-(void)yf_clearRouterInfoWithRouterCode:(NSString * )routerCode{
    [self.yf_handleCenter removeHandleWithRouterCode:routerCode];
}

-(void)yf_executCallBackHandle:(_Nonnull id)targetVC andParams:(_Nullable id)params{
    YFRouterSlotData * targetSlotData = [targetVC yf_routerSoletData];
    if (!targetSlotData) YFLog(@"《 %@ 》 class has no slotData!!! because it not be create by YFRouter",NSStringFromClass([targetVC class]));
    YFRouterHandleBlock targetBlock = [self.yf_handleCenter getHandleBlockWithRouterCode:targetSlotData.routerCode];
    if (!targetBlock) return YFLog(@"《 %@ 》 class has no register callBackHandle!!! please check",NSStringFromClass([targetVC class]));
    targetBlock(params);
}



#pragma mark lazy load
-(YFRouterHandleCenter *)yf_handleCenter{
    if (!_yf_handleCenter) {
        _yf_handleCenter = [[YFRouterHandleCenter alloc]init];
    }
    return _yf_handleCenter;
}
-(YFRouterUrlCenter *)yf_urlCenter{
    if (!_yf_urlCenter) {
        _yf_urlCenter = [[YFRouterUrlCenter alloc]init];
    }
    return _yf_urlCenter;
}


-(YFUrlComponent *)yf_root_url_component{
    if (!_yf_root_url_component) {
        _yf_root_url_component = [[YFUrlComponent alloc]init];
        _yf_root_url_component.yf_componentKey = yf_root_url_component_key;
    }
    return _yf_root_url_component;
}
@end
