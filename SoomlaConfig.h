//
//  SoomlaConfig.h
//  SoomlaTraceback
//
//  Created by Boris Spektor on 25/10/2018.
//  Copyright © 2018 SOOMLA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoomlaConfig : NSObject

@property (nonatomic) NSString *userId;
@property (nonatomic) BOOL testMode;
@property (nonatomic) BOOL collectIdfa;
@property (nonatomic) BOOL validateVersions;
@property (nonatomic) BOOL sendAttributionData;

+ (SoomlaConfig*)config;

@end
