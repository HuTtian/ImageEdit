//
//  SSPDeviceInfo.m
//  AirPayCounter
//
//  Created by HuiCao on 2019/4/17.
//  Copyright © 2019 Shopee. All rights reserved.
//

#import "SSPDeviceInfo.h"
#import <UIKit/UIDevice.h>
#include <sys/sysctl.h>
#import <mach/mach.h>
#import "SSPUIUtil.h"

@interface UIDevice(SSPHardware)

+ (NSString *)ssp_getSysInfoByName:(char *)typeSpeifier;
- (NSString *)platform;

@end

@implementation UIDevice(SSPHardware)

+ (NSString *)ssp_getSysInfoByName:(char *)typeSpeifier {
    size_t size;
    sysctlbyname(typeSpeifier, NULL, &size, NULL, 0);
    char *answer = (char *)malloc(size);
    sysctlbyname(typeSpeifier, answer, &size, NULL, 0);
    NSString *results = [NSString stringWithCString:answer encoding:NSUTF8StringEncoding];
    if(results == nil){
        results = @"";
    }
    free(answer);
    return results;
}

- (NSString *)platform {
    return [UIDevice ssp_getSysInfoByName:(char *)"hw.machine"];
}

@end

@implementation SSPDeviceInfo

+ (NSString *)modelPlatform {
    return [UIDevice currentDevice].platform;
}

+ (NSString *)DModel {
    NSString *nsModel = nil;
    NSString *nsPlatForm = [UIDevice currentDevice].platform;
    if ([nsPlatForm hasPrefix:@"iPhone1,1"]) {
        nsModel = [NSString stringWithFormat:@"iPhone(WiFi,GSM)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone1,2"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 3G(WiFi,GSM,WCDMA)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone2,1"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 3GS(WiFi,GSM,WCDMA)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone3,1"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 4(WiFi,GSM,WCDMA)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone3,2"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 4 Proto(WiFi,GSM,WCDMA,CDMA2000)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone3,3"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 4(WiFi,GSM,WCDMA,CDMA2000)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone4,1"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 4S(WiFi,GSM,WCDMA,CDMA2000)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone5,1"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 5(WiFi,GSM,WCDMA,LTE)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone5,2"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 5(WiFi,GSM,WCDMA,CDMA2000,LTE)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone5,3"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 5c (GSM)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone5,4"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 5c (GSM+CDMA)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone6,1"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 5s (GSM)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone6,2"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 5s (GSM+CDMA)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone7,1"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 6 Plus<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone7,2"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 6<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone8,1"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 6s<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone8,2"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 6s Plus<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone8,4"]) {
        nsModel = [NSString stringWithFormat:@"iPhone SE<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone9,1"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 7<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone9,2"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 7 Plus<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone9,3"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 7<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone9,4"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 7 Plus<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone10,1"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 8 (GSM+CDMA)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone10,2"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 8 Plus (GSM+CDMA)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone10,3"]) {
        nsModel = [NSString stringWithFormat:@"iPhone X (GSM+CDMA)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone10,4"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 8 (GSM)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone10,5"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 8 Plus (GSM)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone10,6"]) {
        nsModel = [NSString stringWithFormat:@"iPhone X (GSM)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone11,1"]) {
        nsModel = [NSString stringWithFormat:@"iPhone XR (GSM+CDMA)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone11,2"]) {
        nsModel = [NSString stringWithFormat:@"iPhone XS (GSM+CDMA)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone11,3"]) {
        nsModel = [NSString stringWithFormat:@"iPhone XS (GSM)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone11,4"]) {
        nsModel = [NSString stringWithFormat:@"iPhone XS Max (GSM+CDMA)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone11,5"]) {
        nsModel = [NSString stringWithFormat:@"iPhone XS Max (GSM, Dual Sim, China)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone11,6"]) {
        nsModel = [NSString stringWithFormat:@"iPhone XS Max (GSM)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone11,8"]) {
        nsModel = [NSString stringWithFormat:@"iPhone XR (GSM)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone12,1"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 11 <%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone12,3"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 11 Pro <%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone12,5"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 11 Pro Max <%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone13,1"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 12 mini <%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone13,2"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 12 <%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone13,3"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 12 Pro <%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPhone13,4"]) {
        nsModel = [NSString stringWithFormat:@"iPhone 12 Pro Max <%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPod1,1"]) {
        nsModel = [NSString stringWithFormat:@"iPod Touch 1th(WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPod2,1"]) {
        nsModel = [NSString stringWithFormat:@"iPod Touch 2th(WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPod3,1"]) {
        nsModel = [NSString stringWithFormat:@"iPod Touch 3th(WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPod4,1"]) {
        nsModel = [NSString stringWithFormat:@"iPod Touch 4th(WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPod5,1"]) {
        nsModel = [NSString stringWithFormat:@"iPod Touch 5th(WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPod7,1"]) {
        nsModel = [NSString stringWithFormat:@"iPod Touch 6th(WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPod9,1"]) {
        nsModel = [NSString stringWithFormat:@"iPod Touch 7th(WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad1,1"]) {
        nsModel = [NSString stringWithFormat:@"iPad(WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad1,2"]) {
        nsModel = [NSString stringWithFormat:@"iPad(WiFi,GSM,WCDMA)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad2,1"]) {
        nsModel = [NSString stringWithFormat:@"iPad 2(WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad2,2"]) {
        nsModel = [NSString stringWithFormat:@"iPad 2(WiFi,GSM,WCDMA)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad2,3"]) {
        nsModel = [NSString stringWithFormat:@"iPad 2(WiFi,CDMA2000)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad2,4"]) {
        nsModel = [NSString stringWithFormat:@"iPad 2 A1395<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad2,5"]) {
        nsModel = [NSString stringWithFormat:@"iPad mini(WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad2,6"]) {
        nsModel = [NSString stringWithFormat:@"iPad mini(WiFi,GSM,WCDMA,LTE)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad2,7"]) {
        nsModel = [NSString stringWithFormat:@"iPad mini(WiFi,GSM,WCDMA,CDMA2000,LTE)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad3,1"]) {
        nsModel = [NSString stringWithFormat:@"new iPad 3(WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad3,2"]) {
        nsModel = [NSString stringWithFormat:@"new iPad 3(WiFi,GSM,WCDMA,LTE)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad3,3"]) {
        nsModel = [NSString stringWithFormat:@"new iPad 3(WiFi,GSM,WCDMA,CDMA2000,LTE)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad3,4"]) {
        nsModel = [NSString stringWithFormat:@"new iPad 4(WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad3,5"]) {
        nsModel = [NSString stringWithFormat:@"new iPad 4(WiFi,GSM,WCDMA,LTE)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad3,6"]) {
        nsModel = [NSString stringWithFormat:@"new iPad 4(WiFi,GSM,WCDMA,CDMA2000,LTE)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad4,1"]) {
        nsModel = [NSString stringWithFormat:@"iPad Air (WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad4,2"]) {
        nsModel = [NSString stringWithFormat:@"iPad Air (Cellular)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad4,3"]) {
        nsModel = [NSString stringWithFormat:@"iPad Air<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad4,4"]) {
        nsModel = [NSString stringWithFormat:@"iPad Mini 2G (WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad4,5"]) {
        nsModel = [NSString stringWithFormat:@"iPad Mini 2G (Cellular)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad4,6"]) {
        nsModel = [NSString stringWithFormat:@"iPad Mini 2G<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad4,7"]) {
        nsModel = [NSString stringWithFormat:@"iPad Mini 3 (WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad4,8"]) {
        nsModel = [NSString stringWithFormat:@"iPad Mini 3 (Cellular)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad4,9"]) {
        nsModel = [NSString stringWithFormat:@"iPad Mini 3 (China)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad5,1"]) {
        nsModel = [NSString stringWithFormat:@"iPad mini 4 (WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad5,2"]) {
        nsModel = [NSString stringWithFormat:@"iPad mini 4 (Cellular)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad5,3"]) {
        nsModel = [NSString stringWithFormat:@"iPad Air 2 (WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad5,4"]) {
        nsModel = [NSString stringWithFormat:@"iPad Air 2 (Cellular)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad6,3"]) {
        nsModel = [NSString stringWithFormat:@"iPad Pro A1673 (WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad6,4"]) {
        nsModel = [NSString stringWithFormat:@"iPad Pro A1675 (WiFi+LTE)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad6,7"]) {
        nsModel = [NSString stringWithFormat:@"iPad Pro A1584 (WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad6,8"]) {
        nsModel = [NSString stringWithFormat:@"iPad Pro A1652 (WiFi+LTE)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad6,11"]) {
        nsModel = [NSString stringWithFormat:@"iPad A1822 <%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad6,12"]) {
        nsModel = [NSString stringWithFormat:@"iPad A1823 <%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad7,1"]) {
        nsModel = [NSString stringWithFormat:@"iPad Pro 2nd Gen (WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad7,2"]) {
        nsModel = [NSString stringWithFormat:@"iPad Pro 2nd Gen (Cellular)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad7,3"]) {
        nsModel = [NSString stringWithFormat:@"iPad Pro A1701 <%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad7,4"]) {
        nsModel = [NSString stringWithFormat:@"iPad Pro A1709 <%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad7,5"]) {
        nsModel = [NSString stringWithFormat:@"iPad 6th Gen (WiFi) <%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad7,6"]) {
        nsModel = [NSString stringWithFormat:@"iPad 6th Gen (Cellular) <%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad7,11"]) {
        nsModel = [NSString stringWithFormat:@"iPad A2197 <%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad7,12"]) {
        nsModel = [NSString stringWithFormat:@"iPad A2200 <%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad8,1"]) {
        nsModel = [NSString stringWithFormat:@"iPad Pro 3rd Gen A1980 (WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad8,2"]) {
        nsModel = [NSString stringWithFormat:@"iPad Pro 3rd Gen A1934 (WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad8,3"]) {
        nsModel = [NSString stringWithFormat:@"iPad Pro 3rd Gen (Cellular)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad8,4"]) {
        nsModel = [NSString stringWithFormat:@"iPad Pro 3rd Gen (Cellular)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad8,5"]) {
        nsModel = [NSString stringWithFormat:@"iPad Pro 3rd Gen (WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad8,6"]) {
        nsModel = [NSString stringWithFormat:@"iPad Pro 3rd Gen (WiFi)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad8,7"]) {
        nsModel = [NSString stringWithFormat:@"iPad Pro 3rd Gen (Cellular)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad8,8"]) {
        nsModel = [NSString stringWithFormat:@"iPad Pro 3rd Gen (Cellular)<%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad11,3"]) {
        nsModel = [NSString stringWithFormat:@"iPad Air 3rd Gen (WiFi) <%@>", nsPlatForm];
    } else if ([nsPlatForm hasPrefix:@"iPad11,4"]) {
        nsModel = [NSString stringWithFormat:@"iPad Air 3rd Gen <%@>", nsPlatForm];
    } else {
        nsModel = [NSString stringWithFormat:@"unknown<%@>", nsPlatForm];
    }
    
    return nsModel;
}

+ (NSString *)deviceGenerationName {
    NSString *nsModel = nil;
    NSString *nsPlatForm = [UIDevice currentDevice].platform;
    if ([nsPlatForm hasPrefix:@"iPhone1,1"]) {
        nsModel = @"iPhone";
    } else if ([nsPlatForm hasPrefix:@"iPhone1,2"]) {
        nsModel = @"iPhone 3G";
    } else if ([nsPlatForm hasPrefix:@"iPhone2,1"]) {
        nsModel = @"iPhone 3GS";
    } else if ([nsPlatForm hasPrefix:@"iPhone3,1"]) {
        nsModel = @"iPhone 4";
    } else if ([nsPlatForm hasPrefix:@"iPhone3,2"]) {
        nsModel = @"iPhone 4 Proto";
    } else if ([nsPlatForm hasPrefix:@"iPhone3,3"]) {
        nsModel = @"iPhone 4";
    } else if ([nsPlatForm hasPrefix:@"iPhone4,1"]) {
        nsModel = @"iPhone 4S";
    } else if ([nsPlatForm hasPrefix:@"iPhone5,1"]) {
        nsModel = @"iPhone 5";
    } else if ([nsPlatForm hasPrefix:@"iPhone5,2"]) {
        nsModel = @"iPhone 5";
    } else if ([nsPlatForm hasPrefix:@"iPhone5,3"]) {
        nsModel = @"iPhone 5c";
    } else if ([nsPlatForm hasPrefix:@"iPhone5,4"]) {
        nsModel = @"iPhone 5c";
    } else if ([nsPlatForm hasPrefix:@"iPhone6,1"]) {
        nsModel = @"iPhone 5s";
    } else if ([nsPlatForm hasPrefix:@"iPhone6,2"]) {
        nsModel = @"iPhone 5s";
    } else if ([nsPlatForm hasPrefix:@"iPhone7,1"]) {
        nsModel = @"iPhone 6 Plus";
    } else if ([nsPlatForm hasPrefix:@"iPhone7,2"]) {
        nsModel = @"iPhone 6";
    } else if ([nsPlatForm hasPrefix:@"iPhone8,1"]) {
        nsModel = @"iPhone 6s";
    } else if ([nsPlatForm hasPrefix:@"iPhone8,2"]) {
        nsModel = @"iPhone 6s Plus";
    } else if ([nsPlatForm hasPrefix:@"iPhone8,4"]) {
        nsModel = @"iPhone SE";
    } else if ([nsPlatForm hasPrefix:@"iPhone9,1"]) {
        nsModel = @"iPhone 7";
    } else if ([nsPlatForm hasPrefix:@"iPhone9,2"]) {
        nsModel = @"iPhone 7 Plus";
    } else if ([nsPlatForm hasPrefix:@"iPhone9,3"]) {
        nsModel = @"iPhone 7";
    } else if ([nsPlatForm hasPrefix:@"iPhone9,4"]) {
        nsModel = @"iPhone 7 Plus";
    } else if ([nsPlatForm hasPrefix:@"iPhone10,1"]) {
        nsModel = @"iPhone 8";
    } else if ([nsPlatForm hasPrefix:@"iPhone10,2"]) {
        nsModel = @"iPhone 8 Plus";
    } else if ([nsPlatForm hasPrefix:@"iPhone10,3"]) {
        nsModel = @"iPhone X";
    } else if ([nsPlatForm hasPrefix:@"iPhone10,4"]) {
        nsModel = @"iPhone 8";
    } else if ([nsPlatForm hasPrefix:@"iPhone10,5"]) {
        nsModel = @"iPhone 8 Plus";
    } else if ([nsPlatForm hasPrefix:@"iPhone10,6"]) {
        nsModel = @"iPhone X";
    } else if ([nsPlatForm hasPrefix:@"iPhone11,1"]) {
        nsModel = @"iPhone XR";
    } else if ([nsPlatForm hasPrefix:@"iPhone11,2"]) {
        nsModel = @"iPhone XS";
    } else if ([nsPlatForm hasPrefix:@"iPhone11,3"]) {
        nsModel = @"iPhone XS";
    } else if ([nsPlatForm hasPrefix:@"iPhone11,4"]) {
        nsModel = @"iPhone XS Max";
    } else if ([nsPlatForm hasPrefix:@"iPhone11,5"]) {
        nsModel = @"iPhone XS Max";
    } else if ([nsPlatForm hasPrefix:@"iPhone11,6"]) {
        nsModel = @"iPhone XS Max";
    } else if ([nsPlatForm hasPrefix:@"iPhone11,8"]) {
        nsModel = @"iPhone XR";
    } else if ([nsPlatForm hasPrefix:@"iPhone12,1"]) {
        nsModel = @"iPhone 11";
    } else if ([nsPlatForm hasPrefix:@"iPhone12,3"]) {
        nsModel = @"iPhone 11 Pro";
    } else if ([nsPlatForm hasPrefix:@"iPhone12,5"]) {
        nsModel = @"iPhone 11 Pro Max";
    } else if ([nsPlatForm hasPrefix:@"iPhone13,1"]) {
        nsModel = @"iPhone 12 mini";
    } else if ([nsPlatForm hasPrefix:@"iPhone13,2"]) {
        nsModel = @"iPhone 12";
    } else if ([nsPlatForm hasPrefix:@"iPhone13,3"]) {
        nsModel = @"iPhone 12 Pro";
    } else if ([nsPlatForm hasPrefix:@"iPhone13,4"]) {
        nsModel = @"iPhone 12 Pro Max";
    } else if ([nsPlatForm hasPrefix:@"iPod1,1"]) {
        nsModel = @"iPod Touch 1th";
    } else if ([nsPlatForm hasPrefix:@"iPod2,1"]) {
        nsModel = @"iPod Touch 2th";
    } else if ([nsPlatForm hasPrefix:@"iPod3,1"]) {
        nsModel = @"iPod Touch 3th";
    } else if ([nsPlatForm hasPrefix:@"iPod4,1"]) {
        nsModel = @"iPod Touch 4th";
    } else if ([nsPlatForm hasPrefix:@"iPod5,1"]) {
        nsModel = @"iPod Touch 5th";
    } else if ([nsPlatForm hasPrefix:@"iPod7,1"]) {
        nsModel = @"iPod Touch 6th";
    } else if ([nsPlatForm hasPrefix:@"iPod9,1"]) {
        nsModel = @"iPod Touch 7th";
    } else if ([nsPlatForm hasPrefix:@"iPad1,1"]) {
        nsModel = @"iPad";
    } else if ([nsPlatForm hasPrefix:@"iPad1,2"]) {
        nsModel = @"iPad";
    } else if ([nsPlatForm hasPrefix:@"iPad2,1"]) {
        nsModel = @"iPad 2";
    } else if ([nsPlatForm hasPrefix:@"iPad2,2"]) {
        nsModel = @"iPad 2";
    } else if ([nsPlatForm hasPrefix:@"iPad2,3"]) {
        nsModel = @"iPad 2";
    } else if ([nsPlatForm hasPrefix:@"iPad2,4"]) {
        nsModel = @"iPad 2 A1395";
    } else if ([nsPlatForm hasPrefix:@"iPad2,5"]) {
        nsModel = @"iPad mini";
    } else if ([nsPlatForm hasPrefix:@"iPad2,6"]) {
        nsModel = @"iPad mini";
    } else if ([nsPlatForm hasPrefix:@"iPad2,7"]) {
        nsModel = @"iPad mini";
    } else if ([nsPlatForm hasPrefix:@"iPad3,1"]) {
        nsModel = @"new iPad 3";
    } else if ([nsPlatForm hasPrefix:@"iPad3,2"]) {
        nsModel = @"new iPad 3";
    } else if ([nsPlatForm hasPrefix:@"iPad3,3"]) {
        nsModel = @"new iPad 3";
    } else if ([nsPlatForm hasPrefix:@"iPad3,4"]) {
        nsModel = @"new iPad 4";
    } else if ([nsPlatForm hasPrefix:@"iPad3,5"]) {
        nsModel = @"new iPad 4";
    } else if ([nsPlatForm hasPrefix:@"iPad3,6"]) {
        nsModel = @"new iPad 4";
    } else if ([nsPlatForm hasPrefix:@"iPad4,1"]) {
        nsModel = @"iPad Air";
    } else if ([nsPlatForm hasPrefix:@"iPad4,2"]) {
        nsModel = @"iPad Air (Cellular)";
    } else if ([nsPlatForm hasPrefix:@"iPad4,3"]) {
        nsModel = @"iPad Air";
    } else if ([nsPlatForm hasPrefix:@"iPad4,4"]) {
        nsModel = @"iPad Mini 2G";
    } else if ([nsPlatForm hasPrefix:@"iPad4,5"]) {
        nsModel = @"iPad Mini 2G";
    } else if ([nsPlatForm hasPrefix:@"iPad4,6"]) {
        nsModel = @"iPad Mini 2G";
    } else if ([nsPlatForm hasPrefix:@"iPad4,7"]) {
        nsModel = @"iPad Mini 3";
    } else if ([nsPlatForm hasPrefix:@"iPad4,8"]) {
        nsModel = @"iPad Mini 3";
    } else if ([nsPlatForm hasPrefix:@"iPad4,9"]) {
        nsModel = @"iPad Mini 3 (China)";
    } else if ([nsPlatForm hasPrefix:@"iPad5,1"]) {
        nsModel = @"iPad mini 4";
    } else if ([nsPlatForm hasPrefix:@"iPad5,2"]) {
        nsModel = @"iPad mini 4";
    } else if ([nsPlatForm hasPrefix:@"iPad5,3"]) {
        nsModel = @"iPad Air 2";
    } else if ([nsPlatForm hasPrefix:@"iPad5,4"]) {
        nsModel = @"iPad Air 2";
    } else if ([nsPlatForm hasPrefix:@"iPad6,3"]) {
        nsModel = @"iPad Pro A1673";
    } else if ([nsPlatForm hasPrefix:@"iPad6,4"]) {
        nsModel = @"iPad Pro A1675";
    } else if ([nsPlatForm hasPrefix:@"iPad6,7"]) {
        nsModel = @"iPad Pro A1584";
    } else if ([nsPlatForm hasPrefix:@"iPad6,8"]) {
        nsModel = @"iPad Pro A1652";
    } else if ([nsPlatForm hasPrefix:@"iPad6,11"]) {
        nsModel = @"iPad A1822";
    } else if ([nsPlatForm hasPrefix:@"iPad6,12"]) {
        nsModel = @"iPad A1823";
    } else if ([nsPlatForm hasPrefix:@"iPad7,1"]) {
        nsModel = @"iPad Pro 2nd Gen";
    } else if ([nsPlatForm hasPrefix:@"iPad7,2"]) {
        nsModel = @"iPad Pro 2nd Gen";
    } else if ([nsPlatForm hasPrefix:@"iPad7,3"]) {
        nsModel = @"iPad Pro A1701";
    } else if ([nsPlatForm hasPrefix:@"iPad7,4"]) {
        nsModel = @"iPad Pro A1709";
    } else if ([nsPlatForm hasPrefix:@"iPad7,5"]) {
        nsModel = @"iPad 6th Gen";
    } else if ([nsPlatForm hasPrefix:@"iPad7,6"]) {
        nsModel = @"iPad 6th Gen";
    } else if ([nsPlatForm hasPrefix:@"iPad7,11"]) {
        nsModel = @"iPad A2197";
    } else if ([nsPlatForm hasPrefix:@"iPad7,12"]) {
        nsModel = @"iPad A2200";
    } else if ([nsPlatForm hasPrefix:@"iPad8,1"]) {
        nsModel = @"iPad Pro 3rd Gen A1980";
    } else if ([nsPlatForm hasPrefix:@"iPad8,2"]) {
        nsModel = @"iPad Pro 3rd Gen A1934";
    } else if ([nsPlatForm hasPrefix:@"iPad8,3"]) {
        nsModel = @"iPad Pro 3rd Gen";
    } else if ([nsPlatForm hasPrefix:@"iPad8,4"]) {
        nsModel = @"iPad Pro 3rd Gen";
    } else if ([nsPlatForm hasPrefix:@"iPad8,5"]) {
        nsModel = @"iPad Pro 3rd Gen";
    } else if ([nsPlatForm hasPrefix:@"iPad8,6"]) {
        nsModel = @"iPad Pro 3rd Gen";
    } else if ([nsPlatForm hasPrefix:@"iPad8,7"]) {
        nsModel = @"iPad Pro 3rd Gen";
    } else if ([nsPlatForm hasPrefix:@"iPad8,8"]) {
        nsModel = @"iPad Pro 3rd Gen";
    } else if ([nsPlatForm hasPrefix:@"iPad11,3"]) {
        nsModel = @"iPad Air 3rd Gen";
    } else if ([nsPlatForm hasPrefix:@"iPad11,4"]) {
        nsModel = @"iPad Air 3rd Gen";
    } else {
        nsModel = @"unknown";
    }
    
    return nsModel;
}

+ (NSString *)DSystem {
    NSString *nsSystem = [NSString stringWithFormat:@"%@ %@",
                          [UIDevice currentDevice].systemName,
                          [UIDevice currentDevice].systemVersion];
    return nsSystem;
}

+ (double) GetiOSVersion {
    return getiOSVersion();
}

+ (BOOL)isiPhone {
    static BOOL s_isiPhone = NO;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *nsModel = [UIDevice currentDevice].model;
        s_isiPhone = [nsModel hasPrefix:@"iPhone"];
    });
    
    return s_isiPhone;
}

+ (BOOL)isUnderiPhone4s {
    return [SSPDeviceInfo isiPhone4S] || [SSPDeviceInfo isiPhone4] || [SSPDeviceInfo isiPhone3GS] || [SSPDeviceInfo isiPhone3G] || [SSPDeviceInfo isiPhone2G];
}

+ (BOOL)isUnderiPhone5s {
    return [SSPDeviceInfo isUnderiPhone4s] || [SSPDeviceInfo isiPhone5S] || [SSPDeviceInfo isiPhone5C] || [SSPDeviceInfo isiPhone5];
}

+ (BOOL)isiPad {
    static BOOL s_isiPad = NO;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *nsModel = [UIDevice currentDevice].model;
        s_isiPad = [nsModel hasPrefix:@"iPad"];
    });
    return s_isiPad;
}

+ (BOOL)isiPhoneXSeries {
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return NO;
    }
    // 根据安全区域判断
    if (@available(iOS 11.0, *)) {
       return [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0;
    }
    return NO;
}

+ (BOOL)isiOS7 {
    if  (getiOSVersion() > 6.9 && getiOSVersion() < 7.9) {
        return YES;
    }
    return NO;
}

+ (BOOL)isiOS8 {
    if  (getiOSVersion() > 7.9 && getiOSVersion() < 8.9) {
        return YES;
    }
    return NO;
}

+ (BOOL)isiOS8_2plus {
    if (getiOSVersion() > 8.19) {
        return YES;
    }
    return NO;
}

+ (BOOL)isiOS9 {
    if  (getiOSVersion() > 8.9 && getiOSVersion() < 9.9) {
        return YES;
    }
    return NO;
}

+ (BOOL)isiOS9plus {
    if (getiOSVersion() > 8.9) {
        return YES;
    }
    return NO;
}

+ (BOOL)isiOS10 {
    if (getiOSVersion() > 9.9 && getiOSVersion() < 10.9) {
        return YES;
    }
    return NO;
}

+ (BOOL)isiOS10plus {
    if (getiOSVersion() > 9.9) {
        return YES;
    }
    return NO;
}

+ (BOOL)isiOS11 {
    if (getiOSVersion() > 10.9 && getiOSVersion() < 11.9) {
        return YES;
    }
    return NO;
}

+ (BOOL)isiOS11plus {
    if (getiOSVersion() > 10.9) {
        return YES;
    }
    return NO;
}

+ (BOOL)isJailBreak {
    __block BOOL jailBreak = NO;
    NSArray *fileList = @[@"/Applications/Cydia.app",@"/private/var/lib/apt",@"/usr/lib/system/libsystem_kernel.dylib",@"Library/MobileSubstrate/MobileSubstrate.dylib",@"/etc/apt"];
    [fileList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:obj];
        if ([obj isEqualToString:@"/usr/lib/system/libsystem_kernel.dylib"]) {
            jailBreak |= !fileExist;
        }else {
            jailBreak |= fileExist;
        }
    }];
    return jailBreak;
}

#pragma mark - private
double g_iOSVersion = 0;
double getiOSVersion() {
    if (g_iOSVersion < 0.1) {
        NSString *nsOsversion = [UIDevice currentDevice].systemVersion;
        g_iOSVersion = atof([nsOsversion UTF8String]);
    }
    return g_iOSVersion;
}

+ (BOOL)isiPhone2G {
    NSString *nsPlatform = [UIDevice currentDevice].platform;
    return [nsPlatform hasPrefix:@"iPhone1,1"];
}

+ (BOOL)isiPhone3G {
    NSString *nsPlatform = [UIDevice currentDevice].platform;
    return [nsPlatform hasPrefix:@"iPhone1,2"];
}

+ (BOOL)isiPhone3GS {
    NSString *nsPlatform = [UIDevice currentDevice].platform;
    return [nsPlatform hasPrefix:@"iPhone2,1"];
}

+ (BOOL)isiPhone4 {
    NSString *nsPlatform = [UIDevice currentDevice].platform;
    return ([nsPlatform hasPrefix:@"iPhone3,1"] || [nsPlatform hasPrefix:@"iPhone3,2"] || [nsPlatform hasPrefix:@"iPhone3,3"]);
}

+ (BOOL)isiPhone4S {
    NSString *nsPlatform = [UIDevice currentDevice].platform;
    return [nsPlatform hasPrefix:@"iPhone4,1"];
}

+ (BOOL)isiPhone5 {
    NSString *nsPlatform = [UIDevice currentDevice].platform;
    return [nsPlatform hasPrefix:@"iPhone5,1"] || [nsPlatform hasPrefix:@"iPhone5,2"];
}

+ (BOOL)isiPhone5C {
    NSString *nsPlatform = [UIDevice currentDevice].platform;
    return [nsPlatform hasPrefix:@"iPhone5,3"] || [nsPlatform hasPrefix:@"iPhone5,4"];
}

+ (BOOL)isiPhone5S {
    NSString *nsPlatform = [UIDevice currentDevice].platform;
    return [nsPlatform hasPrefix:@"iPhone6,1"] || [nsPlatform hasPrefix:@"iPhone6,2"];
}

+ (NSUInteger)deviceFreeMemorySize {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return 0;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return 0;
    return vm_stat.free_count * page_size;
}

@end
