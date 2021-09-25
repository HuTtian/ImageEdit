//
//  SSPMacroConfigure.m
//  SSPCommonMacros
//
//  Created by peterfeng on 2019/12/11.
//

#import "SSPMacroConfigure.h"

@implementation SSPMacroConfigure

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static SSPMacroConfigure *configure = nil;
    dispatch_once(&onceToken, ^{
        configure = [SSPMacroConfigure new];
    });
    return configure;
}

@end
