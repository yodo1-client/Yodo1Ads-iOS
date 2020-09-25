///
/// @file
/// @internal
/// @brief Definition for the VASVASTEndCardView.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <UIKit/UIKit.h>
#import "VASVASTCompanion.h"

NS_ASSUME_NONNULL_BEGIN

@protocol VASVASTEndCardViewDelegate <NSObject>

- (void)endCardClicked:(VASVASTCompanion *)endCard;

@end

@interface VASVASTEndCardView : UIView

- (instancetype)initWithCompanionAds:(NSArray<VASVASTCompanion *> *)companionAds
                            delegate:(nullable id<VASVASTEndCardViewDelegate>)delegate;

@property (strong, nullable, readonly) VASVASTCompanion *endCardCompanion;
@property (weak, nullable) id<VASVASTEndCardViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
