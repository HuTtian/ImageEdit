//
//  UIImage+Bundle.h
//  Pods-SSPCommonMacros_Example
//
//  Created by QinqinHe on 2020/4/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Bundle)

/// 从指定的bundle 中读取图片
/// @param bundleName bundle名称
/// @param imageName 图片名称，默认png格式
+ (nullable UIImage *)imageFromBundle:(NSString *)bundleName imageNamge:(NSString * __nullable)imageName;

/// 从指定的bundle 中读取图片
/// @param bundleName bundle名称
/// @param imageName 图片名称
/// @param type  指定图片格式
+ (nullable UIImage *)imageFromBundle:(NSString *)bundleName imageNamge:(NSString * __nullable)imageName imageType:(NSString  * __nullable)type;


@end


NS_ASSUME_NONNULL_END
