///
/// @file
/// @internal
/// @brief Definition for the VASVASTAdChoicesView.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <UIKit/UIKit.h>
#import "VASVASTIcon.h"

NS_ASSUME_NONNULL_BEGIN

@protocol VASVASTAdChoicesViewDelegate <NSObject>

- (void)adChoicesIconViewed:(VASVASTIcon *)icon;
- (void)adChoicesIconClicked:(VASVASTIcon *)icon;

@end

@interface VASVASTAdChoicesView : UIView

- (instancetype)initWithIcons:(NSArray<VASVASTIcon *> *)icons
                     delegate:(nullable id<VASVASTAdChoicesViewDelegate>)delegate;
- (void)updateIconVisibility:(NSTimeInterval)currentPlaybackTime;
- (void)hideButton;

@property (weak, nullable) id<VASVASTAdChoicesViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
