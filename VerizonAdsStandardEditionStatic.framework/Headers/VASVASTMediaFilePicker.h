///
/// @file
/// @internal
/// @brief Definitions for the VASVASTMediaFilePicker.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import "VASVASTMediaFile.h"

// The media file picker validates the mime and delivery types as specified in the VAST document (but not the actual mediaFile URL).
// Network is checked for availability, and the file is selected by bit rate according to available network.

@interface VASVASTMediaFilePicker : NSObject

+ (VASVASTMediaFile *)pick:(NSArray<VASVASTMediaFile *> *)mediaFiles;

@end
