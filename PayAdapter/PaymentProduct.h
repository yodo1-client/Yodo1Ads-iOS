//
//  PaymentProduct.h
//
//  Created by yodo1 on 14-5-19.
//  Copyright (c) 2014年 yodo1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaymentProduct : NSObject

@property (nonatomic, retain) NSString* uniformProductId;       //通用产品id
@property (nonatomic, retain) NSString* channelProductId;       //渠道产品id:比如91的产品id，AppStore的产品
@property (nonatomic, retain) NSString* price;                  //产品价格
@property (nonatomic, retain) NSString* currency;               //货币名称：USD,CNY等等
@property (nonatomic, retain) NSString* gameUserId;             //游戏UserId,支付验证需要
@property (nonatomic, retain) NSString* gameNickname;           //游戏昵称
@property (nonatomic, retain) NSString* ucuid;                  //uc用户的uid,支付验证需要
@property (nonatomic, retain) NSString* channelId;              //渠道Id:91、appstore
@property (nonatomic, retain) NSString* gameRegionCode;         //游戏分区,支付验证需要
@property (nonatomic, retain) NSString* extra;                  //附带信息：可选
@property (nonatomic, retain) NSString* trxReceipt;             //苹果票据信息
@property (nonatomic, retain) NSString* transactionIdentifier;  //苹果产品订单号：唯一
@property (nonatomic, retain) NSString* productType;            //苹果产品类型

@end
