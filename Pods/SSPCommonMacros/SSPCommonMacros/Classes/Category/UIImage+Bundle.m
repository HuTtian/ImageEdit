//
//  UIImage+Bundle.m
//  Pods-SSPCommonMacros_Example
//
//  Created by QinqinHe on 2020/4/12.
//

#import "UIImage+Bundle.h"
#import "NSBundle+Extend.h"

@implementation UIImage (Bundle)

+ (nullable UIImage *)imageFromBundle:(NSString *)bundleName imageNamge:(NSString * __nullable)imageName {
    return [self imageFromBundle:bundleName imageNamge:imageName imageType:@"png"];
}

+ (nullable UIImage *)imageFromBundle:(NSString *)bundleName imageNamge:(NSString * __nullable)imageName imageType:(NSString  * __nullable)type {
    if (imageName.length <= 0) {
        return nil;
    }
    NSBundle *currentBundle =  [NSBundle bundleWithBundleName:bundleName];
    //兜底:主bundle
    if (!currentBundle) {
        currentBundle = [NSBundle mainBundle];
    }
    NSString *assetImageName = imageName;
    if (nil != type && ![type isEqualToString:@"png"]) {
        assetImageName = [imageName stringByAppendingFormat:@".%@",type];
    }
    UIImage *image = nil;
    if (@available(iOS 13.0, *)) {
        image = [UIImage imageNamed:assetImageName inBundle:currentBundle withConfiguration:nil];
    }else {
        image = [UIImage imageNamed:assetImageName inBundle:currentBundle compatibleWithTraitCollection:nil];
    }

    if (!image) {//兼容+保护
        NSInteger scale = [[UIScreen mainScreen] scale];
        NSString *path = [currentBundle pathForResource:[NSString stringWithFormat:@"%@@%zdx.%@",imageName,scale,type] ofType:nil];
        image = [UIImage imageWithContentsOfFile:path];
    }

    return image;
}

@end

