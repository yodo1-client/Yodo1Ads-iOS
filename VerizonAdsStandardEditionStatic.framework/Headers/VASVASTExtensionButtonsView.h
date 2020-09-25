///
/// @file
/// @internal
/// @brief Definition for the VASVASTExtensionButtonsView.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <UIKit/UIKit.h>
#import "VASVASTExtensionInteractiveVideo.h"
#import "VASVASTButton.h"

NS_ASSUME_NONNULL_BEGIN

@protocol VASVASTExtensionButtonsViewDelegate <NSObject>

- (void)extensionButtonClicked:(VASVASTButton *)button;

@end

@interface VASVASTExtensionButtonsView : UIView

- (instancetype)initWithExtensions:(NSArray<VASVASTExtension *> *)extensions
                          delegate:(nullable id<VASVASTExtensionButtonsViewDelegate>)delegate;

- (void)updateButtonVisibility:(NSTimeInterval)currentPlaybackTime;
- (void)updateConstraintsForSize:(CGSize)size;
- (void)showAllButtons;
- (void)hideAllButtons;

@property (strong, nullable, readonly) NSArray<VASVASTButton *> *buttons;
@property (weak, nullable) id<VASVASTExtensionButtonsViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
