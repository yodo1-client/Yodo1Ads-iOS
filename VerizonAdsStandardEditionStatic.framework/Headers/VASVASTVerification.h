///
/// @file
/// @internal
/// @brief Definition for the VASVASTVerification.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import "VASVASTJavaScriptResource.h"
#import "VASVASTTracking.h"

NS_ASSUME_NONNULL_BEGIN

@interface VASVASTVerification : NSObject

@property (nonatomic, readonly) NSString *vendor;
@property (nonatomic, readonly, nullable) VASVASTJavaScriptResource *javaScriptResource;
@property (nonatomic, readonly, nullable) NSArray<VASVASTTracking *> *trackingEvents;
@property (nonatomic, readonly, nullable) NSString *verificationParameters;

- (instancetype)initWithVendor:(NSString *)vendor
            javaScriptResource:(nullable VASVASTJavaScriptResource *)javaScriptResource
                trackingEvents:(nullable NSArray<VASVASTTracking *> *)trackingEvents
        verificationParameters:(nullable NSString *)verificationParameters;

@end

NS_ASSUME_NONNULL_END
