#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSObject+YFRouter.h"
#import "NSString+YFRouter.h"
#import "YFRouterManager.h"

FOUNDATION_EXPORT double YFRouterVersionNumber;
FOUNDATION_EXPORT const unsigned char YFRouterVersionString[];

