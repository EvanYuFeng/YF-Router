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


## How to use
- 直接打开目标VC 不带参数 不带回调
    ```Object-C
    <!-- 常规方法调用 -->
    [YFRouterGlobleInstance yf_openVCWithName:@"xxxVC"];
     <!-- 语法糖 -->
     YFRouterGlobleInstance.yf_clsName(@"xxxVC").yf_done();
    ```


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

YFRouter is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'YFRouter'
```

## Author

iosyufeng@sina.com, iosyufeng@sina.com

## License

YFRouter is available under the MIT license. See the LICENSE file for more info.
