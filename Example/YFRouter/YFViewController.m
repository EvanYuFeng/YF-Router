//
//  YFViewController.m
//  YFRouter
//
//  Created by iosyufeng@sina.com on 01/09/2021.
//  Copyright (c) 2021 iosyufeng@sina.com. All rights reserved.
//

@import YF_Router;
#import "YFViewController.h"
#import "YFTestModel.h"
#import  "YFRouterHeader.h"


@interface CellModel()

@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) NSString *targetVcName;

@property (nonatomic,strong) NSString *des;

@property (nonatomic,strong) NSNumber *excutType;

-(instancetype)initWith:(NSString *)title
        andTargetVCName:(NSString *)targetVcName
                 andDes:(NSString *)des;

@end

@implementation CellModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        _title = dict[@"title"];
        _targetVcName = dict[@"targetVcName"];
        _des = dict[@"des"];
        _excutType = dict[@"excutType"];
    }
    return self;
    
}
-(instancetype)initWith:(NSString *)title
        andTargetVCName:(NSString *)targetVcName
                 andDes:(NSString *)des{
    
    if (self = [super init]) {
        _title = title;
        _targetVcName = targetVcName;
        _des = des;
    }
    return self;
}

@end

@interface YFViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *yf_tableView;
@property (nonatomic,strong) NSMutableArray *yf_table_data;

@property (nonatomic,strong) UIButton * normalPushBtn;
@property (nonatomic,strong) UIButton * urlPushBtn;


@end

@implementation YFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"YFRouter demo"];
    [self createData];
    [self setUpView];

//    设置全局关闭log
//   [[YFRouterManager shareInstance]setIsLog:NO];
    
//   设置全局路由hook
    [YFRouterGlobleInstance setYf_hook_handle:^(NSString * _Nullable clsName, id  _Nullable params) {
        YFLog(@"拦截到的VC类名《%@》，参数《%@》",clsName,params);
    }];
    
}
-(void)setUpView{
    [self.view addSubview:self.yf_tableView];
}

#pragma mark tableView--delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"yf_tableview_cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    CellModel * model = self.yf_table_data[indexPath.row];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.des;
    cell.detailTextLabel.numberOfLines = 5;
    cell.detailTextLabel.textColor = [UIColor redColor];
    cell.detailTextLabel.font  = [UIFont systemFontOfSize:15];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.yf_table_data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CellModel * model = self.yf_table_data[indexPath.row];
    
    YFTestModel * testModel = [[YFTestModel alloc]initWithName:@"testName" andDataArr:@[
        @"value1",
        @"value2"
    ]];
    
    switch (indexPath.row) {
        case 0:
//            [self testUrl];
//            链式调用
            YFRouterGlobleInstance.yf_clsName(model.targetVcName).yf_params(@{
                @"productId":@"54676547",
                @"nickName":@"我来在列表页"
                                                                            }).yf_done();
//            常规调用
//            [[YFRouterManager shareInstance] yf_openVCWithName:model.targetVcName];
            break;
        case 1:
//            链式调用 参数字典
            YFRouterGlobleInstance.yf_clsName(model.targetVcName).yf_params(@{
                @"params1":@"value1",
                @"params2":@"value2",}).yf_done();
//            常规调用
//            [[YFRouterManager shareInstance] yf_openVCWithName:model.targetVcName andParams:@{
//                @"params1":@"value1",
//                @"params2":@"value2",
//            }];
            break;
        case 2:
//            链式调用 参数数组
            YFRouterGlobleInstance.yf_clsName(model.targetVcName).yf_params(@[@"value1",@"value2"]).yf_done();
//          常规用法
//            [[YFRouterManager shareInstance] yf_openVCWithName:model.targetVcName andParams:@[@"value1",@"value2"]];
            break;
        case 3:
//           链式调用 参数自定义模型
            YFRouterGlobleInstance.yf_clsName(model.targetVcName).yf_params(testModel).yf_done();
//           常规用法
//            [YFRouterGlobleInstance yf_openVCWithName:model.targetVcName andParams:testModel];
            break;
        case 4:
            YFRouterGlobleInstance.yf_clsName(model.targetVcName).yf_params(testModel).yf_backHandle(^(id  _Nullable callBackParams) {
                YFLog(@"执行了回调  回调参数:\n %@",callBackParams);
            }).yf_done();
//            [YFRouterGlobleInstance yf_openVCWithName:model.targetVcName
//                                                     andParams:testModel
//                                             andCallBackHandle:^(id  _Nullable callBackParams) {
//                YFLog(@"执行了回调 \n 回调参数 %@",callBackParams);
//            }];
            break;
        case 5:
            [YFRouterGlobleInstance yf_openVCWithName:model.targetVcName andParams:testModel andTransitionType:YF_Transitions_present andAnimated:YES andCallBackHandle:^(id  _Nullable callBackParams) {
                YFLog(@"执行了回调  回调参数: \n %@",callBackParams);
            }];
            break;
        default:
            [YFRouterGlobleInstance yf_openVCWithName:model.targetVcName];
            break;
    }
    
}





-(void)createData{
    NSArray *dataArr = @[
//        0
        @{
            @"excutType":@(0),
            @"title":@"常规push",
            @"targetVcName":@"YFNormalVC",
            @"des":@"常规push，不带参数，不带回调，默认push",
            @"params":@{
                    @"titleName":@"YFRouterName",
                    @"age":@"18"
            }
        },
//        1
        @{
            @"title":@"常规push 带参数 字典",
            @"targetVcName":@"TempAVC",
            @"des":@"常规push，带参数，参数字典类型，注意log ",
            @"params":@{
                    @"titleName":@"YFRouterName",
                    @"age":@"18"
            }
        },
//        2
        @{
            @"title":@"常规push 带参数 数组",
            @"targetVcName":@"TempAVC",
            @"des":@"常规push，带参数，参数数组类型，注意log ",
            @"params":@{
                    @"titleName":@"YFRouterName",
                    @"age":@"18"
            }
        },
//        3
        @{
            @"title":@"常规push 带参数 自定义模型",
            @"targetVcName":@"TempAVC",
            @"des":@"常规push，带参数，参数为自定义model，注意log ",
            @"params":@{
                    @"titleName":@"YFRouterName",
                    @"age":@"18"
            }
        },
//        4
        @{
            @"title":@"常规push 带参数,带回调",
            @"targetVcName":@"TempAVC",
            @"des":@"常规push，带参数，带回调，默认push",
            @"params":@{
                    @"titleName":@"YFRouterName",
                    @"age":@"18"
            }
        },
//        5
        @{
            @"title":@"常规presnt 带参数,带回调",
            @"targetVcName":@"TempAVC",
            @"des":@"常规presnt，不带参数，不带回调，",
            @"params":@{
                    @"titleName":@"YFRouterName",
                    @"age":@"18"
            }
        },
                        
    ];
    
    for (NSDictionary * dict in dataArr) {
        CellModel * model = [[CellModel alloc]initWithDict:dict];
        [self.yf_table_data addObject:model];
    }
}


-(UITableView *)yf_tableView{
    if (!_yf_tableView) {
        _yf_tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _yf_tableView.delegate = self;
        _yf_tableView.dataSource = self;
    }
    return _yf_tableView;
}
- (NSMutableArray *)yf_table_data{
    if (!_yf_table_data) {
        _yf_table_data = [NSMutableArray new];
    }
    return _yf_table_data;
}


-(void)testUrl{
    
    NSString *exampUrl1 = @"aa.bb.com://detailPageA/list/:orderId";
    NSString *exampUrl2 = @"aa.bb.com://detailPageA/:orderId";
//    NSString *exampUrl3 = @"http://aa.bb.com/detailPageA/list/:orderId";
    
    NSString *openUrl = @"aa.bb.com://detailPageA/list/123456?param1=value1&param2=value2&params3?";
    
    [YFRouterGlobleInstance yf_registereUrl:exampUrl1 toClsName:@"TempAVC"];
    [YFRouterGlobleInstance yf_registereUrl:exampUrl2 toClsName:@"TempBVC"];
    
    [YFRouterGlobleInstance yf_openVCWithUrl:openUrl];
    
    
//    NSURL * url1 = [NSURL URLWithString:exampUrl1];
//    NSURL * url3 = [NSURL URLWithString:exampUrl3];
//
//
//
//    NSLog(@"scheme-->%@",url1.scheme);
//    NSLog(@"host--->%@",url1.host);
//    NSLog(@"aburl-->%@",url1.resourceSpecifier);
//    NSLog(@"%@",url1.query);
//    NSLog(@"path-->%@",url1.path);
//    NSLog(@"%@",url1.fragment);
//
//    NSLog(@"scheme-->%@",url3.scheme);
//    NSLog(@"host--->%@",url3.host);
//
//   NSDictionary *paramsA =  [self getQueryParams:@"aabb.cc.dd"];
//    NSLog(@"%@",paramsA);
//
//    [self parseUrl:@"aabbcc://www.com"];
}

-(NSDictionary * )parseUrl:(NSString *)url{
    NSMutableDictionary * urlDict = [NSMutableDictionary new];
  
//  获取query参数
    NSDictionary * queryParams = [self getQueryParams:url];
    
    NSLog(@"%@",queryParams);
    
    NSArray * allUrlComponent = [url substringToIndex:@"?"];
    
    
    
    
    return nil;
}

-(NSDictionary *)getQueryParams:(NSString *)url{
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url];
    NSMutableDictionary * paramer = [NSMutableDictionary new];
    //遍历所有参数，添加入字典
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [paramer setObject:obj.value forKey:obj.name];
    }];
    NSLog(@"queryParams--->%@",paramer);
    return paramer;
}

@end
