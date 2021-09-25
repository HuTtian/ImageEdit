//
//  SSPUIColorUtil.m
//  Pods-SSPCommonMacros_Example
//
//  Created by KaiChen on 2019/11/19.
//

#import "SSPUIColorUtil.h"

@implementation SSPUIColorUtil

#pragma mark - Color
+ (UIColor *)getColorByName:(NSString *)colorName {
    if (colorName != nil && colorName.length > 0 && [colorName characterAtIndex:0] == '#') {
        UIColor *color = [SSPUIColorUtil parseColorFromValues:[NSArray arrayWithObject:colorName]];
        if (color != nil) {
            return color;
        }
    }
    return nil;
}

+ (UIColor *)getColorByName:(NSString *)colorName alpha:(CGFloat)alpha {
    UIColor *colorWithAlpha = nil;
    UIColor *color = [SSPUIColorUtil getColorByName:colorName];
    if (color) {
        colorWithAlpha = [color colorWithAlphaComponent:alpha];
    }
    return colorWithAlpha;
}

+ (UIColor *)colorWithRGBValue:(NSInteger)value {
    return MRGBACOLOR(((value & 0xFF0000) >> 16),
                     ((value & 0xFF00) >> 8),
                     (value & 0xFF),
                     1.0
                     );
}

#pragma mark - private
+ (UIColor *)parseColorFromValues:(NSArray*)hexValues {
    UIColor *retColor = nil;
    
    BOOL validCss = [hexValues count] == 1;
    if (!validCss) {
        return nil;
    }
    
    if ([hexValues count] == 1) {
        NSString* hexString = [hexValues firstObject];
        
        if ([hexString characterAtIndex:0] == '#') {
            unsigned long colorValue = 0;
            float alpha = 1;
            // #FFF
            if ([hexString length] == 4) {
                colorValue = strtol([hexString UTF8String] + 1, nil, 16);
                colorValue = ((colorValue & 0xF00) << 12) | ((colorValue & 0xF00) << 8)
                | ((colorValue & 0xF0) << 8) | ((colorValue & 0xF0) << 4)
                | ((colorValue & 0xF) << 4) | (colorValue & 0xF);
                
                // #FFFFFF
            } else if ([hexString length] == 7) {
                colorValue = strtol([hexString UTF8String] + 1, nil, 16);
            } else if ([hexString length] == 9) {
                alpha = strtol([[hexString substringFromIndex:7] UTF8String],nil,16) / 255.0;
                colorValue = strtol([[hexString substringToIndex:7] UTF8String] + 1, nil, 16);
            }
            
            retColor = MRGBACOLOR(((colorValue & 0xFF0000) >> 16),
                                 ((colorValue & 0xFF00) >> 8),
                                 (colorValue & 0xFF),
                                 alpha
                                 );
            
        } else if ([hexString isEqualToString:@"none"]) {
            retColor = nil;
        }
    }
    
    return retColor;
}

+ (UIColor *)getColorByAlphaColorString:(NSString *)colorString {
    if (!colorString || colorString.length < 7) {
        return nil;
    }
    if (colorString.length == 7) {/// 只传了颜色值，无透明度
        return [self getColorByName:colorString];
    }
    
    if (colorString.length != 9) {
        return nil;
    }
    /// 9位颜色值，前两位为alpha
    NSMutableString *statusColor = [[NSMutableString alloc]initWithString:colorString];
    NSString *alphaString = [statusColor substringWithRange:NSMakeRange(1, 2)];
    /// 将 十六进制 字符串 转为 十进制数值
    NSInteger alpha = strtoul(alphaString.UTF8String, 0, 16);
    [statusColor deleteCharactersInRange:NSMakeRange(1, 2)];
    
    return [self getColorByName:statusColor alpha:alpha / 100.0];
}

@end
