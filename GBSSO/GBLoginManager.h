//
//  KSFCLoginManager.h
//  第三方登录
//
//  Created by marks on 15/6/3.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.
//
/**
 * 集成说明：
 *1.将官方的SDK文件、支持的平台文件、GBSSO文件导入到工程中
 *2.添加SDK依赖的系统库文件：
 *  ◦	Security.framework
	◦	libiconv.dylib
	◦	SystemConfiguration.framework
	◦	CoreGraphics.Framework
	◦	libsqlite3.dylib
	◦	CoreTelephony.framework
	◦	libstdc++.dylib
	◦	libz.dylib
 *3.点击项目名称,点击“Info”选项卡，在URL types里面添加一项，Identifier可以不填，URL schemes必须和appScheme的值相同，url scheme设置格式：
     1.新浪微博-> “sina.”+友盟appkey，例如“sina.507fcab25270157b37000010”
     2.腾讯微博->
      “wb”+你在友盟后台绑定的腾讯微博App Key，例如“wb801345073”
     3.微信->微信应用appId，例如“wxd9a39c7122aa6516”
     4.人人网->“rm”+你的应用bundle id，例如“rmcom.umeng.SocialSDK”
     5.QQ及QQZone->
       <1>. “QQ”+腾讯QQ互联应用appId转换成十六进制（不足8位前面补0），例如“QQ05FC5B14”。并在QQ互联后台的URL schema中填入此字符串保持一致。
       <2>.“tencent“+腾讯QQ互联应用Id，例如“tencent100424468"。
 
     *注意QQ、QQ空间需要添加两个URL schemes
 
 *4.配置AppDelegate参数调用  AppDelegateConfigSSO只需要一句代码具体参数在GBSSO.h文件中修改。但是AppDelegate还是要复制写入下面这两句：
     - (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
     {
     
     return  [UMSocialSnsService handleOpenURL:url];
     
     }
     - (BOOL)application:(UIApplication *)application
     openURL:(NSURL *)url
     sourceApplication:(NSString *)sourceApplication
     annotation:(id)annotation
     {
     
     return  [UMSocialSnsService handleOpenURL:url];
     
     }
 
 
 *5.在调用的地方包含头文件KSFCLoginManager.h
 *6.支持block回调
 */
#import <Foundation/Foundation.h>
#import "UMSocial.h"
#import "GBSSO.h"
typedef void (^getUserInfoBlock)(NSDictionary*snsAccount);

@interface GBLoginManager : NSObject<UMSocialUIDelegate>{
    
    
}
/**
 *  QQ授权
 */
+(void)QQSSOWithDelegate:(UIViewController*)Delegate AndGetUserinfoBlock:(getUserInfoBlock)Block;
/**
 *  新浪授权
 */
+(void)SinaSSO:(UIViewController*)Delegate AndGetUserinfoBlock:(getUserInfoBlock)Block;
/**
 *  微信授权
 */
+(void)WeiChatSSO:(UIViewController*)Delegate AndGetUserinfoBlock:(getUserInfoBlock)Block;
/**
 *    QQZone
 */

+(void)QQZoneSSO:(UIViewController*)Delegate AndGetUserinfoBlock:(getUserInfoBlock)Block;

/**
 *  人人网
 */
+(void)RenRenSSO:(UIViewController*)Delegate AndGetUserinfoBlock:(getUserInfoBlock)Block;
/**
 *  腾讯微博
 */
+(void)TencentWeiboSSO:(UIViewController*)Delegate AndGetUserinfoBlock:(getUserInfoBlock)Block;
/**
 *   AppDelegate设置参数方法
 */

+(void)AppDelegateConfigSSO;
/**
 *  注销登录
 */
+(void)cancelLogin;


@end
