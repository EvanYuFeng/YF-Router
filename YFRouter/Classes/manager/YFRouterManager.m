//
//  YFRouterManager.m
//  YFRouter
//
//  Created by 胡玉峰 on 2021/1/11.
//

#import "YFRouterManager.h"



@interface YFRouterManager()

@end

@implementation YFRouterManager



-(BOOL)openVCWithClass:(Class)cls andParams:(_Nullable id)params andCallBackHandle:(_Nullable callBackHandleBlock)callBack{
//  如果cls 不存在直接返回No
    if (!cls) {
        return NO;
    }
    id clsObj = [[cls alloc]init];
    if (![clsObj isKindOfClass:[UIViewController class]]) {
        return NO;
    }
    UIViewController * toVC = (UIViewController *)clsObj;
    NSString *originalRCString = [NSString stringWithFormat:@"%@-%lf",NSStringFromClass(cls),[[NSDate date] timeIntervalSince1970]];
    NSLog(@"得到的原始routerCode数据-->%@",originalRCString);
    [toVC setYf_routerCode:[originalRCString yf_stringToMd5]];
    NSLog(@"当前vc的routerCode是--》%@",[toVC yf_routerCode]);
    
    [[self topViewController].navigationController pushViewController:toVC animated:YES];
    return YES;
}

- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}




@end
