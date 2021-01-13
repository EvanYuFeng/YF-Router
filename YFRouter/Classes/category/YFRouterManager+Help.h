//
//  YFRouterManager+Help.h
//  FBSnapshotTestCase
//
//  Created by 胡玉峰 on 2021/1/12.
//

#import "YFRouterManager.h"


@interface YFRouterManager (Help)

/// YFRouterManager+Help
/// 通过类名生成routeCode
/// @param clsName routerCode 所对应的宿主类名称
/// @return 返回生成的唯一routerCode
-(NSString *)createRouterCode:(NSString *)clsName;


/// YFRouterManager+Help
/// 检测是否可以通过提供的字符串找到对应的class
/// @param clsName class名称
/// @return Bool 值 可以找到返回YES 反之 NO
-(BOOL)checkClassIsObtainable:(NSString *)clsName;


/// 检测class是否为为UIViewController类或者子类
/// @param clsName clsName class名称
/// @return Bool  是返回YES 反之 NO
-(BOOL)checkClassIsVCClass:(NSString *)clsName;

/// 尝试将传入的params映射到目标VC的属性上，如果目标VC不存在与params中key对应的属性，则不映射
/// @param params 跳转时传入的参数
/// @param toVC 目标VC
-(void)mapToPropertyWithParams: (NSDictionary *)params andTargetVC:(id)toVC;


- (UIViewController *)yf_topViewController;
- (UIViewController *)yf_topViewController:(UIViewController *)vc;


@end
