//
//  TempAVC.m
//  YFRouter_Example
//
//  Created by 胡玉峰 on 2021/1/11.
//  Copyright © 2021 iosyufeng@sina.com. All rights reserved.
//

#import "TempAVC.h"
#import "YFTestModel.h"
#import <MBProgressHUD/MBProgressHUD.h>

@import YFRouter;

@interface TempAVC ()
@property (nonatomic,strong) NSString *age;
@property (nonatomic,strong) YFTestModel *testModel;
@end

@implementation TempAVC


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)goBack:(id)sender {
    if (self.presentationController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
- (IBAction)getRouterParams:(id)sender {
  id params = [YFRouterGlobleInstance yf_getTargetVCParams:self];
    if (params == nil) {
        [self showText:@"跳转此VC没有传递参数"];
        return;
    }
    if ([params isKindOfClass:[NSString class]]) {
        [self showText:params];
    }else if([params isKindOfClass:[NSDictionary class]]){
        [self showText:[self dictionaryToJson:params]];
    }else if([params isKindOfClass:[NSArray class]]){
        [self showText:[self arrayToJsonString:params]];
    }else{
//   参数为自定义对象
        [self showText:[NSString stringWithFormat:@"%@",params]];
    }
  
}

- (IBAction)excutCallBack:(id)sender {
    [YFRouterGlobleInstance yf_executCallBackHandle:self andParams:@"这是回调回去的参数(这里可以换成任意数据类型)"];
    [self showText:@"请注意log打印！"];
}

-(void)showText:(NSString *)test{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.backgroundColor = [UIColor blackColor];
    hud.mode =MBProgressHUDModeText;
    hud.label.text =test;
    hud.label.numberOfLines = 0;
    hud.margin =10.f;
//    hud.offset.y =150.f;
    hud.removeFromSuperViewOnHide =YES;
    [hud hideAnimated:YES afterDelay:2.0f];
//    [hud hide:YES afterDelay:3];
}
// dict -> string
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
// arrary-> string
- (NSString *)arrayToJsonString:(NSArray *)array{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];;
}



@end
