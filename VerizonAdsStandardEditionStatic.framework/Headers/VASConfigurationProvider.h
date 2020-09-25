///
/// @file
/// @brief Definitions for VASConfigurationProvider.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import "VASErrorInfo.h"

NS_ASSUME_NONNULL_BEGIN


@protocol VASConfigurationProvider;

/// Completion handler for config provider update requests.
typedef void (^VASConfigurationProviderUpdateCompletionHandler)(id<VASConfigurationProvider> configurationProvider, VASErrorInfo * _Nullable error);


/**
 Plugin configuration providers must implement this interface.
 Configuration providers should set the values for their domain by calling methods on VASConfiguration.
 */
@protocol VASConfigurationProvider <NSObject>

/// Configuration provider ID.
@property (nonatomic) NSString * providerId;

/**
 Once a provider is registered, this method may be called periodically to request configuration data be updated, if necessary, according to the provider.
 
 @param completion The completion handler to call when the update operation completes.
 */
- (void)updateWithCompletion:(VASConfigurationProviderUpdateCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
