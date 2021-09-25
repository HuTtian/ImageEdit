//
//  SSPUIFontUtil.m
//  Pods-SSPCommonMacros_Example
//
//  Created by KaiChen on 2019/11/19.
//

#import "SSPUIFontUtil.h"

@implementation SSPUIFontUtil

+ (UIFont *)regularFontWithSize:(CGFloat)fontSize{
    return [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular];
}

+ (UIFont *)mediumFontWithSize:(CGFloat)fontSize{
    return [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium];
}

+ (UIFont *)lightFontWithSize:(CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize weight:UIFontWeightLight];
}

+ (UIFont *)semiBoldFontWithSize:(CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize weight:UIFontWeightSemibold];
}

+ (UIFont *)boldFontWithSize:(CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize weight:UIFontWeightBold];
}

@end
