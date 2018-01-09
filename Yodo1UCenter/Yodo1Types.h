//
//  Yodo1Types.h
//  UCCenter
//
//  Created by Yuehai on 31/07/2017.
//  Copyright © 2017 hyx. All rights reserved.
//

#ifndef Yodo1Types_h
#define Yodo1Types_h

typedef enum {
    Yodo1U3dSDK_ResulType_Payment = 2001,
    Yodo1U3dSDK_ResulType_RestorePayment = 2002,
    Yodo1U3dSDK_ResulType_RequestProductsInfo = 2003,
    Yodo1U3dSDK_ResulType_VerifyProductsInfo = 2004,
    Yodo1U3dSDK_ResulType_LossOrderIdQuery = 2005,
    Yodo1U3dSDK_ResulType_QuerySubscriptions = 2006,
    Yodo1U3dSDK_ResulType_FetchPromotionVisibility = 2007,
    Yodo1U3dSDK_ResulType_FetchStorePromotionOrder = 2008,
    Yodo1U3dSDK_ResulType_UpdateStorePromotionVisibility = 2009,
    Yodo1U3dSDK_ResulType_UpdateStorePromotionOrder = 2010,
    Yodo1U3dSDK_ResulType_GetPromotionProduct = 2011,
}Yodo1U3dSDKResulType;


typedef enum {
    UCenterEnvironmentProduction,//生产环境
    UCenterEnvironmentTest       //测试环境
}UCenterEnvironment;

typedef enum {
    UCenterLoginCannel = 0,  //取消登录
    UCenterLoginSuccess,     //登录成功
    UCenterLoginFail,        //登录失败
}UCenterLoginState;

typedef enum {
    PaymentCannel = 0,      //取消支付
    PaymentSuccess,         //支付成功
    PaymentFail,            //支付失败
}PaymentState;

typedef enum {
    LossOrderTypeRestore = 0,  //恢复购买
    LossOrderTypeLossOrder,     //查询漏单
}LossOrderType;

typedef enum {
    LoginTypeAppStore    = 0,
    LoginTypeTB          = 1,        //同步推
    LoginTypeKY          = 2,        //快用
    LoginTypePP          = 3,        //PP助手
    LoginType91          = 4,        //91
    LoginTypeSPG         = 5,        //搜苹果
    LoginTypeiTools      = 6,        //iTools
    LoginTypeDefined     = 999,
}LoginType;

typedef enum {
    UCenterUserTypeNone     = -1,       //none
    UCenterUserTypeNormal   = 0,        //normal user
    UCenterUserTypeDevice   = 1,        //device user
    UCenterUserTypeSNS      = 2,        //sns登录
}UCenterUserType;

typedef enum {
    ChannelToolBarAtTopLeft = 1,            /**< 左上 */
    ChannelToolBarAtTopRight,              /**< 右上 */
    ChannelToolBarAtMiddleLeft,            /**< 左中 */
    ChannelToolBarAtMiddleRight,           /**< 右中 */
    ChannelToolBarAtBottomLeft,            /**< 左下 */
    ChannelToolBarAtBottomRight,           /**< 右下 */
}ChannelToolBarPlace;

typedef enum{
    NonConsumables = 0,//不可消耗
    Consumables,//可消耗
    Auto_Subscription,//自动订阅
    None_Auto_Subscription//非自动订阅
}ProductType;

typedef enum {
    Yodo1ErrorInfo_None = -1,
    Yodo1ErrorInfo_NoReceipt,//没有发票信息
    Yodo1ErrorInfo_InvalidParameters//参数错误
}Yodo1ErrorInfo;

typedef enum {
    Default = 0,
    Visible,
    Hide
}Yodo1PromotionVisibility;

#endif /* Yodo1Types_h */
