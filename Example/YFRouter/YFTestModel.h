//
//  YFTestModel.h
//  YFRouter_Example
//
//  Created by 胡玉峰 on 2021/1/12.
//  Copyright © 2021 iosyufeng@sina.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFTestModel : NSObject

@property (nonatomic,copy) NSString *name;

@property (nonatomic,strong) NSArray *dataArr;

-(instancetype)initWithName:(NSString *)name andDataArr:(NSArray *)dataArr;

-(NSString *)toString;
@end

NS_ASSUME_NONNULL_END
