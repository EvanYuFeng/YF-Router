//
//  NSObject+YFRouter.h
//  Pods
//
//  Created by 胡玉峰 on 2021/1/11.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (YFRouter)

@property (nonatomic,strong) NSString *yf_routerCode;

-(NSString *)yf_routerCode;

-(void)setYf_routerCode:(NSString * )routerCode;


@end

NS_ASSUME_NONNULL_END
