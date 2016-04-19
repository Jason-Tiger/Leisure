//
//  ReadDetailController.m
//  Leisure
//
//  Created by 若愚 on 16/2/14.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "ReadDetailController.h"
#import "ReadDetailModel.h"
#import "ReadCommentController.h"
//#import <UMSocial.h>



@interface ReadDetailController () <UIWebViewDelegate>

@property(nonatomic, strong)UIButton *fontButton;
@property(nonatomic, strong)UIButton *commentButton;
@property(nonatomic, strong)UIButton *collectButton;
@property(nonatomic, strong)UIButton *anotherButton;
@property(nonatomic, strong)UIWebView *webView;
@property(nonatomic, strong)ReadDetailModel *model;

@end

@implementation ReadDetailController

#pragma mark -- 自定义初始化 --
- (instancetype)initWithContentid:(NSString *)contentid type:(NSString *)type
{
    if ([super init]) {
        self.contentid = contentid;
        self.type = type;
    }
    return self;
}

#pragma mark -- 加一些方法 --
- (void)addAction
{
    [self.changeFrameButton addTarget:self action:@selector(returnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.commentButton addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.anotherButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -- 布局 --
- (void)addSubViews
{
//    self.fontButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.fontButton.frame = CGRectMake(KScreenWidth - 10 * 4 - 30 * 4, 30, 30, 30);
//    [self.fontButton setBackgroundImage:[UIImage imageNamed:@"font"] forState:UIControlStateNormal];
//    [self.view addSubview:_fontButton];
    
    self.commentButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.commentButton.frame = CGRectMake(KScreenWidth - 10 * 3 - 30 * 3 + 5, 35, 20, 20);
    self.commentButton.frame = CGRectMake(KScreenWidth - 20 - 20, 35, 20, 20);
    [self.commentButton setBackgroundImage:[UIImage imageNamed:@"08-chat"] forState:UIControlStateNormal];
    self.commentButton.titleLabel.font = [UIFont systemFontOfSize:9];
    [self.commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_commentButton];
    
//    self.collectButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.collectButton.frame = CGRectMake(KScreenWidth - 10 * 2 - 30 * 2 + 5, 35, 20, 20);
//    [self.collectButton setBackgroundImage:[UIImage imageNamed:@"29-heart"] forState:UIControlStateNormal];
//    self.collectButton.titleLabel.font = [UIFont systemFontOfSize:9];
//    [self.collectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.view addSubview:_collectButton];
    
//    self.anotherButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.anotherButton.frame = CGRectMake(KScreenWidth - 10 - 30, 30, 30, 30);
//    [self.anotherButton setTitle:@"•••" forState:UIControlStateNormal];
//    [self.anotherButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [self.view addSubview:_anotherButton];
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 71, KScreenWidth, KScreenHeight - 71)];
    self.webView.delegate = self;
    [self.view addSubview:_webView];
}

#pragma mark -- 请求数据 --
- (void)getModelArray:(NSString *)url requestType:(RequestType)requestType parDic:(NSDictionary *)dic
{
    // contentid=56e672255d77430b518b45c3&client=1&deviceid=63A94D37-33F9-40FF-9EBB-48 1182338873&auth=Wc06FCrkoq1DCMVzGMTikDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQx1c4P 0&version=3.0.2
    [RequestManager requestWithUrl:url requestType:requestType parDic:dic finish:^(NSData *data) {
        self.model = [ReadDetailModel modelConfigureData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.commentButton setTitle:[NSString stringWithFormat:@"%ld", _model.comment] forState:UIControlStateNormal];
//            [self.collectButton setTitle:[NSString stringWithFormat:@"%ld", _model.like] forState:UIControlStateNormal];
            self.model.htmlStr = [NSString importStyleWithHtmlString:_model.htmlStr];
            
//            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.tudou.com"]]];
            
            [self.webView loadHTMLString:_model.htmlStr baseURL:[NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath]];
        });
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect frame = self.typeLabel.frame;
    frame.size.width = 70 * Fit;
    self.typeLabel.font = [UIFont systemFontOfSize:17 * Fit];
    self.typeLabel.frame = frame;
    self.typeLabel.text = _type;
    [self addSubViews];
    [self.changeFrameButton setTitle:@"←" forState:UIControlStateNormal];
    [self addAction];
    [self getModelArray:KArticleInfoUrl requestType:requestTypePost parDic:@{@"contentid":_contentid}];
}

/*
#pragma mark -- 分享 --
- (void)shareAction:(UIButton *)button
{
    
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56ea4d3f67e58ec5760015b6"
                                      shareText:@"yollet的分享"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToSina,UMShareToTencent,nil]
                                       delegate:self];
//    [[UMSocialControllerService defaultControllerService] setShareText:@"分享内嵌文字" shareImage:[UIImage imageNamed:@"icon"] socialUIDelegate:self];        //设置分享内容和回调对象
//    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToTencent].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
}
 */

#pragma mark -- 跳出评论界面 --
- (void)commentAction:(UIButton *)button
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLanding"]) {
        ReadCommentController *commentVc = [[ReadCommentController alloc]initWithContentid:_contentid];
        [self presentViewController:commentVc animated:YES completion:nil];
    }
    else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

#pragma mark -- 返回 --
- (void)returnAction:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
