//
//  YFUrlComponent.m
//  YFRouter
//
//  Created by 胡玉峰 on 2021/1/21.
//

#import "YFUrlComponent.h"

@implementation YFUrlComponent


//-(instancetype)initWith:(YFUrlComponent *)yf_pre_component
//        andComponentKey:(NSString *)yf_component_key
//           andParamsKey:(NSMutableArray *)yf_params_key
//       andSubComponents:(NSMutableDictionary<NSString *,YFUrlComponent *> *)subComponents{
//    if (self = [super init]) {
//        _yf_pre_component = yf_pre_component;
//        _yf_component_key = yf_component_key;
//        _yf_params_key = yf_params_key;
//
//    }
//
//    return self;
//
//}
- (NSMutableDictionary<NSString *,YFUrlComponent *> *)yf_subComponents{
    if (!_yf_subComponents) {
        _yf_subComponents = [NSMutableDictionary new];
    }
    return _yf_subComponents;
}

- (NSMutableArray *)yf_paramKeys{
    if (!_yf_paramKeys) {
        _yf_paramKeys = [NSMutableArray new];
    }
    return _yf_paramKeys;
}

-(void)yf_addSubComponent:(YFUrlComponent *)subComponent{
    subComponent.yf_preComponent = self;
    self.yf_subComponents[subComponent.yf_componentKey] = subComponent;
}

-(void)yf_addParmasKey:(NSArray<NSString *>*)paramsKey{
    if (self.yf_paramKeys) {
        YFLog(@" you are tring to regist a same url in same time");
        return;
    }
    self.yf_paramKeys = [NSMutableArray arrayWithArray:paramsKey] ;
}

@end
