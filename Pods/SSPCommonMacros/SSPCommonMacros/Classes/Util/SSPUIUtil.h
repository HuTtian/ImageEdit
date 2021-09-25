//
//  SSPUIUtil.h
//  AirPayCounter
//
//  Created by HuiCao on 2019/4/17.
//  Copyright © 2019 Shopee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define MAppMainWindow [SSPUIUtil appMainWindow]
#define MAppDelegate [SSPUIUtil appDelegate]

#define MIMAGE(image) [SSPUIUtil imageNamed:image]

#define MScreenHeight [SSPUIUtil screenHeightCurOrientation]      // 竖屏时的高度
#define MScreenWidth  [SSPUIUtil screenWidthCurOrientation]       // 横屏时的宽度

#define MStatusBarHeight     [SSPUIUtil statusBarHeight]          // 状态栏高度
#define MNavigationBarHeight [SSPUIUtil navigationBarHeight]      // 竖屏时的导航栏高度
#define MTopBarHeight        ([SSPUIUtil statusBarHeight] + [SSPUIUtil navigationBarHeight])  //竖屏时状态栏高度+导航栏高度
#define MTabBarHeight        [SSPUIUtil tabBarHeight]             // tabBar高度

#define MDefaultSeparatorLineHeight (2.0/[UIScreen mainScreen].scale) //默认线的高度

@interface SSPUIUtil : NSObject

/**
 状态栏高度
 
 @return 对应数值
 */
+ (CGFloat)statusBarHeight;

/**
 正常的状态栏高度（排除呼叫状态栏）
 
 @return 对应数值
 */
+ (CGFloat)normalStatusBarHeight;

/**
 navigationBar的高度，目前为写死44
 
 @return 对应数值
 */
+ (CGFloat)navigationBarHeight;

/**
 tabbar的高度，目前是取的tabBar默认值默认49，X是83
 @return 对应数值
 */
+ (CGFloat)tabBarHeight;

/**
 屏幕宽度，优先取keywindow的宽度，否则为UIScreen的宽度
 @return 对应数值
 */
+ (CGFloat)screenWidthCurOrientation;

/**
 屏幕高度，优先取keywindow的高度，否则为UIScreen的高度
 @return 对应数值
 */
+ (CGFloat)screenHeightCurOrientation;

/**
 基于375宽度转换在当前设备的对应尺寸
 @param originLength 基于375的长度
 @return 基于当前设备的长度
 */
+ (CGFloat)convertLengthOn375:(CGFloat)originLength;

/**
 基于667高度转换在当前设备的对应尺寸
 @param originLength 基于667的长度
 @return 基于当前设备的长度
 */
+ (CGFloat)convertHeightOn667:(CGFloat)originLength;

/**
 距离底部的间距，竖屏34，横屏21
 @return 对应数值
 */
+ (CGFloat)safeBottomHeight;

/**
 获取图片
 */
+ (UIImage *)imageNamed:(NSString *)imgName;

/**
 获取App的主window
 */
+ (UIWindow * _Nullable)appMainWindow;

/**
 获取App的delegate
 */
+ (id<UIApplicationDelegate> _Nullable)appDelegate;

@end

NS_ASSUME_NONNULL_END
