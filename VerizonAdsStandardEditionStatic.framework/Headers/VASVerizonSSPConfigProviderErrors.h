///
/// @file
/// @brief VerizonSSPConfigProvider Error code definitions.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsCore.h>

/// The domain for VerizonSSPConfigProvider errors.
FOUNDATION_EXPORT NSErrorDomain const kVASVerizonSSPConfigProviderErrorDomain;

/// Error codes that are used by VASErrorInfo in the VerizonSSPConfigProvider error domain.
typedef NS_ENUM(NSInteger, VASVerizonSSPConfigProviderError) {
    VASVerizonSSPConfigProviderErrorParsing = 1,
    VASVerizonSSPConfigProviderErrorInvalidVersion = 2,
    VASVerizonSSPConfigProviderErrorIncompatibleVersion = 3,
    VASVerizonSSPConfigProviderErrorHttpRequest = 4,
    VASVerizonSSPConfigProviderErrorBusy = 5,
    VASVerizonSSPConfigProviderErrorSerializingRequest = 6,
};
