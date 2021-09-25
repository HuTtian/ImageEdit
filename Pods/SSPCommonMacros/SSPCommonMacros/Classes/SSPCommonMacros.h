//
//  SSPCommonMacros.h
//  AirPayCounter
//
//  Created by ChaoFeng on 2019/4/22.
//  Copyright © 2019 Shopee. All rights reserved.
//

/**
     这个是SSPCommonMacros的公共头文件
 */

#ifndef SSPCommonMacros_h
#define SSPCommonMacros_h

#import <SSPCommonMacros/SSPUIColorUtil.h>
#import <SSPCommonMacros/SSPUIFontUtil.h>
#import <SSPCommonMacros/SSPDeviceInfo.h>
#import <SSPCommonMacros/SSPAssert.h>
#import <SSPCommonMacros/SSPUIUtil.h>
#import <SSPCommonMacros/SSPFileUtil.h>
#import <SSPCommonMacros/NSObject+SSPCommon.h>
#import <SSPCommonMacros/UIView+SSPExtend.h>
#import <SSPCommonMacros/SSPMacroConfigure.h>
#import <SSPCommonMacros/NSBundle+Extend.h>
#import <SSPCommonMacros/UIImage+Bundle.h>

// 屏幕底部的间距
#define SafeBottomMargin ([SSPDeviceInfo isiPhoneXSeries] ? 34.0f : 0.0f)

// 设置导航栏&状态栏颜色的时候 statusbar + navigateBar bkgView 高度
#define NavigationBarBkgViewHeight ([SSPUIUtil normalStatusBarHeight] + [SSPUIUtil navigationBarHeight])

// 屏幕除statusbar之外
#define MainHeight (MScreenHeight - MStatusBarHeight) // 竖屏时的界面高度
#define MainWidth  MScreenWidth

// 屏幕 适配 基准为  iPhone 8 尺寸
#define AutoScaleWidth(width) [SSPUIUtil convertLengthOn375:width]
#define AutoScaleHeight(height) [SSPUIUtil convertHeightOn667:height]

#define AutoScaleWidthRatio  (MScreenWidth/375)
#define AutoScaleHeightRatio (MScreenHeight/667)

#define SecondsPerDay 86400

#define AppMainWindow [[UIApplication sharedApplication] delegate].window

//空字符串判断
#define NULLString(string) ((string == nil) || ([string isKindOfClass:[NSNull class]]) || (![string isKindOfClass:[NSString class]])||[string isEqualToString:@""] || [string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]== 0 )

#define NOT_NULL_STRING(str, default) (NULLString(str) ? default : str)

//version号 包含三位版本号
#define SSPBundleVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
//build号 包含四位版本号
#define SSPBuildVersion [NSString stringWithFormat:@"%@%@%@",SSPBundleVersion,@".",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]]

#define SSPAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

//异步主队列执行
static inline void ssp_dispatch_async_mainQueue(void (^block)(void)) {
    if (0 == strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue()))){
        block();
    }else{
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

//同步主队列执行
static inline void ssp_dispatch_sync_mainQueue(void (^block)(void)) {
    if (0 == strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue()))){
        block();
    }else{
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

#define mweakify(val) \
m_ssp_keywordify \
m_weakify_(__weak, val)

#define m_weakify_(CONTEXT, VAR) \
CONTEXT __typeof__(VAR) VAR_weak_ = (VAR);

#define mstrongify(val) \
m_ssp_keywordify \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
m_strongify_(val) \
_Pragma("clang diagnostic pop")

#define m_strongify_(VAR) \
__strong __typeof__(VAR) VAR = VAR_weak_;

#define m_ssp_keywordify

#define m_safe_call_block(block,...) \
if (block) { \
block(__VA_ARGS__); \
}


#define m_safe_call_block_mainThread(block,...) \
do { \
if (block == nil) break; \
if ([[NSThread currentThread] isMainThread]) { \
block(__VA_ARGS__); \
} else { \
dispatch_async(dispatch_get_main_queue(), ^(){ \
block(__VA_ARGS__); \
}); \
} \
} while(0)

#endif /* SSPCommonMacros_h */
