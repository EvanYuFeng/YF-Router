//
//  YFRouterUrlCenter.m
//  YFRouter
//
//  Created by 胡玉峰 on 2021/1/13.
//


#import "YFRouterUrlCenter.h"
#import "YFRouterConstants.h"

@interface YFRouterUrlCenter ()
@property (nonatomic,strong) NSMutableDictionary *yf_urlData;
@end

@implementation YFRouterUrlCenter
{
    dispatch_queue_t _concurrentQueue;
}


-(instancetype)init{
    if (self = [super init]) {
        _concurrentQueue = dispatch_queue_create("yf.router.url.sync.queue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}


-(BOOL)yf_registereUrl:(NSString * _Nonnull )clsUrl toClsName:(NSString * _Nonnull)clsName{
    if (self.yf_urlData[clsUrl] && ((NSString *)self.yf_urlData[clsUrl]).length > 0) {
        YFLog(@"you are trying to register url 《%@》,but it has been registe ,please check!!!",clsUrl);
        return NO;
    }
    dispatch_barrier_async(_concurrentQueue, ^{
        self.yf_urlData[clsUrl] = clsName;
        NSLog(@"注册完成-%@",clsName);
    });
    return YES;
}

-(NSString * _Nullable)yf_getClsNameWithUrl:(NSString * _Nonnull)clsUrl{
    __block NSString * temClsName;
    dispatch_sync(_concurrentQueue, ^{
        temClsName = self.yf_urlData[clsUrl];
       });
    NSLog(@"获取到的clsName-- %@",temClsName);
    return  temClsName;
}

- (NSMutableDictionary *)yf_urlData{
    if (!_yf_urlData) {
        _yf_urlData = [NSMutableDictionary new];
    }
    return _yf_urlData;
}
@end
