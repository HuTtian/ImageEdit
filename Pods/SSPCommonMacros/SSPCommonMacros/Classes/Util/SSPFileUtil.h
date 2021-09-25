//
//  SSPFileUtil.h
//  AirPayCounter
//
//  Created by HuiCao on 2019/4/24.
//  Copyright © 2019 Shopee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSPFileUtil : NSObject

/**
 判断文件是否存在
 
 @param filePath 文件路径
 @return 是否存在
 */
+ (BOOL)fileExist:(NSString *)filePath;

/**
 创建文件夹
 
 @param path 文件路径
 @return 是否成功
 */
+ (BOOL)createPath:(NSString *)path;

/**
 创建文件
 
 @param filePath 文件路径
 @return 是否成功
 */
+ (BOOL)createFile:(NSString *)filePath;

/**
 获取文件大小
 
 @param filePath 文件路径
 @return 文件大小
 */
+ (long long)getFileSize:(NSString *)filePath;

/**
 获取tmp文件夹路径
 
 @return 返回路径
 */
+ (NSString *)getTmpPath;

/**
 获取doc文件夹路径
 
 @return 返回路径
 */
+ (NSString *)getDocPath;

/**
 获取lib文件夹下cache路径

 @return 返回路径
 */
+ (NSString *)getLibraryCachePath;

/**
 获取cache文件夹路径

 @return 返回路径
 */
+ (NSString *)getSystemCachePath;

/**
 获取指定目录的内容
 
 @param path 指定目录
 @return 指定目录下的文件或者目录列表
 */
+ (NSArray<NSString *> *)contentsOfDirectoryAtPath:(NSString *)path;


/**
 删除某个文件或者目录
 
 @param path 文件或者目录的地址
 @return 删除成功返回YES，发生异常返回NO
 */
+ (BOOL)removeItemAtPath:(NSString *)path;

/**
 safe unArchvie, 防止未知错误或者爆内存
 
 @param path 文件或者目录的地址
 */
+ (void)safeUnarchive:(NSString *)path;

/**
 safe unArchvie, 防止未知错误或者爆内存
 
 @param data 数据内容
 */
+ (void)safeUnarchiveFromData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
