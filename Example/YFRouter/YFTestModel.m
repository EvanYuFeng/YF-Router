//
//  YFTestModel.m
//  YFRouter_Example
//
//  Created by 胡玉峰 on 2021/1/12.
//  Copyright © 2021 iosyufeng@sina.com. All rights reserved.
//

#import "YFTestModel.h"

@implementation YFTestModel

-(instancetype)initWithName:(NSString *)name andDataArr:(NSArray *)dataArr{
    if (self = [super init]) {
        _name = name;
        _dataArr = dataArr;
    }
    return self;
}

-(NSString *)toString{
    return [NSString stringWithFormat:@"name--> %@ \n dataArr -- > %@",_name,_dataArr];
}

@end
