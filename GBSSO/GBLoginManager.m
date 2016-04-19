//
//  KSFCLoginManager.m
//  第三方登录
//
//  Created by marks on 15/6/3.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.


#import "GBLoginManager.h"
#import "UMSocial.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialRenrenHandler.h"

@implementation GBLoginManager

/**
 *  QQ授权
 */
+(void)QQSSOWithDelegate:(UIViewController*)Delegate AndGetUserinfoBlock:(getUserInfoBlock)Block{
 
    //在QQ登录按钮中实现下面的方法
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(Delegate,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];

            
            
            NSLog(@"snsAccount%@",snsAccount);
            NSDictionary*AccountInfo=@{
                                       @"userName":snsAccount.userName,
                                       @"usid":snsAccount.usid,
                                       @"accessToken":snsAccount.accessToken,
                                       @"iconURL":snsAccount.iconURL,
                                       };
            
            Block(AccountInfo);
            
            
        }});

    //获取好友列表由于平台的设置一般来说只能获取30%的好友
    [[UMSocialDataService defaultDataService] requestSnsFriends:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsFriends is %@",response.data);
    }];

}
/**
 *  新浪授权
 */
+(void)SinaSSO:(UIViewController*)Delegate AndGetUserinfoBlock:(getUserInfoBlock)Block{
    

    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(Delegate,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            NSLog(@"snsAccount%@",snsAccount);
            NSDictionary*AccountInfo=@{
                                       @"userName":snsAccount.userName,
                                       @"usid":snsAccount.usid,
                                       @"accessToken":snsAccount.accessToken,
                                       @"iconURL":snsAccount.iconURL,
                                       };
            
            Block(AccountInfo);
            
            
            
        }});
    
    //在授权完成后调用获取用户信息的方法
    //获取accestoken以及新浪用户信息，得到的数据在回调Block对象形参respone的data属性
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsInformation is %@",response.data);
    }];
    
    //获取好友列表调用下面的方法,由于新浪官方限制，获取好友列表只能获取到30%好友
    [[UMSocialDataService defaultDataService] requestSnsFriends:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsFriends is %@",response.data);
    }];
    
}
/**
 *  微信授权
 */
+(void)WeiChatSSO:(UIViewController*)Delegate AndGetUserinfoBlock:(getUserInfoBlock)Block{

    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(Delegate,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        //          获取用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            NSLog(@"snsAccount%@",snsAccount);
            NSDictionary*AccountInfo=@{
                                       @"userName":snsAccount.userName,
                                       @"usid":snsAccount.usid,
                                       @"accessToken":snsAccount.accessToken,
                                       @"iconURL":snsAccount.iconURL,
                                       };
            
            Block(AccountInfo);
        }
        
    });
    
    //在授权完成后调用获取用户信息的方法
    //得到的数据在回调Block对象形参respone的data属性
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsInformation is %@",response.data);
    }];
    
    //获取好友列表由于平台的设置一般来说只能获取30%的好友
    [[UMSocialDataService defaultDataService] requestSnsFriends:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsFriends is %@",response.data);
    }];


    
}

/**
 *  QQ空间
 */
+(void)QQZoneSSO:(UIViewController*)Delegate AndGetUserinfoBlock:(getUserInfoBlock)Block{
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone];
    
    snsPlatform.loginClickHandler(Delegate,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQzone];
            NSLog(@"snsAccount%@",snsAccount);
            NSDictionary*AccountInfo=@{
                                       @"userName":snsAccount.userName,
                                       @"usid":snsAccount.usid,
                                       @"accessToken":snsAccount.accessToken,
                                       @"iconURL":snsAccount.iconURL,
                                       };

            
            
             Block(AccountInfo);
            
        }});

    //获取好友列表由于平台的设置一般来说只能获取30%的好友
    [[UMSocialDataService defaultDataService] requestSnsFriends:UMShareToQzone  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsFriends is %@",response.data);
    }];

    
    
}

/**
 *  人人网
 */
+(void)RenRenSSO:(UIViewController*)Delegate AndGetUserinfoBlock:(getUserInfoBlock)Block{
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToRenren];
    
    snsPlatform.loginClickHandler(Delegate,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQzone];
            NSLog(@"snsAccount%@",snsAccount);
            NSDictionary*AccountInfo=@{
                                       @"userName":snsAccount.userName,
                                       @"usid":snsAccount.usid,
                                       @"accessToken":snsAccount.accessToken,
                                       @"iconURL":snsAccount.iconURL,
                                       };
            
            
            
            Block(AccountInfo);
            
        }});
    //获取好友列表由于平台的设置一般来说只能获取30%的好友
    [[UMSocialDataService defaultDataService] requestSnsFriends:UMShareToRenren  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsFriends is %@",response.data);
    }];

    
    
}
/**
 *  腾讯微博
 */
+(void)TencentWeiboSSO:(UIViewController*)Delegate AndGetUserinfoBlock:(getUserInfoBlock)Block{
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToTencent];
    
    snsPlatform.loginClickHandler(Delegate,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQzone];
            NSLog(@"snsAccount%@",snsAccount);
            NSDictionary*AccountInfo=@{
                                       @"userName":snsAccount.userName,
                                       @"usid":snsAccount.usid,
                                       @"accessToken":snsAccount.accessToken,
                                       @"iconURL":snsAccount.iconURL,
                                       };
            
            
            
            Block(AccountInfo);
            
        }});
    //获取好友列表由于平台的设置一般来说只能获取30%的好友
    [[UMSocialDataService defaultDataService] requestSnsFriends:UMShareToTencent  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsFriends is %@",response.data);
    }];

    
    
    
}
/**
 *   AppDelegate设置参数方法
 */
+(void)AppDelegateConfigSSO{
    
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UmengAppkey];
    
    //打开调试log的开关
    [UMSocialData openLog:YES];
    
    //如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:WXAppId appSecret:WXappSecret url:WXurl];
    
    //打开新浪微博的SSO开关
    //[UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    [UMSocialSinaSSOHandler openNewSinaSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    //打开腾讯微博SSO开关，设置回调地址，只支持32位
    // [UMSocialTencentWeiboHandler openSSOWithRedirectUrl:@"http://sns.whalecloud.com/tencent2/callback"];
    
    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:QQAppId appKey:QQappKey url:QQurl];
    //    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    
    //打开人人网SSO开关
    [UMSocialRenrenHandler openSSO];
    
}
/**
 *  注销登录
 */
+(void)cancelLogin{
    //删除授权调用下面的方法
    if([UMSocialAccountManager isOauthWithPlatform:UMShareToRenren]){
        
        [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToRenren completion:^(UMSocialResponseEntity *response){
                NSLog(@"response is %@",response.description);
            if (response.responseCode == UMSResponseCodeSuccess){
                
                NSLog(@"人人解除授权成功");
                
            }
           
            
        }];
        
    }
    
     if([UMSocialAccountManager isOauthWithPlatform:UMShareToQQ]){
        
        [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToQQ completion:^(UMSocialResponseEntity *response){
                NSLog(@"response is %@",response.description);
            if (response.responseCode == UMSResponseCodeSuccess){
                
                NSLog(@"qq解除授权成功");
                
            }
            
            
        }];

    }
     if([UMSocialAccountManager isOauthWithPlatform:UMShareToSina]){
        [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response){
            
                NSLog(@"response is %@",response.description);
            if (response.responseCode == UMSResponseCodeSuccess){
                
                NSLog(@"新浪解除授权成功");
                
            }

            
        }];
        
    }
    
     if([UMSocialAccountManager isOauthWithPlatform:UMShareToWechatSession]){
        
        [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
                NSLog(@"response is %@",response.description);
            if (response.responseCode == UMSResponseCodeSuccess){
                
                NSLog(@"朋友圈解除授权成功");
                
            }
            
        }];
    }
   else if([UMSocialAccountManager isOauthWithPlatform:UMShareToTencent]){
        [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToTencent  completion:^(UMSocialResponseEntity *response){
                NSLog(@"response is %@",response.description);
            if (response.responseCode == UMSResponseCodeSuccess){
                
                NSLog(@"腾讯微博解除授权成功");
                
            }
            
        }];
    }
     if([UMSocialAccountManager isOauthWithPlatform:UMShareToQzone]){
        [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToQzone  completion:^(UMSocialResponseEntity *response){
                NSLog(@"response is %@",response.description);

            if (response.responseCode == UMSResponseCodeSuccess){
                
                NSLog(@"qq空间解除授权成功");
                
            }
            
        }];
    }
    
    
    
}
@end
