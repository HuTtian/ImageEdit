//
//  SSPMacroConfigure.h
//  SSPCommonMacros
//
//  Created by peterfeng on 2019/12/11.
//

#import <Foundation/Foundation.h>

typedef void(^SSPMacroConfigureErrorBlock)(NSError *_Nonnull error);

#define SSPMacroConfigureM [SSPMacroConfigure shareInstance]

NS_ASSUME_NONNULL_BEGIN

@interface SSPMacroConfigure : NSObject

+ (instancetype)shareInstance;

/**
 SSPCommonMacro库会通过该block，输出error，库使用方需要配置该block，并在该block中打info日志
 */
@property (nonatomic, copy, nullable) SSPMacroConfigureErrorBlock infoLogBlock;
/**
SSPCommonMacro库会通过该block，输出error，库使用方需要配置该block，并在该block中打debug日志
*/
@property (nonatomic, copy, nullable) SSPMacroConfigureErrorBlock debubgLogBlock;

@end

NS_ASSUME_NONNULL_END
