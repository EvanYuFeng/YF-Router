//
//  YFRouterManager+Help.m
//  FBSnapshotTestCase
//
//  Created by 胡玉峰 on 2021/1/12.
//

#import "YFRouterManager+Help.h"
#import "NSString+YFRouter.h"

@implementation YFRouterManager (Help)


/// 生成routeCode
/// @param clsName routerCode 所对应的宿主类名称
/// @return 返回生成的唯一routerCode
-(NSString *)createRouterCode:(NSString *)clsName{
    NSString * spliceStr = [NSString stringWithFormat:@"%@-%lf",clsName,[[NSDate date] timeIntervalSince1970]];
    return  [spliceStr yf_stringToMd5];
}

/// 加测是否可以通过提供的字符串找到对应的class
/// @param clsName class名称
/// @return Bool 值 可以找到返回YES 反之 NO
-(BOOL)checkClassIsObtainable:(NSString *)clsName{
    Class cls = NSClassFromString(clsName);
    if (!cls) {
        return NO;
    }
    return YES;
}

/// 检测class是否为为UIViewController类或者子类
/// @param clsName clsName class名称
/// @return Bool  是返回YES 反之 NO
-(BOOL)checkClassIsVCClass:(NSString *)clsName{
    if (![self checkClassIsObtainable:clsName]) return NO;
    Class cls = NSClassFromString(clsName);
    id clsObj = [[cls alloc]init];
    return [clsObj isKindOfClass:[UIViewController class]];
}


/// 尝试将传入的params映射到目标VC的属性上，如果目标VC不存在与params中key对应的属性，则不映射
/// @param params 跳转时传入的参数
/// @param toVC 目标VC
-(void)mapToPropertyWithParams: (NSDictionary *)params andTargetVC:(id)toVC{
    if (params == nil) {
        return;
    }
   NSArray *dicKeys = [params allKeys];
     for (int i = 0; i < dicKeys.count; i ++) {
         SEL setSel = [self creatSetterWithPropertyName:dicKeys[i]];
         if ([toVC respondsToSelector:setSel]) {
             [toVC performSelectorOnMainThread:setSel
                                    withObject:params[dicKeys[i]]
                                 waitUntilDone:[NSThread isMainThread]];
         }
     }
 }

/// 根据属性key名称生成相应的set方法选择器
/// @param propertyName 属性名称（传入参数的key值）
- (SEL)creatSetterWithPropertyName: (NSString *) propertyName{
    propertyName =  [propertyName stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[propertyName substringToIndex:1] capitalizedString]];
    propertyName = [NSString stringWithFormat:@"set%@:", propertyName];
    return NSSelectorFromString(propertyName);
}


@end
