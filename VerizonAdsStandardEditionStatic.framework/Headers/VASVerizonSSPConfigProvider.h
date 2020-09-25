///
/// @internal
/// @file
/// @brief Definitions for VASVerizonSSPConfigProvider
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsCore.h>

NS_ASSUME_NONNULL_BEGIN

/// Completion handler for config provider update requests.
typedef void (^VASHandshakeRequestCompletionHandler)(NSData * _Nullable handshakeResponseData, VASErrorInfo * _Nullable error);

@class VASConfigDomainInfo;

/**
 VerizonSSPConfigProvider implements the VAS Core's Config Provider interface and communicates with the Verizon SSP Configuration
 endpoint. It allows for remote configuration of Verizon Ads SDKs in production.
*/
@interface VASVerizonSSPConfigProvider : NSObject <VASConfigurationProvider>

/**
 Initialize a new Verizon Configuration Provider.
 @param session The session to for this object to use.
 @param vasAds The VASAds instance for this object to use.
 @return An initialized instance of this class.
 */
- (instancetype)initWithSession:(NSURLSession *)session withVASAds:(VASAds *)vasAds;

/**
Update the configuration.

@param completion The completion handler to call when the update operation completes.
*/
- (void)updateWithCompletion:(VASConfigurationProviderUpdateCompletionHandler)completion;

/**
 Reloads the last successful handshake response to initialize settings.  This sets everything to the last known good setting.
 This operation is synchronous because it's used during initialization and subsequent logic requires the cached values.
 */
- (void)restoreHandshakeValues;

/**
Prepare the VASSSPConfigurationProvider.
 
 @return YES if the prepare method was successful or NO otherwise.
*/
- (BOOL)prepare;

// New instances of VASAds cannot be created. The sharedInstance should be used within applications.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/// The current NSURLSession.
@property (readonly) NSURLSession *session;

/// The VASAds instance whose configuration will be updated; dependency injection.
@property (readonly, weak) VASAds *vasAds;

/// Configuration provider ID.
@property (nonatomic) NSString *providerId;

/// DomainInfo for VASAds
@property (class, nonatomic, readonly) VASConfigDomainInfo *domainVASAds;

/// DomainInfo for VASVerizonSSP
@property (class, nonatomic, readonly) VASConfigDomainInfo *domainVASVerizonSSP;

/// DomainInfo for VASCore
@property (class, nonatomic, readonly) VASConfigDomainInfo *domainVASCore;

/// DomainInfo for VASSupport
@property (class, nonatomic, readonly) VASConfigDomainInfo *domainVASSupport;

/// DomainInfo for VASInlinePlacement
@property (class, nonatomic, readonly) VASConfigDomainInfo *domainVASInlinePlacement;

/// DomainInfo for VASInterstitialPlacement
@property (class, nonatomic, readonly) VASConfigDomainInfo *domainVASInterstitialPlacement;

/// DomainInfo for VASNativePlacement
@property (class, nonatomic, readonly) VASConfigDomainInfo *domainVASNativePlacement;

/// DomainInfo for VASVAST
@property (class, nonatomic, readonly) VASConfigDomainInfo *domainVASVAST;

/// DomainInfo for VASVPAID
@property (class, nonatomic, readonly) VASConfigDomainInfo *domainVASVPAID;

/// DomainInfo for VASOMSDK
@property (class, nonatomic, readonly) VASConfigDomainInfo *domainVASOMSDK;

@end

// POD class used to handle domains & security keys
@interface VASConfigDomainInfo : NSObject

- (instancetype)initWithDomain:(NSString *)domain securityKey:(nullable NSString *)securityKey;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@property (readonly, copy) NSString *domain;
@property (nullable, readonly, copy) NSString *securityKey;

@end

NS_ASSUME_NONNULL_END
