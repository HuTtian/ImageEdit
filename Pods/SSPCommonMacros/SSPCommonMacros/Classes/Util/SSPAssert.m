//
//  SSPAssert.m
//  AirPayCounter
//
//  Created by ChaoFeng on 2019/5/17.
//  Copyright © 2019 Shopee. All rights reserved.
//

#import "SSPAssert.h"

@implementation SSPAssert
+ (void)assert:(BOOL)condition selector:(SEL)selector{
    NSString *conditionPara = [NSString stringWithFormat:@" Selector %@触发断言",NSStringFromSelector(selector)];
    if (!condition) {
        if (SSPMacroConfigureM.infoLogBlock) {
            SSPMacroConfigureM.infoLogBlock([NSError errorWithDomain:conditionPara code:-1 userInfo:nil]);
        }
    }
#ifdef DEBUG
    NSAssert(condition, conditionPara);
#endif
}

+ (void)assert:(BOOL)condition para:(NSString *)para{
    NSString *conditionPara = [NSString stringWithFormat:@"断言被触发，因为%@",para];
    if (!condition) {
        if (SSPMacroConfigureM.infoLogBlock) {
            SSPMacroConfigureM.infoLogBlock([NSError errorWithDomain:conditionPara code:-1 userInfo:nil]);
        }
    }
#ifdef DEBUG
    NSAssert(condition, conditionPara);
#endif
}


@end
