//
//  YFUrlComponent.h
//  YFRouter
//
//  Created by 胡玉峰 on 2021/1/21.
//
/**
 url 解析节点类
 */

#import <Foundation/Foundation.h>
#import "YFRouterConstants.h"
NS_ASSUME_NONNULL_BEGIN

@interface YFUrlComponent : NSObject

// 父节点
@property (nonatomic,weak) YFUrlComponent *yf_preComponent;

// 当前节点的名称key
@property (nonatomic,copy) NSString *yf_componentKey;

// 对应参数的key
@property (nonatomic,strong) NSMutableArray *yf_paramKeys;

// 所有子节点
@property (nonatomic,strong) NSMutableDictionary<NSString *,YFUrlComponent *> *yf_subComponents;

// 当前节点所对应的clsName
@property (nonatomic,copy) NSString *yf_clsName;



//-(instancetype)initWith:(YFUrlComponent *)yf_pre_component
//        andComponentKey:(NSString *)yf_component_key
//           andParamsKey:(NSMutableArray *)yf_params_key
//       andSubComponents:(NSMutableDictionary<NSString *,YFUrlComponent *> *)subComponents;

-(void)yf_addSubComponent:(YFUrlComponent *)subComponent;

-(void)yf_addParmasKey:(NSArray<NSString *>*)paramsKey;



@end

NS_ASSUME_NONNULL_END
