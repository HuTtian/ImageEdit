//
//  NSBundle+Extend.h
//  SSPCommonMacros
//
//  Created by QinqinHe on 2020/4/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (Extend)

/// 获取指定bundle名称的NSBundle
/// @param bundleName 名称
+ (nullable NSBundle *)bundleWithBundleName:(NSString *)bundleName;

/// 指定bundleName 和pod库的名称
/// @param bundleName 名称
/// @param podName pod名称，有的pod库和bundleName不一致
+ (nullable NSBundle *)bundleWithBundleName:(NSString *)bundleName ofPodName:(NSString  *__nullable)podName;

/// 从指定bundle中读取资源，返回资源路径
/// @param bundleName bundle名称
/// @param resourceName  资源名称
/// @param ext 资源类型。比如json
+ (nullable NSString *)pathForResourceWithBundle:(NSString *)bundleName ofResource:(NSString *)resourceName ofType:(nullable NSString *)ext;


/// 从指定bundle中读取资源，返回资源路径
/// @param bundleName bundle名称
/// @param podName pod名称，有的pod库和bundleName不一致
/// @param resourceName  资源名称
/// @param ext 资源类型。比如json
+ (nullable NSString *)pathForResourceWithBundle:(NSString *)bundleName ofPodName:(NSString *)podName ofResource:(NSString *)resourceName ofType:(nullable NSString *)ext;


@end

NS_ASSUME_NONNULL_END
