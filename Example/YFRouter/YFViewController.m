//
//  YFViewController.m
//  YFRouter
//
//  Created by iosyufeng@sina.com on 01/09/2021.
//  Copyright (c) 2021 iosyufeng@sina.com. All rights reserved.
//

#import "YFViewController.h"

@interface YFViewController ()

@end

@implementation YFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addbutton];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)addbutton{
    
    UIButton * toTempABtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [toTempABtn setFrame:CGRectMake(0, 0 , 100, 50)];
    toTempABtn.center = self.view.center;
    [toTempABtn setTitle:@"jumpToTempA" forState:UIControlStateNormal];
    [toTempABtn addTarget:self action:@selector(jumpTempA:) forControlEvents:UIControlEventTouchUpInside];
    [toTempABtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:toTempABtn];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)jumpTempA:(id)sender {
    
    YFRouterManager *routerManager = [[YFRouterManager alloc]init];

   bool canPush =   [routerManager openVCWithClass:NSClassFromString(@"TempAVC") andParams:@{
        @"tempAParmas":@"123456"
    } andCallBackHandle:nil];
    
    if (canPush) {
        NSLog(@"push成功");
    }
    
}

@end
