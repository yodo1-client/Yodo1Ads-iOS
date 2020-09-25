///
/// @file
/// @internal
/// @brief Definition for the VASVASTExtensionAdVerifications.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASVASTController.h>
#import "VASVASTVerification.h"
#import "VASVASTExtension.h"
#import "VASVASTModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VASVASTExtensionAdVerifications : VASVASTExtension

@property (nonatomic, readonly, nullable) NSArray<VASVASTVerification *> *verifications;

- (instancetype)initWithContent:(NSString *)content
                  verifications:(nullable NSArray<VASVASTVerification *> *)verifications;

@end

NS_ASSUME_NONNULL_END
