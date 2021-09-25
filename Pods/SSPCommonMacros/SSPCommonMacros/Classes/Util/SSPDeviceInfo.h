//
//  SSPDeviceInfo.h
//  AirPayCounter
//
//  Created by HuiCao on 2019/4/17.
//  Copyright © 2019 Shopee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define MIsiPhone [SSPDeviceInfo isiPhone]
#define MIsiPhoneXSeries [SSPDeviceInfo isiPhoneXSeries]

@interface SSPDeviceInfo : NSObject

/**
获取当前设备处理器架构

@return 对应符串
*/
+ (NSString *)modelPlatform;

/**
 获取当前设备信息
 参考链接：https://www.theiphonewiki.com/wiki/Models
 
 @return 对应字符串
*/
+ (NSString *)DModel;

/**
 获取当前设备名称（只获取当前设备的名称，不拼接其他信息，比如 ：iPhone X，iPhone XS）
 参考链接：https://www.theiphonewiki.com/wiki/Models
 
 @return 对应字符串
*/
+ (NSString *)deviceGenerationName;

/**
获取当前设备系统

@return 对应字符串
*/
+ (NSString *)DSystem;

/**
获取当前设备系统

@return 对应数值
*/
+ (double)GetiOSVersion;

/**
判断当前设备是否iPhone

@return 返回结果
*/
+ (BOOL)isiPhone;

/**
判断当前设备是否4S及以下

@return 返回结果
*/
+ (BOOL)isUnderiPhone4s;

/**
判断当前设备是否5S及以下

@return 返回结果
*/
+ (BOOL)isUnderiPhone5s;

/**
判断当前设备是否iPad

@return 返回结果
*/
+ (BOOL)isiPad;

/**
判断当前设备是否X系列

@return 返回结果
*/
+ (BOOL)isiPhoneXSeries;

/**
判断当前设备是否iOS7系统

@return 返回结果
*/
+ (BOOL)isiOS7;

/**
判断当前设备是否iOS8系统

@return 返回结果
*/
+ (BOOL)isiOS8;

/**
判断当前设备是否iOS8.2以上8系统

@return 返回结果
*/
+ (BOOL)isiOS8_2plus;

/**
判断当前设备是否iOS9系统

@return 返回结果
*/
+ (BOOL)isiOS9;

/**
判断当前设备是否iOS9以上系统

@return 返回结果
*/
+ (BOOL)isiOS9plus;

/**
判断当前设备是否iOS710系统

@return 返回结果
*/
+ (BOOL)isiOS10;

/**
判断当前设备是否iOS10以上系统

@return 返回结果
*/
+ (BOOL)isiOS10plus;

/**
判断当前设备是否iOS11系统

@return 返回结果
*/
+ (BOOL)isiOS11;

/**
判断当前设备是否iOS11以上系统

@return 返回结果
*/
+ (BOOL)isiOS11plus;

/**
判断当前设备是否越狱

@return 返回结果
*/
+ (BOOL)isJailBreak;

/// 返回当前可用内存大小, 单位 bytes
+ (NSUInteger)deviceFreeMemorySize;

@end

NS_ASSUME_NONNULL_END
