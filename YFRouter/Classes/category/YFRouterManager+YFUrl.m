//
//  YFRouterManager+YFUrl.m
//  YFRouter
//
//  Created by 胡玉峰 on 2021/1/23.
//

#import "YFRouterManager+YFUrl.h"
#import "YFUrlComponent.h"


@implementation YFRouterManager (YFUrl)

#pragma mark url 注册相关

-(BOOL)yf_registereUrl:(NSString * _Nonnull )clsUrl toClsName:(NSString * _Nonnull)clsName{
//    return [self.yf_urlCenter yf_registereUrl:clsUrl toClsName:clsName];
    YFUrlComponent * rootUrlComponent = self.yf_root_url_component;
//    1.先分解
    NSArray * shemeOrComponents = [clsUrl componentsSeparatedByString:@"://"];
    if (shemeOrComponents.count >=2) {
//      存在sheme
        NSString * urlSheme = shemeOrComponents.firstObject;
//      所有子元素
        NSArray * allSubComponents = [shemeOrComponents.lastObject componentsSeparatedByString:@"/"];
//      取出当下sheme的
        YFUrlComponent *urlShemeComponent = rootUrlComponent.yf_subComponents[urlSheme];

        NSMutableArray * subComponentParamsKey = [NSMutableArray new];
        if (!urlShemeComponent) {
//        不存在
            urlShemeComponent = [[YFUrlComponent alloc]init];
            urlShemeComponent.yf_preComponent = rootUrlComponent;
            urlShemeComponent.yf_componentKey = urlSheme;
            rootUrlComponent.yf_subComponents[urlSheme] = urlShemeComponent;
//          将当前component当做root compoent
            rootUrlComponent = urlShemeComponent;
//          遍历所有子组件
            for (NSInteger index = 0; index < allSubComponents.count; index++) {
                NSString *subComponentKey = allSubComponents[index];
//              如果子组件含有： 则表明此key值为对应参数的key
                if ([[subComponentKey substringToIndex:1] isEqual:@":"]) {
//                 将参数key将入数组
                    [subComponentParamsKey addObject:[subComponentKey substringFromIndex:1]];
                }else{
                    YFUrlComponent * newUrlComponent = [[YFUrlComponent alloc]init];
                    newUrlComponent.yf_preComponent = rootUrlComponent;
                    newUrlComponent.yf_componentKey = subComponentKey;
                    rootUrlComponent.yf_subComponents[subComponentKey] = newUrlComponent;
                    rootUrlComponent = newUrlComponent;
                }
            }
//          将参数key赋值给了最后一个component
            rootUrlComponent.yf_paramKeys = subComponentParamsKey;
        }else{
            rootUrlComponent = urlShemeComponent;
            for (NSInteger index = 0; index < allSubComponents.count; index++) {
                NSString *subComponentKey = allSubComponents[index];
//              如果子组件含有： 则表明此key值为对应参数的key
                if ([[subComponentKey substringToIndex:1] isEqual:@":"]) {
//                 将参数key将入数组
                    [subComponentParamsKey addObject:[subComponentKey substringFromIndex:1]];
                }else{
                    YFUrlComponent * newUrlComponent =  rootUrlComponent.yf_subComponents[subComponentKey];
                    if (!newUrlComponent) {
                        YFUrlComponent * newUrlComponent = [[YFUrlComponent alloc]init];
                        newUrlComponent.yf_preComponent = rootUrlComponent;
                        newUrlComponent.yf_componentKey = subComponentKey;
                    }
                    rootUrlComponent = newUrlComponent;
                }
            }
//          将参数key赋值给了最后一个component
          rootUrlComponent.yf_paramKeys = subComponentParamsKey;
        }
        rootUrlComponent.yf_clsName = clsName;
    }
    return true;
}


-(BOOL)yf_openVCWithUrl:(nonnull NSString *)clsUrl{
//    return [self yf_openVCWithUrl:clsUrl andParams:nil];
    YFUrlComponent * rootUrlComponent = self.yf_root_url_component;
    if (rootUrlComponent.yf_subComponents.count == 0) {
        YFLog(@"please regist url init !!! no url be registed");
        return false;
    }
//   获取query params
    NSDictionary * queryParams = [self yf_getQueryParams:clsUrl];
    if ([clsUrl containsString:@"?"]) {
        NSArray * hostOrQueryArr = [clsUrl componentsSeparatedByString:@"?"];
        clsUrl = hostOrQueryArr.firstObject;
    }
//    1.先分解 判断sheme是否存在
    NSArray * shemeOrComponents = [clsUrl componentsSeparatedByString:@"://"];
    if (shemeOrComponents.count >= 2) {
         rootUrlComponent = rootUrlComponent.yf_subComponents[shemeOrComponents.firstObject];
        if (!rootUrlComponent) {
            YFLog(@"no url 《%@》 be registed!!!",clsUrl);
            return false;
        }
        shemeOrComponents = [shemeOrComponents.lastObject componentsSeparatedByString:@"/"];
    }else{
        shemeOrComponents = [clsUrl componentsSeparatedByString:@"/"];
    }
//  
    NSMutableDictionary * urlParams = [[NSMutableDictionary alloc]init];
    NSArray * allSubComponents = shemeOrComponents;
    NSString * targetClsName ;
    for (NSInteger index = 0;index < allSubComponents.count; index++) {
        NSString *subComponentKey = allSubComponents[index];
        if (rootUrlComponent.yf_subComponents[subComponentKey]) {
            rootUrlComponent = rootUrlComponent.yf_subComponents[subComponentKey];
            continue;
        }else{
          NSArray * paramKeys = rootUrlComponent.yf_paramKeys;
            targetClsName = rootUrlComponent.yf_clsName;
          NSInteger remainNum =  MIN(paramKeys.count, allSubComponents.count - index);
          for (NSInteger remainKeyIndex = 0; remainKeyIndex < remainNum; remainKeyIndex++) {
              [urlParams setObject:allSubComponents[index+remainKeyIndex] forKey:paramKeys[remainKeyIndex]];
          }
          break;
        }
    }
//   综合所有的params
    [urlParams setValuesForKeysWithDictionary:queryParams.copy];
    NSLog(@"%@",urlParams);
    
    return true;
}

-(NSDictionary *)yf_getQueryParams:(NSString *)url{
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url];
    NSMutableDictionary * paramer = [NSMutableDictionary new];
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [paramer setObject:obj.value forKey:obj.name];
    }];
    return paramer;
}

-(BOOL)yf_openVCWithUrl:(nonnull NSString *)clsUrl
              andParams:(_Nullable id)params{
    return [self yf_openVCWithUrl:clsUrl andParams:params andCallBackHandle:nil];
}

-(BOOL)yf_openVCWithUrl:(nonnull NSString *)clsUrl
            andParams:(_Nullable id)params
      andCallBackHandle:(_Nullable YFRouterHandleBlock)callBack{
    return [self yf_openVCWithUrl:clsUrl andParams:params andTransitionType:YF_Transitions_push andAnimated:YES andCallBackHandle:callBack];
}

//-(BOOL)yf_openVCWithUrl:(nonnull NSString *)clsUrl
//            andParams:(_Nullable id)params
//    andTransitionType:(YF_Transitions_Type)transition
//          andAnimated:(BOOL)animated
//      andCallBackHandle:(_Nullable YFRouterHandleBlock)callBack{
//    if (![self.yf_urlCenter yf_getClsNameWithUrl:clsUrl]) {
//        YFLog(@" YFRouter can not open url 《%@》,because it is not be register",clsUrl);
//        return NO;
//    }
//    NSString *clsName = [self yf_getClsNameWithUrl:clsUrl];
//    return [self yf_openVCWithName:clsName andParams:params andTransitionType:transition andAnimated:animated andCallBackHandle:callBack];
//}
//
//-(NSString * )yf_getClsNameWithUrl:(NSString * )url{
//    return [self.yf_urlCenter yf_getClsNameWithUrl:url];
//}
//
//-(void)setYf_hook_handle:(YFRouterHookHandleBlock _Nonnull)yf_hook_handle{
//    _yf_hook_handle = yf_hook_handle;
//}


@end
