///
/// @file
/// @brief Definitions for errors declared in this plugin.
///
/// @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VASErrorInfo.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSErrorDomain const kVASNativeVerizonControllerErrorDomain;

/// Error codes that are used in the NativVerizonControllerErrorDomain error domain. Check the underlying error for possible additional errors indicating the cause of the parsing error.
typedef NS_ENUM(NSInteger, VASNativeVerizonControllerError) {
    /// An error was encountered while parsing the ad content.
    VASNativeVerizonControllerErrorParsingContent = 1,
    /// A problem was encountered while generating the resources from the content.
    VASNativeVerizonControllerErrorCreatingResources,
    /// A problem was encountered while creating an object.
    VASNativeVerizonControllerErrorNotCreated,
    /// Loading the resource data failed.
    VASNativeVerizonControllerErrorLoadingResources,
    /// A timeout occurred executing a command.
    VASNativeVerizonControllerErrorTimeout,
    /// The resource loading was aborted.
    VASNativeVerizonControllerErrorAbort,
    /// Resource loading is already underway.
    VASNativeVerizonControllerErrorLoadingResourcesInProgress,
    /// Post event experience data was invalid.
    VASNativeVerizonControllerErrorExperienceDataInvalid,
    /// Registered post event experience not found.
    VASNativeVerizonControllerErrorExperienceNotFound,
    /// Required component was not found in the list of components.
    VASNativeVerizonControllerErrorMissingRequiredComponent,
   /// Unexpected VNAPS response data returned.
    VASNativeVerizonControllerErrorVNAPSResponse,
    /// Expected content type for a Verizon Native Ad.
    VASNativeVerizonControllerErrorIncorrectComponent,
};

// Error convenience methods.
VASErrorInfo * NativeVerizonControllerParsingContentError(NSString *reason, NSError * _Nullable underlyingError);
VASErrorInfo * NativeVerizonControllerVNAPSResponseError(NSString *reason);
VASErrorInfo * NativeVerizonControllerIncorrectComponentError(NSString *reason);
VASErrorInfo * NativeVerizonControllerNotCreatedError(NSString *reason);
VASErrorInfo * NativeVerizonControllerTimeoutError(NSString *feature);
VASErrorInfo * NativeVerizonControllerResourceLoadingError(NSString * _Nullable reason, NSError * _Nullable underlyingError);
VASErrorInfo * NativeVerizonControllerAlreadyLoadingError(void);
VASErrorInfo * NativeVerizonControllerExperienceNotFoundError(NSString *PEXName);
VASErrorInfo * NativeVerizonControllerExperienceInvalidError(NSString *reason);
VASErrorInfo * NativeVerizonControllerMissingRequiredComponents(NSString *components);

NS_ASSUME_NONNULL_END
