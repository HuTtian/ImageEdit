//
//  NSBundle+Extend.m
//  SSPCommonMacros
//
//  Created by QinqinHe on 2020/4/12.
//

#import "NSBundle+Extend.h"
#import "SSPAssert.h"


@implementation NSBundle (Extend)

+ (nullable NSBundle *)bundleWithBundleName:(NSString *)bundleName {
    return [self bundleWithBundleName:bundleName ofPodName:nil];
}

+ (nullable NSBundle *)bundleWithBundleName:(NSString *)bundleName ofPodName:(NSString  *__nullable)podName {
    if (bundleName == nil && podName == nil) {
        MAssert(!(bundleName == nil && podName == nil), @"bundleName和podName不能同时为空");
        return nil;
    }
    
    if (bundleName == nil) {
        bundleName = podName;
    }else if (podName == nil) {
        podName = bundleName;
    }
    
    if ([bundleName containsString:@".bundle"]) {
        bundleName = [bundleName componentsSeparatedByString:@".bundle"].firstObject;
    }
    NSURL *associateBundleURL = [[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"];
    if (!associateBundleURL) {
        associateBundleURL = [[NSBundle mainBundle] URLForResource:@"Frameworks" withExtension:nil];
        associateBundleURL = [associateBundleURL URLByAppendingPathComponent:podName];
        associateBundleURL = [associateBundleURL URLByAppendingPathExtension:@"framework"];
        NSBundle *associateBunle = [NSBundle bundleWithURL:associateBundleURL];
        associateBundleURL = [associateBunle URLForResource:bundleName withExtension:@"bundle"];
    }
    
    MAssert(associateBundleURL != nil, @"取不到关联bundle");
    return associateBundleURL?[NSBundle bundleWithURL:associateBundleURL]:nil;
}


+ (nullable NSString *)pathForResourceWithBundle:(NSString *)bundleName ofResource:(NSString *)resourceName ofType:(nullable NSString *)ext {
    return [[self bundleWithBundleName:bundleName] pathForResource:resourceName ofType:ext];
}

+ (nullable NSString *)pathForResourceWithBundle:(NSString *)bundleName ofPodName:(NSString *)podName ofResource:(NSString *)resourceName ofType:(nullable NSString *)ext {
    return [[self bundleWithBundleName:bundleName ofPodName:podName] pathForResource:resourceName ofType:ext];
}

@end
