//
//  LandingController.m
//  Leisure
//
//  Created by 若愚 on 16/2/16.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "GBLoginManager.h"

#import "LandingController.h"
#import "LandingView.h"
#import "RegisterController.h"
#import "LandingModel.h"
//#import <UMSocial.h>

#define KLandUrl @"http://api2.pianke.me/user/login"

@interface LandingController () <UITextFieldDelegate>

@property(nonatomic, strong)LandingView *myView;
@property(nonatomic, strong)UIButton *registerButton;
@property(nonatomic, strong)LandingModel *model;

@end

@implementation LandingController

#pragma mark -- 布局 --
- (void)addSubViews
{
    self.myView = [[LandingView alloc]initWithFrame:CGRectMake(0, 71, KScreenWidth, KScreenHeight - 71)];
    [self.view addSubview:_myView];
    
    self.registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.registerButton.frame = CGRectMake(KScreenWidth - 20 - 30, 30, 30, 30);
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_registerButton];
}

#pragma mark -- 添加方法 --
- (void)addAction
{
    [self.changeFrameButton addTarget:self action:@selector(returnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.registerButton addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    self.myView.mailField.delegate = self;
    self.myView.passwordField.delegate = self;
    [self.myView.landingButton addTarget:self action:@selector(landingAction:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.myView.qqButton addTarget:self action:@selector(qqLanding:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userdic = [NSDictionary dictionary];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.changeFrameButton setTitle:@"←" forState:UIControlStateNormal];
    self.typeLabel.text = @"登陆";
    [self addSubViews];
    [self addAction];
    [_myView.weiXinButton addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [_myView.renRenButton addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [_myView.sinaButton addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [_myView.qqButton addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];



}

- (void)buttonclick:(UIButton*)button{
    if(button.tag==200){
        
        //新浪
        [GBLoginManager SinaSSO:self AndGetUserinfoBlock:^(NSDictionary *snsAccount) {
            
            _userdic = snsAccount;
            [[NSUserDefaults standardUserDefaults] setObject:_userdic[@"iconURL"] forKey:@"iconURL"];
            [[NSUserDefaults standardUserDefaults] setObject:_userdic[@"userName"] forKey:@"userName"];
            NSString *iconURL = [[NSUserDefaults standardUserDefaults] stringForKey:@"iconURL"];
            NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
            NSLog(@"\n\n\n userName================%@===========",userName);
            NSLog(@"\n\n\n iconURL================%@===========",iconURL);
            [self landingAction];
        }];
        
        
    }else if(button.tag==201){
        
        //微信
        
        [GBLoginManager WeiChatSSO:self AndGetUserinfoBlock:^(NSDictionary *snsAccount) {
           
            _userdic = snsAccount;
            [[NSUserDefaults standardUserDefaults] setObject:_userdic[@"iconURL"] forKey:@"iconURL"];
            [[NSUserDefaults standardUserDefaults] setObject:_userdic[@"userName"] forKey:@"userName"];
            NSString *iconURL = [[NSUserDefaults standardUserDefaults] stringForKey:@"iconURL"];
            NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
            NSLog(@"\n\n\n userName================%@===========",userName);
            NSLog(@"\n\n\n iconURL================%@===========",iconURL);

          [self landingAction];
            
        }];
        
        
        
    }else if (button.tag==202){
        //qq
        
        [GBLoginManager QQSSOWithDelegate:self AndGetUserinfoBlock:^(NSDictionary *snsAccount) {
           
            _userdic = snsAccount;
            
            
            [[NSUserDefaults standardUserDefaults] setObject:_userdic[@"iconURL"] forKey:@"iconURL"];
            [[NSUserDefaults standardUserDefaults] setObject:_userdic[@"userName"] forKey:@"userName"];
            NSString *iconURL = [[NSUserDefaults standardUserDefaults] stringForKey:@"iconURL"];
            NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
            NSLog(@"\n\n\n userName================%@===========",userName);
            NSLog(@"\n\n\n iconURL================%@===========",iconURL);
            
            [self landingAction];
            
        }];
        
        
    }else if(button.tag==103){
        
        //qqzone
        
        [GBLoginManager QQZoneSSO:self AndGetUserinfoBlock:^(NSDictionary *snsAccount) {
           
            _userdic = snsAccount;
            [[NSUserDefaults standardUserDefaults] setObject:_userdic[@"iconURL"] forKey:@"iconURL"];
            [[NSUserDefaults standardUserDefaults] setObject:_userdic[@"userName"] forKey:@"userName"];
            NSString *iconURL = [[NSUserDefaults standardUserDefaults] stringForKey:@"iconURL"];
            NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
            NSLog(@"\n\n\n userName================%@===========",userName);
            NSLog(@"\n\n\n iconURL================%@===========",iconURL);
            [self landingAction];
        }];
        
    }else if (button.tag==104){
        //腾讯微博
        
        [GBLoginManager TencentWeiboSSO:self AndGetUserinfoBlock:^(NSDictionary *snsAccount) {
           
            _userdic = snsAccount;
            [[NSUserDefaults standardUserDefaults] setObject:_userdic[@"iconURL"] forKey:@"iconURL"];
            [[NSUserDefaults standardUserDefaults] setObject:_userdic[@"userName"] forKey:@"userName"];
            NSString *iconURL = [[NSUserDefaults standardUserDefaults] stringForKey:@"iconURL"];
            NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
            NSLog(@"\n\n\n userName================%@===========",userName);
            NSLog(@"\n\n\n iconURL================%@===========",iconURL);
            [self landingAction];
        }];
        
        
        
    }else if (button.tag==205){
        //人人网
        [GBLoginManager RenRenSSO:self AndGetUserinfoBlock:^(NSDictionary *snsAccount) {
            
            _userdic = snsAccount;
            [[NSUserDefaults standardUserDefaults] setObject:_userdic[@"iconURL"] forKey:@"iconURL"];
            [[NSUserDefaults standardUserDefaults] setObject:_userdic[@"userName"] forKey:@"userName"];
            NSString *iconURL = [[NSUserDefaults standardUserDefaults] stringForKey:@"iconURL"];
            NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
            NSLog(@"\n\n\n userName================%@===========",userName);
            NSLog(@"\n\n\n iconURL================%@===========",iconURL);
            [self landingAction];
        }];
        
    }
    
    else  if(button.tag==106){
        
        // 解除授权
        
        [GBLoginManager cancelLogin];
        
        
    }
    
    
    
}
- (void)landingAction{
    NSString *iconURL = [[NSUserDefaults standardUserDefaults] stringForKey:@"iconURL"];
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLanding"];
        [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"user"];
    
    
    //NSLog(@"\n\n\n userName================%@===========",userName);
    //NSLog(@"\n\n\n iconURL================%@===========",iconURL);
    
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"登陆成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        });
    
}
/*
 #pragma mark -- QQ登陆 --
 - (void)qqLanding:(UIButton *)button
 {
 //    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
 //
 //    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
 //
 //        //          获取微博用户名、uid、token等
 //
 //        if (response.responseCode == UMSResponseCodeSuccess) {
 //
 //            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
 //
 //            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
 //
 //        }});
 
 
 UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToTencent];
 
 snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
 
 //          获取微博用户名、uid、token等
 
 if (response.responseCode == UMSResponseCodeSuccess) {
 
 UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
 
 NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
 
 }});
 }
 */

#pragma mark -- 界面出现时 --
- (void)viewWillAppear:(BOOL)animated
{
    NSString *email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSString *passwd = [[NSUserDefaults standardUserDefaults] stringForKey:@"passwd"];
    if (email != nil) {
        self.myView.mailField.text = email;
        self.myView.passwordField.text = passwd;
    }
}

#pragma mark -- 登陆 --
- (void)landingAction:(UIButton *)button
{
    NSDictionary *dic = @{@"email":_myView.mailField.text, @"passwd":_myView.passwordField.text};
    [RequestManager requestWithUrl:KLandUrl requestType:requestTypePost parDic:dic finish:^(NSData *data) {
        self.model = [LandingModel modelConfigureData:data];
        NSLog(@"model == %@", _model);
        if (_model.isOk) {
            [[NSUserDefaults standardUserDefaults] setObject:dic[@"email"] forKey:@"email"];
            [[NSUserDefaults standardUserDefaults] setObject:dic[@"passwd"] forKey:@"passwd"];
            LandingModel *model = [LandingDB findUserInfoWithName:_model.uname];
            NSLog(@"%@", model);
            if (model.auth == nil) {
                [LandingDB addUserInfoWithModel:_model];
            }
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLanding"];
            [[NSUserDefaults standardUserDefaults] setObject:_model.uname forKey:@"user"];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"登陆成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
            });
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:self.model.msg preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
            });
        }
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
}

#pragma mark -- 跳转到注册界面 --
- (void)registerAction:(UIButton *)button
{
    RegisterController *regVc = [[RegisterController alloc]init];
    [self presentViewController:regVc animated:YES completion:nil];
}

#pragma mark -- 返回 --
- (void)returnAction:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 回收键盘 --
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.myView.mailField resignFirstResponder];
    [self.myView.passwordField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
