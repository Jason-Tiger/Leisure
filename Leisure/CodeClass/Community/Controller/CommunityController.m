//
//  CommunityController.m
//  Leisure
//
//  Created by 若愚 on 16/2/10.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "CommunityController.h"
#import "CommunityCell.h"
#import "CommunityModel.h"
#import "CommunityDetailController.h"
#import "ReadCommentController.h"



@interface CommunityController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UISegmentedControl *segment;
@property(nonatomic, strong)UITableView *aNewTableView;
@property(nonatomic, strong)UITableView *hotTableView;
@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)NSMutableArray *aNewModelArray;
@property(nonatomic, strong)NSMutableArray *hotModelArray;

@property(nonatomic, assign)NSInteger aNewNum;
@property(nonatomic, assign)NSInteger hotNum;

@property(nonatomic, assign)CGPoint aNewPoint;
@property(nonatomic, assign)CGPoint hotPoint;

@end

@implementation CommunityController

#pragma mark -- 布局 --
- (void)addSubViews
{
    self.segment = [[UISegmentedControl alloc]initWithItems:@[@"New", @"Hot"]];
    self.segment.frame = CGRectMake((KScreenWidth - 120) / 2, 10 + 71, 120, 20);
    self.segment.selectedSegmentIndex = 0;
    self.segment.tintColor = [UIColor grayColor];
    [self.view addSubview:_segment];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10 + 71 + 20 + 10, KScreenWidth, KScreenHeight - (10 + 71 + 20 + 10))];
    self.scrollView.contentSize = CGSizeMake((KScreenWidth) * 2, KScreenHeight - (10 + 71 + 20 + 10));
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.tag = 301;
    [self.view addSubview:_scrollView];
    
    self.aNewTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - (10 + 71 + 20 + 10)) style:UITableViewStylePlain];
    self.aNewTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.aNewTableView.delegate = self;
    self.aNewTableView.dataSource = self;
    self.aNewTableView.tag = 302;
    [self.aNewTableView registerClass:[CommunityCell class] forCellReuseIdentifier:@"aNewCell"];
    [self.scrollView addSubview:_aNewTableView];
    
    self.hotTableView = [[UITableView alloc]initWithFrame:CGRectMake(KScreenWidth, 0, KScreenWidth, KScreenHeight - (10 + 71 + 20 + 10)) style:UITableViewStylePlain];
    self.hotTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.hotTableView.delegate = self;
    self.hotTableView.dataSource = self;
    self.hotTableView.tag = 303;
    [self.hotTableView registerClass:[CommunityCell class] forCellReuseIdentifier:@"hotCell"];
    [self.scrollView addSubview:_hotTableView];
}

#pragma mark -- 获得new界面数据 --
- (void)getNewModelArray
{
    
    //    deviceid=63A94D37-33F9-40FF-9EBB-481182338873&typeid=12&client=1&sort=addtime&limit=10&version=3.0.2&auth=Wc06FCrkoq1DCMVzGMTikDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQ x1c4P0&start=0
    NSDictionary *aNewDic = @{@"sort":@"addtime",@"limit":[NSString stringWithFormat:@"%ld", _aNewNum * 10]};
    [RequestManager requestWithUrl:KGroupPosts_hotlistUrl requestType:requestTypePost parDic:aNewDic finish:^(NSData *data) {
        self.aNewModelArray = [CommunityModel modelConfigureData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.aNewTableView reloadData];
            if (_aNewNum - 1) {
                self.aNewTableView.contentOffset = _aNewPoint;
            }
        });
        
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
}

#pragma mark -- 获得hot界面的数组 --
- (void)getHotModelArray
{
    NSDictionary *hotDic = @{@"sort":@"hot",@"limit":[NSString stringWithFormat:@"%ld", _hotNum * 10]};
    [RequestManager requestWithUrl:KGroupPosts_hotlistUrl requestType:requestTypePost parDic:hotDic finish:^(NSData *data) {
        self.hotModelArray = [CommunityModel modelConfigureData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.hotTableView reloadData];
            if (_hotNum - 1) {
                self.hotTableView.contentOffset = _hotPoint;
            }
        });
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
}

#pragma mark -- 最新加上拉加载 --
- (void)addFooterForNew
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshDataForNew:)];
    footer.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.aNewTableView addSubview:footer];
}

#pragma mark -- 最火加上拉加载 --
- (void)addFooterForHot
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshDataForHot:)];
    footer.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.hotTableView addSubview:footer];
}


#pragma mark -- 添加方法 --
- (void)addAction
{
    [self.segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark -- 加下拉刷新 --
- (void)addHeader
{
    MJRefreshNormalHeader *header1 = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshData:)];
    header1.tag = 111;
    header1.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.aNewTableView addSubview:header1];
    
    MJRefreshNormalHeader *header2 = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshData:)];
    header2.tag = 112;
    header2.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.hotTableView addSubview:header2];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.aNewNum = 1;
    self.hotNum = 1;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.typeLabel.text = @"社区";
    
    [self addSubViews];
    [self addAction];
    [self getNewModelArray];
    [self getHotModelArray];
    [self addHeader];
    [self addFooterForNew];
    [self addFooterForHot];
}

#pragma mark -- 最新的上拉加载方法 --
- (void)footerRefreshDataForNew:(MJRefreshAutoNormalFooter *)footer
{
    self.aNewNum ++;
    self.aNewPoint = _aNewTableView.contentOffset;
    [self getNewModelArray];
    [footer endRefreshing];
}

#pragma mark -- 最火的上拉加载方法 --
- (void)footerRefreshDataForHot:(MJRefreshAutoNormalFooter *)footer
{
    self.hotNum ++;
    self.hotPoint = _hotTableView.contentOffset;
    [self getHotModelArray];
    [footer endRefreshing];
}

#pragma mark -- 下拉刷新 --
- (void)headerRefreshData:(MJRefreshNormalHeader *)header
{
    if (header.tag == 111) {
        self.aNewNum = 1;
        [self getNewModelArray];
    }
    else if (header.tag == 112) {
        self.hotNum = 1;
        [self getHotModelArray];
    }
    [header endRefreshing];
}

#pragma mark -- 转换界面 --
- (void)segmentAction:(UISegmentedControl *)seg
{
    if (seg.selectedSegmentIndex == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollView.contentOffset = CGPointMake(0, 0);
        }];
    }
    else if (seg.selectedSegmentIndex == 1) {
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollView.contentOffset = CGPointMake(KScreenWidth, 0);
        }];
    }
}

#pragma mark -- 滑动结束时 --
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 301) {
        NSInteger index = (NSInteger)scrollView.contentOffset.x / KScreenWidth;
        self.segment.selectedSegmentIndex = index;
    }
}

#pragma mark -- tableView代理 --
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 302) {
        return _aNewModelArray.count;
    }
    else {
        return _hotModelArray.count;
    }
    //    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 302) {
        CommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aNewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cell.backgroundColor = [UIColor orangeColor];
        CommunityModel *model = _aNewModelArray[indexPath.row];
        [cell cellConfigureModel:model];
        return cell;
    }
    else {
        CommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cell.backgroundColor = [UIColor blueColor];
        CommunityModel *model = _hotModelArray[indexPath.row];
        [cell cellConfigureModel:model];
        return cell;
    }
}

#pragma mark -- 点击cell --
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (tableView.tag == 302) {
    //        CommunityModel *model = _aNewModelArray[indexPath.row];
    //        CommunityDetailController *detailVc = [[CommunityDetailController alloc]initWithContentid:model.contentid type:model.title];
    //        [self.view.window.rootViewController presentViewController:detailVc animated:YES completion:nil];
    //    }
    //    else if (tableView.tag == 303) {
    //        CommunityModel *model = _hotModelArray[indexPath.row];
    //        CommunityDetailController *detailVc = [[CommunityDetailController alloc]initWithContentid:model.contentid type:model.title];
    //        [self.view.window.rootViewController presentViewController:detailVc animated:YES completion:nil];
    //    }
    
    if (tableView.tag == 302) {
        CommunityModel *model = _aNewModelArray[indexPath.row];
        ReadCommentController *detailVc = [[ReadCommentController alloc]initWithContentid:model.contentid];
        [self.view.window.rootViewController presentViewController:detailVc animated:YES completion:nil];
    }
    else if (tableView.tag == 303) {
        CommunityModel *model = _hotModelArray[indexPath.row];
        ReadCommentController *detailVc = [[ReadCommentController alloc]initWithContentid:model.contentid];
        [self.view.window.rootViewController presentViewController:detailVc animated:YES completion:nil];
    }
}

#pragma mark -- 返回cell高度 --
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 302) {
        CommunityModel *model = _aNewModelArray[indexPath.row];
        return [CommunityCell heightOfRowWithModel:model];
    }
    else {
        CommunityModel *model = _hotModelArray[indexPath.row];
        return [CommunityCell heightOfRowWithModel:model];
    }
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
