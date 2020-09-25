///
/// @file
/// @brief VASPEXRegistry
///
/// @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol VASPEXFactory;
@protocol VASPEXHandlerDelegate;

/**
 The PEX Registry is used to register VASPEXFactory instances to post event experience content types. The PEX Registry is used to obtain a VASPEXHandlerDelegate instance for execution of a post event experience by a component.
 */
@interface VASPEXRegistry : NSObject

/**
 Registers the specified content type with VASPEXFactory instance provided.
 
 @param factory The VASPEXFactory that creates handlers for this content type.
 @param type    The PEX content type for this factory.
 @return YES if the VASPEXFactory object was successfully registered, NO if already registered or does not conform to the VASPEXFactory protocol.
 */
- (BOOL)registerPEXFactory:(id<VASPEXFactory>)factory forType:(NSString *)type;

/**
 Creates a new VASPEXHandlerDelegate instance for executing the post event experience for the specified content type.
 
 @param type    The PEX content type for this factory.
 @return a new VASPEXHandlerDelegate for the VASPEXFactory if it is registered for the specified PEX type, otherwise nil.
 */
- (nullable id<VASPEXHandlerDelegate>)createPEXHandlerForType:(NSString *)type;

/**
 Provides access to an existing VASPEXFactory instance for the specified content type.
 
 @param type    The PEX content type for this factory.
 @return the VASPEXFactory object for the specified PEX type if registered, otherwise nil.
 */
- (nullable id<VASPEXFactory>)PEXFactoryForType:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
