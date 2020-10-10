//
//  Yodo1AntiIndulged.m
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/2.
//

#import "Yodo1AntiIndulged.h"
#import "Yodo1AntiIndulgedHelper.h"

@implementation Yodo1AntiIndulgedEvent

@end

@implementation Yodo1AntiIndulgedProductReceipt

@end


@implementation Yodo1AntiIndulged

+ (Yodo1AntiIndulged *)shared {
    static Yodo1AntiIndulged *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Yodo1AntiIndulged alloc] init];
    });
    return sharedInstance;
}

- (void)init:(NSString *)appKey delegate:(id<Yodo1AntiIndulgedDelegate>)delegate {
    [self init:appKey channel:Yodo1AntiIndulgedChannel regionCode:@"" delegate:delegate];
}

- (void)init:(NSString *)appKey regionCode:(NSString *)regionCode delegate: (id<Yodo1AntiIndulgedDelegate>)delegate {
    [self init:appKey channel:Yodo1AntiIndulgedChannel regionCode:regionCode delegate:delegate];
}

- (void)init:(NSString *)appKey channel:(NSString *)channel regionCode:(NSString *)regionCode delegate:(id<Yodo1AntiIndulgedDelegate>)delegate {
    [[Yodo1AntiIndulgedHelper shared] init:appKey channel:channel regionCode:regionCode delegate:delegate];
}

- (void)startTimer {
    [[Yodo1AntiIndulgedHelper shared] startTimer];
}

- (void)stopTimer {
    [[Yodo1AntiIndulgedHelper shared] stopTimer];
}

- (BOOL)isTimer {
    return [[Yodo1AntiIndulgedHelper shared] isTimer];
}

- (BOOL)isGuestUser {
    return [[Yodo1AntiIndulgedHelper shared] isGuestUser];
}

- (void)verifyCertificationInfo:(NSString *)accountId success:(Yodo1AntiIndulgedSuccessful)success failure:(Yodo1AntiIndulgedFailure)failure {
    [[Yodo1AntiIndulgedHelper shared] verifyCertificationInfo:accountId success:success failure:failure];
}

///是否已限制消费
- (void)verifyPurchase:(NSInteger)money success:(Yodo1AntiIndulgedSuccessful)success failure:(Yodo1AntiIndulgedFailure)failure {
    [[Yodo1AntiIndulgedHelper shared] verifyPurchase:money success:success failure:failure];
}

- (void)reportProductReceipt:(Yodo1AntiIndulgedProductReceipt *)receipt success:(Yodo1AntiIndulgedSuccessful)success failure:(Yodo1AntiIndulgedFailure)failure {
    [[Yodo1AntiIndulgedHelper shared] reportProductReceipts:@[receipt] success:success failure:failure];
}

@end

