///
/// @file
/// @internal
/// @brief Definition for the VASVASTExtensionInteractiveVideo.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import "VASVASTExtension.h"
#import "VASVASTOverlay.h"
#import "VASVASTBackground.h"
#import "VASVASTButton.h"

@interface VASVASTExtensionInteractiveVideo : VASVASTExtension

@property (strong) VASVASTOverlay *overlay;
@property (strong) VASVASTBackground *background;
@property (strong) NSArray<VASVASTButton *> *buttons;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end
