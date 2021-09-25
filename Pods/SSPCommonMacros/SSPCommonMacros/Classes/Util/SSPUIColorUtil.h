//
//  SSPUIColorUtil.h
//  Pods-SSPCommonMacros_Example
//
//  Created by KaiChen on 2019/11/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define MCOLOR(colorName) getColorOrClearColor([SSPUIColorUtil getColorByName:colorName])
#define MCOLOR_ALPHA(colorName,a) getColorOrClearColor([SSPUIColorUtil getColorByName:colorName alpha:a])
#define MRGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define MRGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define MHEXCOLOR(value) [SSPUIColorUtil colorWithRGBValue:value]
#define MCOLOR_ARGB(colorString) getColorOrClearColor([SSPUIColorUtil getColorByAlphaColorString:colorString])

CG_INLINE
UIColor *getColorOrClearColor(UIColor *color) {
    if (nil == color) {
        return [UIColor clearColor];
    }
    return color;
}

@interface SSPUIColorUtil : NSObject

/**
根据十六进制字符串生成颜色
 eg. #FFFFFF

 @param colorName 对应颜色字符串
 @return 对应颜色
*/
+ (UIColor *)getColorByName:(NSString *)colorName;

/**
根据十六进制字符串生成带透明通道颜色
 eg. #FFFFFF

 @param colorName 对应颜色字符串
 @param alpha 透明度
 @return 对应颜色
*/
+ (UIColor *)getColorByName:(NSString *)colorName alpha:(CGFloat)alpha;

/**
根据十六进制字符串生成颜色
 eg. #FFFFFF

 @param value 对应颜色十六进制数值
 @return 对应颜色
*/
+ (UIColor *)colorWithRGBValue:(NSInteger)value;


/**
根据 透明度 加 十六进制字符串 生成颜色 （只接受7位或者9位十六进制字符串）
 eg. #FFFFFFFF  ARGB格式
  
 @param colorString 对应透明度加颜色十六进制数值
 @return 对应颜色
*/
+ (UIColor *)getColorByAlphaColorString:(NSString *)colorString;
@end

NS_ASSUME_NONNULL_END
