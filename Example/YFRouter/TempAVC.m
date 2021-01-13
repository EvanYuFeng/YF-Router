//
//  TempAVC.m
//  YFRouter_Example
//
//  Created by 胡玉峰 on 2021/1/11.
//  Copyright © 2021 iosyufeng@sina.com. All rights reserved.
//

#import "TempAVC.h"
#import "YFTestModel.h"

@import YFRouter;

@interface TempAVC ()
@property (nonatomic,strong) NSString *age;
@property (nonatomic,strong) YFTestModel *testModel;
@end

@implementation TempAVC


- (void)viewDidLoad {
    [super viewDidLoad];
    YFLog(@"动态映射的age参数值----> %@",_age);
    YFLog(@"动态映射的自定义model值 \n %@",[_testModel toString]);
}

- (IBAction)goBack:(id)sender {
    if (self.presentationController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (IBAction)excutCallBack:(id)sender {
    
//    YFTestModel * customModel = [[YFTestModel alloc]initWithName:@"自定义model" andDataArr:@[
//      @"回调值1",
//      @"回调值2",
//    ]];
//
//    [[YFRouterManager shareInstance] yf_executCallBackHandle:self andParams:@{
//        @"name":@"这是回调回去的参数~~~",
//        @"id":@"123456",
//        @"customModel":customModel
//    }];
    
    [YFRouterGlobleInstance yf_executCallBackHandle:self andParams:@"这是回到回去的参数"];
    
  id params =   [[YFRouterManager shareInstance] yf_getTargetVCParams:self];
    YFLog(@"获取的绑定参数：%@",params);
}



@end
