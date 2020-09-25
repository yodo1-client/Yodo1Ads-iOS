///
/// @file
/// @internal
/// @brief Definition for the VASVASTVideoControls.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT CGFloat const kVASVASTContolButtonHitWidth;

@protocol VASVASTVideoControlsDelegate <NSObject>

-(void)videoPlayerClosePressed;
-(void)videoPlayerSkipPressed;
-(void)videoPlayerReplayPressed;
-(void)videoPlayerMutePressed;

@end

@interface VASVASTVideoControls : NSObject

- (instancetype)initWithView:(UIView *)view
              topLayoutGuide:(nullable id)topLayoutGuide
                       muted:(BOOL)isMuted
                    delegate:(id<VASVASTVideoControlsDelegate>)delegate;
- (void)updateSkipTime:(NSTimeInterval)timeLeftToSkip;
- (void)showEndCardControls;
- (void)resetControls;

@property (weak, nullable) id<VASVASTVideoControlsDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
