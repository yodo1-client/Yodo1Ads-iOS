///
/// @file
/// @internal
/// @brief Definition for the VASVASTModel.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import "VASVASTInLine.h"
#import "VASVASTWrapper.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const kVASVASTInteractiveVideoExtension;
FOUNDATION_EXPORT NSString *const kVASVASTAdVerificationsExtension;
FOUNDATION_EXPORT NSString *const kVASVASTAdChoicesIcon;
FOUNDATION_EXPORT NSString *const kVASVASTMediaFileType;
FOUNDATION_EXPORT NSString *const kVASVASTMediaFileDelivery;
FOUNDATION_EXPORT NSUInteger const kVASVASTMinimumMajorVersion;

@interface VASVASTModel : NSObject

@property (copy, nullable) NSString *version;
@property (copy, nullable) NSURL *errorURL;

@property (strong, nullable) VASVASTInLine *inlineAd;
@property (strong) NSArray<VASVASTWrapper *> *wrapperAds;
@property (readonly, nullable) NSArray<VASVASTMediaFile *> *mediaFiles;
@property (readonly, nullable) NSString *skipOffset;
@property (readonly, nullable) NSArray<VASVASTExtension *> *extensions;
@property (readonly, nullable) NSArray<VASVASTExtensionAdVerifications *> *adVerifications;
@property (readonly, nullable) NSArray<VASVASTUrlWithId *> *videoClicks;
@property (readonly, nullable) NSArray<VASVASTUrlWithId *> *videoClickTracking;
@property (readonly, nullable) VASVASTUrlWithId *videoClickThrough;
@property (readonly, nullable) NSArray<VASVASTCompanion *> *companionAds;
@property (readonly, nullable) NSArray<VASVASTCompanion *> *wrapperCompanionAds;
@property (readonly, nullable) NSArray<VASVASTIcon *> *preferredIcons;
@property (readonly) NSArray<VASVASTTracking *> *trackingEvents;
@property (readonly, nullable) NSArray<VASVASTUrlWithId *> *impressions;
@property (readonly, nullable) NSArray<NSURL *> *errorURLs;

@end

NS_ASSUME_NONNULL_END
