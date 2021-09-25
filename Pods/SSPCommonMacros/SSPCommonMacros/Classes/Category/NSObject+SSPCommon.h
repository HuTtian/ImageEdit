//
//  NSObject+SSPCommon.h
//  AirPayCounter
//
//  Created by HuiCao on 2019/4/17.
//  Copyright © 2019 Shopee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (SSPCommon)

- (NSString *)stringForKey:(id<NSCopying>)key;
- (NSArray *)arrayForKey:(id<NSCopying>)key;
- (NSDictionary *)dictionaryForKey:(id<NSCopying>)key;
- (NSInteger)integerForKey:(id<NSCopying>)key;
- (int64_t)int64ForKey:(id<NSCopying>)key;
- (int32_t)int32ForKey:(id<NSCopying>)key;
- (float)floatForKey:(id<NSCopying>)key;
- (double)doubleForKey:(id<NSCopying>)key;
- (BOOL)boolForKey:(id<NSCopying>)key;

- (NSString *)stringForKey:(id<NSCopying>)key default:(NSString * _Nullable)defaultValue;
- (bool)boolForKey:(id<NSCopying>)key default:(bool)defaultValue;
- (NSInteger)integerForKey:(id<NSCopying>)key default:(NSInteger)defaultValue;
- (float)floatForKey:(id<NSCopying>)key default:(float)defaultValue;
- (NSArray *)arrayForKey:(id<NSCopying>)key default:(NSArray * _Nullable)defaultValue;
- (NSDictionary *)dictionaryForKey:(id<NSCopying>)key default:(NSDictionary * _Nullable)defaultValue;

@end

NS_ASSUME_NONNULL_END
