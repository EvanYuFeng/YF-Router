//
//  YFRouterSlotDate.h
//  YFRouter
//
//  Created by 胡玉峰 on 2021/1/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFRouterSlotData : NSObject
@property (nonatomic, strong, readonly) NSString *clsName;
@property (nonatomic, strong, readonly) NSString *routerCode;
@property (nonatomic, strong, readonly)  id params;

-(instancetype)initWithClsName:(NSString *)clsName andRouterCode:(NSString *)routerCode andParams:(_Nullable id)params;


-(NSString * )toString;
@end

NS_ASSUME_NONNULL_END
