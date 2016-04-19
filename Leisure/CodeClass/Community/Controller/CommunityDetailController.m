//
//  CommunityDetailController.m
//  Leisure
//
//  Created by 若愚 on 16/2/19.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//
#import "CommunityDetailController.h"
#import "CommunityDetailCell.h"
#import "CommunityDetailHeader.h"
#import "ReadCommentController.h"
#import "ReadCommentModel.h"




@interface CommunityDetailController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIButton *commentButton;
@property(nonatomic, strong)UIButton *collectButton;
@property(nonatomic, strong)UIButton *anotherButton;
@property(nonatomic, strong)NSMutableArray *modelArray;
@property(nonatomic, assign)NSInteger footNum;
@property(nonatomic, assign)CGPoint myPoint;
@property(nonatomic, strong)CommunityDetailModel *model;

@end

@implementation CommunityDetailController

#pragma mark -- 自定义初始化 --
- (instancetype)initWithContentid:(NSString *)contentid type:(NSString *)type
{
    if ([super init]) {
        self.contentid = contentid;
        self.type = type;
    }
    return self;
}

#pragma mark -- 加下拉刷新 --
- (void)addHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshData:)];
    header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.tableView addSubview:header];
}

#pragma mark -- 加上拉加载 --
- (void)addFooter
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshData:)];
    footer.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.tableView addSubview:footer];
}

#pragma mark -- 布局 --
- (void)addSubViews
{
        self.commentButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.commentButton.frame = CGRectMake(KScreenWidth - 10 * 3 - 30 * 3 + 5, 35, 20, 20);
        [self.commentButton setBackgroundImage:[UIImage imageNamed:@"08-chat"] forState:UIControlStateNormal];
        self.commentButton.titleLabel.font = [UIFont systemFontOfSize:9];
        [self.commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:_commentButton];
    
        self.collectButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.collectButton.frame = CGRectMake(KScreenWidth - 10 * 2 - 30 * 2 + 5, 35, 20, 20);
        [self.collectButton setBackgroundImage:[UIImage imageNamed:@"29-heart"] forState:UIControlStateNormal];
        self.collectButton.titleLabel.font = [UIFont systemFontOfSize:9];
        [self.collectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:_collectButton];
    
        self.anotherButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.anotherButton.frame = CGRectMake(KScreenWidth - 10 - 30, 30, 30, 30);
        [self.anotherButton setTitle:@"•••" forState:UIControlStateNormal];
        [self.anotherButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.view addSubview:_anotherButton];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 71, KScreenWidth, KScreenHeight - 71) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CommunityDetailHeader class] forHeaderFooterViewReuseIdentifier:@"commHeader"];
    [self.tableView registerClass:[CommunityDetailCell class] forCellReuseIdentifier:@"comDeCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_footer.hidden = YES;
    [self.view addSubview:_tableView];
}

#pragma mark -- 请求数据 --
- (void)getModelArray
{
    [RequestManager requestWithUrl:KGroupPosts_infoUrl requestType:requestTypePost parDic:@{@"contentid":_contentid, @"limit":@(10 * _footNum)} finish:^(NSData *data) {
        self.modelArray = [CommunityDetailModel modelConfigureData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            CommunityDetailModel *model = [_modelArray firstObject];
            [self.commentButton setTitle:[NSString stringWithFormat:@"%ld", model.comment] forState:UIControlStateNormal];
            [self.collectButton setTitle:[NSString stringWithFormat:@"%ld", model.like] forState:UIControlStateNormal];
            if (_footNum - 1) {
                self.tableView.contentOffset = _myPoint;
            }
        });
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
    
        [RequestManager requestWithUrl:KGroupPosts_infoUrl requestType:requestTypePost parDic:@{@"contentid":_contentid} finish:^(NSData *data) {
            self.model = [[CommunityDetailModel modelConfigureData:data] firstObject];
            [RequestManager requestWithUrl:KCommentGetUrl requestType:requestTypePost parDic:@{@"contentid":_contentid, @"limit":@(10 * _footNum)} finish:^(NSData *data) {
                self.modelArray = [ReadCommentModel modelConfigureData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                    [self.commentButton setTitle:[NSString stringWithFormat:@"%ld", _model.comment] forState:UIControlStateNormal];
                    [self.collectButton setTitle:[NSString stringWithFormat:@"%ld", _model.like] forState:UIControlStateNormal];
                    if (_footNum - 1) {
                        self.tableView.contentOffset = _myPoint;
                    }
                });
            } failure:^(NSError *error) {
                NSLog(@"请求失败");
            }];
    
        } failure:^(NSError *error) {
            NSLog(@"请求失败");
        }];
}

#pragma mark -- 加一些方法 --
- (void)addAction
{
    [self.changeFrameButton addTarget:self action:@selector(returnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.commentButton addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.anotherButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
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
    [self.changeFrameButton setTitle:@"←" forState:UIControlStateNormal];
    self.footNum = 1;
    
    [self addSubViews];
    [self addAction];
    [self getModelArray];
    [self addHeader];
    [self addFooter];
}

#pragma mark -- 上拉加载 --
- (void)footerRefreshData:(MJRefreshAutoNormalFooter *)footer
{
    self.footNum ++;
    self.myPoint = _tableView.contentOffset;
    [self getModelArray];
    [footer endRefreshing];
}

#pragma mark -- 下拉刷新 --
- (void)headerRefreshData:(MJRefreshNormalHeader *)header
{
    self.footNum = 1;
    [self getModelArray];
    [header endRefreshing];
}

#pragma mark -- tableView代理 --
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelArray.count - 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comDeCell" forIndexPath:indexPath];
    //    if (cell == nil) {
    //        cell = [[CommunityDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comDeCell" index:indexPath.row];
    //    }
    CommunityDetailModel *model = _modelArray[indexPath.row + 1];
    [cell cellConfigureModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

#pragma mark -- 返回表头 --
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CommunityDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"commHeader"];
    CommunityDetailModel *model = [_modelArray firstObject];
    [header headerConfigureModel:model];
    header.backgroundColor = [UIColor whiteColor];
    return header;
}

#pragma mark -- 返回表头高度 --
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CommunityDetailModel *model = [_modelArray firstObject];
    return [CommunityDetailHeader heightForHeader:model];
}

#pragma mark -- 返回cell高度 --
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityDetailModel *model = _modelArray[indexPath.row + 1];
    return [CommunityDetailCell heightForRow:model];
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
