//
//  SSPAssert.h
//  AirPayCounter
//
//  Created by ChaoFeng on 2019/5/17.
//  Copyright © 2019 Shopee. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MAssert(condition,pa) [SSPAssert assert:condition para:pa]

NS_ASSUME_NONNULL_BEGIN

@interface SSPAssert : NSObject

/**
方法断言

@param condition 断言条件
@param selector 对应方法
*/
+ (void)assert:(BOOL)condition selector:(SEL)selector;

/**
方法断言

@param condition 断言条件
@param para 断言参数描述
*/
+ (void)assert:(BOOL)condition para:(NSString *)para;

@end

NS_ASSUME_NONNULL_END
