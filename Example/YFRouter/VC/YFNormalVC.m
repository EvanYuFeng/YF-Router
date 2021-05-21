//
//  YFNormalVC.m
//  YFRouter_Example
//
//  Created by 胡玉峰 on 2021/5/20.
//  Copyright © 2021 iosyufeng@sina.com. All rights reserved.
//

#import "YFNormalVC.h"
#import "YFRouterDesCell.h"



@import Masonry;

@interface YFNormalVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView * tableView;
@property (strong,nonatomic)NSArray * dataArr;



@end

@implementation YFNormalVC

-(void)createData{
    
    self.dataArr = @[
        @{
            @"title": @"当前vc的名称",
            @"desData": @"YFNormalVC"
        },
        @{
            @"title": @"当前vc的RouterCode",
            @"desData": [YFRouterGlobleInstance yf_getTargetVCRouterCode:self]
        },
        @{
            @"title": @"跳转当前vc传递过来的参数",
            @"desData": [YFRouterGlobleInstance yf_getTargetVCParams:self]?[YFRouterGlobleInstance yf_getTargetVCParams:self]:@{}
        },
        @{
            @"title": @"执行跳转当前vc注册的回调",
            @"desData": @{@"userId":@"123456",
                          @"nickName":@"尼古拉斯杨"}
        },
    ];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationItem.title = @"YFNormalVC";
    [self createData];
    [self setUpView];
 
}
-(void)setUpView{
    [self.view addSubview:self.tableView];
    [self setUpConstani];
}

-(void)setUpConstani{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark tableview-delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"YFRouterCellID";
    YFRouterDesCell * cell = (YFRouterDesCell *)[YFRouterDesCell getCellWithTableView:tableView andReuseID:cellID];
    NSDictionary * cellData = self.dataArr[indexPath.row];
    [cell setDataDic:cellData];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        return 150;
    }else{
        return 100;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    执行回调
    if (indexPath.row == 3) {
        [YFRouterGlobleInstance yf_executCallBackHandle:self andParams:@{
                    @"param1":@"执行回调回传的参数1",
                    @"param2":@"执行回调回传的参数2"
        }];
    }
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


@end
