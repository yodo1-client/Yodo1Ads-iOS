///
/// @file
/// @internal
/// @brief Definition for the VASVASTExtensionBackgroundView.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <UIKit/UIKit.h>
#import "VASVASTBackground.h"
#import "VASVASTExtensionInteractiveVideo.h"

NS_ASSUME_NONNULL_BEGIN

@interface VASVASTExtensionBackgroundView : UIView

- (instancetype)initWithExtensions:(NSArray<VASVASTExtension *> *)extensions;

@property (strong, nullable, readonly) VASVASTBackground *background;

@end

NS_ASSUME_NONNULL_END
