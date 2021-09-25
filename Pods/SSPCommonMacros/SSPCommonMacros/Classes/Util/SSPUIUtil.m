//
//  SSPUIUtil.m
//  AirPayCounter
//
//  Created by HuiCao on 2019/4/17.
//  Copyright © 2019 Shopee. All rights reserved.
//

#import "SSPUIUtil.h"
#import "SSPDeviceInfo.h"

@implementation SSPUIUtil

+ (UIImage *)imageNamed:(NSString *)imgName {
    if (imgName.length <= 0) {
        return [UIImage new];
    }
    return [UIImage imageNamed:imgName];
}

+ (CGFloat)statusBarHeight {
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

+ (CGFloat)normalStatusBarHeight {
    CGFloat statusBarHeight = [SSPUIUtil statusBarHeight];
    if (statusBarHeight == 40) {
        return 20;
    }
    if (statusBarHeight == 0) {
        return 20;
    }
    return statusBarHeight;
}

+ (CGFloat)navigationBarHeight {
    return 44.0;
}

+ (CGFloat)tabBarHeight {
    //Pre-iPhone X default tab bar height: 49pt
    //iPhone X default tab bar height: 83pt
    if (MIsiPhoneXSeries) {
        return 83.0;
    }
    return 49.0;
}

+ (CGFloat)screenWidthCurOrientation {
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat mainWindowWidth = [SSPUIUtil mainWindowWidth];
    if (screenWidth != mainWindowWidth && UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) && mainWindowWidth > 0)
    {
        return mainWindowWidth;
    }
    return screenWidth;
}

+ (CGFloat)screenHeightCurOrientation {
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat mainWindowHeight = [SSPUIUtil mainWindowHeight];
    if (screenHeight != mainWindowHeight && UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) && mainWindowHeight > 0)
    {
        return mainWindowHeight;
    }
    return screenHeight;
}

+ (CGFloat)convertLengthOn375:(CGFloat)originLength {
    return ceil(originLength * [self screenWidthCurOrientation]/375.0);
}

+ (CGFloat)convertHeightOn667:(CGFloat)originLength {
    return ceil(originLength * [self screenHeightCurOrientation]/667.0);
}

+ (CGFloat)safeBottomHeight {
    CGFloat bottomInset = 0;
    if (MIsiPhoneXSeries) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if (UIDeviceOrientationIsPortrait(orientation)) {
            bottomInset = 34;
        } else {
            bottomInset = 21;
        }
    }
    return bottomInset;
}

+ (UIWindow *)appMainWindow {
    UIWindow *appWindow = nil;
    if ([[[UIApplication sharedApplication] delegate] respondsToSelector:@selector(window)]) {
        appWindow = [[[UIApplication sharedApplication] delegate] window];
    }else {
        appWindow = [[UIApplication sharedApplication] keyWindow];
    }
    return appWindow;
}

+ (id<UIApplicationDelegate>)appDelegate {
    return [[UIApplication sharedApplication] delegate];
}

#pragma mark - private
+ (CGFloat)mainWindowHeight {
    return [[UIApplication sharedApplication] delegate].window.bounds.size.height;
}

+ (CGFloat)mainWindowWidth {
    return [[UIApplication sharedApplication] delegate].window.bounds.size.width;
}
@end
