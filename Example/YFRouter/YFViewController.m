//
//  YFViewController.m
//  YFRouter
//
//  Created by iosyufeng@sina.com on 01/09/2021.
//  Copyright (c) 2021 iosyufeng@sina.com. All rights reserved.
//

#import "YFViewController.h"
#import "YFTestModel.h"


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

@end

@implementation YFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"YFRouter demo"];
    [self createData];
    [self setUpView];
//    [self addbutton];
	
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)setUpView{
    [self.view addSubview:self.yf_tableView];
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
-(void)addbutton{
    UIButton * toTempABtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [toTempABtn setFrame:CGRectMake(0, 0 , 100, 50)];
    toTempABtn.center = self.view.center;
    [toTempABtn setTitle:@"jumpToTempb" forState:UIControlStateNormal];
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
    YFTestModel * testModel = [[YFTestModel alloc]initWithName:@"自动testModel" andDataArr:@[
        @"数组值1",
        @"数组值2",
    ]];

    NSDictionary * params = @{
        @"tempAParmas":@"123456",
        @"age":@"这是年龄参数",
        @"testModel":testModel
    };
    
//    bool canPush =   [[YFRouterManager shareInstance]yf_openVCWithName:@"TempAVC"];
    bool canPush = [[YFRouterManager shareInstance]yf_openVCWithName:@"TempAVC" andParams:@"这是带的参数"];
    if (canPush) {
        NSLog(@"push成功");
    }
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
            [YFRouterManager shareInstance].yf_clsName(model.targetVcName).yf_animated(NO).yf_done();
//            [[YFRouterManager shareInstance] yf_openVCWithName:model.targetVcName];
            break;
        case 1:
            [[YFRouterManager shareInstance] yf_openVCWithName:model.targetVcName andParams:@{
                @"params1":@"value1",
                @"params2":@"value2",
            }];
            break;
        case 2:
            [[YFRouterManager shareInstance] yf_openVCWithName:model.targetVcName andParams:@[@"value1",@"value2"]];
            break;
        case 3:
            [[YFRouterManager shareInstance] yf_openVCWithName:model.targetVcName andParams:testModel];
            break;
        case 4:
            [[YFRouterManager shareInstance] yf_openVCWithName:model.targetVcName
                                                     andParams:testModel
                                             andCallBackHandle:^(id  _Nullable callBackParams) {
                YFLog(@"执行了回调 \n 回调参数 %@",callBackParams);
            }];
            break;
        case 5:
            [[YFRouterManager shareInstance] yf_openVCWithName:model.targetVcName andParams:testModel andTransitionType:YF_Transitions_present andAnimated:YES andCallBackHandle:^(id  _Nullable callBackParams) {
                YFLog(@"执行了回调 \n 回调参数 %@",callBackParams);
            }];
            break;
        default:
            [[YFRouterManager shareInstance] yf_openVCWithName:model.targetVcName];
            break;
    }
    
}



-(void)createData{
    NSArray *dataArr = @[
//        0
        @{
            @"excutType":@(0),
            @"title":@"常规push",
            @"targetVcName":@"TempAVC",
            @"des":@"常规push，不带参数，不带回调，默认push"
        },
//        1
        @{
            @"title":@"常规push 带参数",
            @"targetVcName":@"TempAVC",
            @"des":@"常规push，带参数，参数字典类型，注意log !!!"
        },
//        2
        @{
            @"title":@"常规push 带参数",
            @"targetVcName":@"TempAVC",
            @"des":@"常规push，带参数，参数字典数组，注意log !!!"
        },
//        3
        @{
            @"title":@"常规push 带参数",
            @"targetVcName":@"TempAVC",
            @"des":@"常规push，带参数，参数为自定义model，注意log ！！！"
        },
//        4
        @{
            @"title":@"常规push 带参数,带回调",
            @"targetVcName":@"TempAVC",
            @"des":@"常规push，带参数，带回调，默认push"
        },
//        5
        @{
            @"title":@"常规presnt 带参数,带回调",
            @"targetVcName":@"TempAVC",
            @"des":@"常规presnt，不带参数，不带回调，"
        },
                        
    ];
    
    for (NSDictionary * dict in dataArr) {
        CellModel * model = [[CellModel alloc]initWithDict:dict];
        [self.yf_table_data addObject:model];
    }
}

@end
