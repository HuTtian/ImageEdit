//
//  SSPUIFontUtil.h
//  Pods-SSPCommonMacros_Example
//
//  Created by KaiChen on 2019/11/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//字体定义
#define MRegularFont(size)   [SSPUIFontUtil regularFontWithSize:size]
#define MMediumFont(size)    [SSPUIFontUtil mediumFontWithSize:size]
#define MLightFont(size)     [SSPUIFontUtil lightFontWithSize:size]
#define MSemiboldFont(size)  [SSPUIFontUtil semiBoldFontWithSize:size]
#define MBoldFont(size)      [SSPUIFontUtil boldFontWithSize:size]

@interface SSPUIFontUtil : NSObject

+ (UIFont *)regularFontWithSize:(CGFloat)fontSize;

+ (UIFont *)mediumFontWithSize:(CGFloat)fontSize;

+ (UIFont *)lightFontWithSize:(CGFloat)fontSize;

+ (UIFont *)semiBoldFontWithSize:(CGFloat)fontSize;

+ (UIFont *)boldFontWithSize:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
