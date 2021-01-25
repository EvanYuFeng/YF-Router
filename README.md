# YFRouter

[![CI Status](https://img.shields.io/travis/iosyufeng@sina.com/YFRouter.svg?style=flat)](https://travis-ci.org/iosyufeng@sina.com/YFRouter)
[![Version](https://img.shields.io/cocoapods/v/YFRouter.svg?style=flat)](https://cocoapods.org/pods/YFRouter)
[![License](https://img.shields.io/cocoapods/l/YFRouter.svg?style=flat)](https://cocoapods.org/pods/YFRouter)
[![Platform](https://img.shields.io/cocoapods/p/YFRouter.svg?style=flat)](https://cocoapods.org/pods/YFRouter)


## 功能列表

| 功能点              | 是否支持            | 备注                |
| :------------------| :----:             | :----:             |
| vc解耦              | ✔️                  | 可通过类名直接打开指定VC              |
| 基本数据传参         | ✔️                  |  支持基本数据传递              |
| 自定义对象传递         | ✔️                  |  支持自定义对象传递             |
| 回调注册        | ✔️                  |  支持方法/参数回调             |
| 链式语法调用       | ✔️                  |  支持链式语法调用            |
| url&scheme注册       | ✔️                  |  支持url注册响应的VC           |
| 通过url打开VC       | ✔️                  |  支持通过url打开响应注册的VC           |


## 如何使用
- 直接打开目标VC 
```objc
    // 常规方法调用
    [YFRouterGlobleInstance yf_openVCWithName:@"xxxVC"];
    // 链式语法调用
     YFRouterGlobleInstance.yf_clsName(@"xxxVC").yf_done();
```

## - 直接打开目标VC 带参数 
```objc
    // 注意：！！！ 如果传递的参数是字典，YFRouter会尝试将传递的参数中《key》值与目标VC相同名称的属性进行映射赋值，
    // 举🌰 ： 
    // 如果目标VC含有一个属性名称为 orderId  你传递的参数为 @{@"orderId:@"123456"},
    //这种情况下YFRouter会直接将目标VC的orderId属性映射成 123456
    // 常规方法调用
     [YFRouterGlobleInstance yf_openVCWithName:@"xxxVC" andParams:@{@"orderId":@"123456"}];
    // 链式语法调用
     YFRouterGlobleInstance.yf_clsName(@"xxxVC).yf_params(@{@"orderId":@"123456"}).yf_done();

    // 参数获取：
    // 往往我们传递的参数并不是所有的目标VC，都有与之对应的属性
    // 我们可以通过下边方法直接打到传递给目标VC的所有参数
    // 函数参数为具体的VC实例
    // 比如你在一个具体VC中想取其他VC跳转自己的时候所传递的参数，此时 vcInstance 即为 self
     id params = [YFRouterGlobleInstance yf_getTargetVCParams:vcInstance];
```
## - 打开VC并注册回调

```objc
   // 常规方法调用
  [YFRouterGlobleInstance yf_openVCWithName:@"xxxVC" andParams:nil andCallBackHandle:^(id  _Nullable callBackParams)
    {
        NSLog(@"xxxVC 调用回调传回来的参数 %@",callBackParams);
    }];
    //链式语法调用
   YFRouterGlobleInstance.yf_clsName(@"xxxVC").yf_backHandle(^(id  _Nullable callBackParams) {
        NSLog(@"xxxVC 调用回调传回来的参数 %@",callBackParams);
    }).yf_done();
  // 回调执行
  // 执行那个VC的回调 vcInstance 则代表那个VC的实例 
  // 回调回去的参数为id类型 可为nil 数组 字典 以及自定义model
  [YFRouterGlobleInstance yf_executCallBackHandle:vcInstance andParams:@"这是回到回去的参数"];

```

## - 指定打开VC的方式

```objc
  /// yf_transitionsType 参数为一个枚举 目前只支持两种 push present
  /// yf_animated 指定转场是否需要动画
  /// 链式调用语法糖
  YFRouterGlobleInstance.yf_clsName(@"xxxVC").yf_transitionsType(YF_Transitions_present).yf_animated(YES).yf_done();
  ///这里常规方法调用不在举例
  ///链式调用可以更加灵活的 配置要打开VC的动作 传参or不传 有回调or没有 等。 
  ///注意！！ 链式调用最后必须执行 yf_done() 结束语，不然YFRouter并不知道你的跳转配置项是否结束，所以不会发起跳转。
```

## - 关于sdk log打印

```objc
//设置全局关闭log - 默认debug模式开启 release自动关闭
[[YFRouterManager shareInstance]setIsLog:NO];
```



## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

YFRouter is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

## 

```ruby
pod 'YFRouter'
```
## Author
reactfeng@gmail.com
## License

YFRouter is available under the MIT license. See the LICENSE file for more info.
