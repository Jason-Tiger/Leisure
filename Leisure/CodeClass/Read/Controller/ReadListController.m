//
//  ReadListController.m
//  Leisure
//
//  Created by 若愚 on 16/2/12.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "ReadListController.h"
#import "ReadListCell.h"
#import "ReadListModel.h"
#import "ReadDetailController.h"




@interface ReadListController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property(nonatomic, strong)UIButton *aNewButton;
@property(nonatomic, strong)UIButton *hotButton;
@property(nonatomic, strong)UIView *lineView;
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

@implementation ReadListController

#pragma mark -- 获得new界面数据 --
- (void)getNewModelArray
{
    
//    deviceid=63A94D37-33F9-40FF-9EBB-481182338873&typeid=12&client=1&sort=addtime&limit=10&version=3.0.2&auth=Wc06FCrkoq1DCMVzGMTikDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQ x1c4P0&start=0
    NSDictionary *aNewDic = @{@"deviceid":@"63A94D37-33F9-40FF-9EBB-481182338873",@"typeid":
                                  _typeID,@"client":@"1",@"sort":@"addtime",@"limit":[NSString stringWithFormat:@"%ld", _aNewNum * 10],@"version":@"3.0.2",@"auth":@"Wc06FCrkoq1DCMVzGMTikDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQ x1c4P0",@"start":@"0"};
    [RequestManager requestWithUrl:KReadColumns_detailUrl requestType:requestTypePost parDic:aNewDic finish:^(NSData *data) {
        self.aNewModelArray = [ReadListModel modelConfigureData:data];
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
    NSDictionary *hotDic = @{@"deviceid":@"63A94D37-33F9-40FF-9EBB-481182338873", @"typeid":
                                 _typeID, @"client":@"1", @"sort":@"hot", @"limit":[NSString stringWithFormat:@"%ld", _hotNum * 10], @"version":@"3.0.2", @"auth":@"Wc06FCrkoq1DCMVzGMTikDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQ x1c4P0", @"start":@"0"};
    [RequestManager requestWithUrl:KReadColumns_detailUrl requestType:requestTypePost parDic:hotDic finish:^(NSData *data) {
        self.hotModelArray = [ReadListModel modelConfigureData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.hotTableView reloadData];
            if (_hotNum - 1) {
                self.aNewTableView.contentOffset = _hotPoint;
            }
        });
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
}

#pragma mark -- 自定义初始化 --
- (instancetype)initWithTypeID:(NSString *)typeID typeName:(NSString *)typeName
{
    if ([super init]) {
        self.typeID = typeID;
        self.typeName = typeName;
    }
    return self;
}

#pragma mark -- 控件添加方法 --
- (void)addAction
{
    [self.changeFrameButton addTarget:self action:@selector(returnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.aNewButton addTarget:self action:@selector(moveToNew:) forControlEvents:UIControlEventTouchUpInside];
    [self.hotButton addTarget:self action:@selector(moveToHot:) forControlEvents:UIControlEventTouchUpInside];
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

#pragma mark -- 布局 --
- (void)addSubViews
{
    self.aNewButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.aNewButton.frame = CGRectMake(KScreenWidth - 110, 30, 30, 30);
    self.aNewButton.backgroundColor = [UIColor colorWithRed:214 / 255.0 green:197 / 255.0 blue:119 / 255.0 alpha:1];
    [self.aNewButton setTitle:@"New" forState:UIControlStateNormal];
    self.aNewButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.aNewButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_aNewButton];
    
    self.hotButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.hotButton.frame = CGRectMake(KScreenWidth - 110 + 30 + 30, 30, 30, 30);
    self.hotButton.backgroundColor = [UIColor colorWithRed:214 / 255.0 green:197 / 255.0 blue:119 / 255.0 alpha:1];
    [self.hotButton setTitle:@"Hot" forState:UIControlStateNormal];
    self.hotButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.hotButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_hotButton];
    
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(KScreenWidth - 110 + 2, 30 + 30 + 5, 26, 2)];
    self.lineView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_lineView];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 71, KScreenWidth, KScreenHeight - 71)];
    self.scrollView.contentSize = CGSizeMake(KScreenWidth * 2, KScreenHeight - 71);
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.tag = 201;
    [self.view addSubview:_scrollView];
    
    self.aNewTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 71) style:UITableViewStylePlain];
//    self.aNewTableView.backgroundColor = [UIColor orangeColor];
    self.aNewTableView.dataSource = self;
    self.aNewTableView.delegate = self;
    self.aNewTableView.tag = 101;
    [self.aNewTableView registerClass:[ReadListCell class] forCellReuseIdentifier:@"newCell"];
    self.aNewTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:_aNewTableView];
    
    self.hotTableView = [[UITableView alloc]initWithFrame:CGRectMake(KScreenWidth, 0, KScreenWidth, KScreenHeight - 71) style:UITableViewStylePlain];
    self.hotTableView.dataSource = self;
    self.hotTableView.delegate = self;
    self.hotTableView.tag = 102;
    [self.hotTableView registerClass:[ReadListCell class] forCellReuseIdentifier:@"hotCell"];
    self.hotTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:_hotTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.aNewNum = 1;
    self.hotNum = 1;
    // Do any additional setup after loading the view.
    
    [self.changeFrameButton setTitle:@"←" forState:UIControlStateNormal];
    self.typeLabel.text = _typeName;
    self.view.backgroundColor = [UIColor whiteColor];
    
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

#pragma mark -- 滑到New界面 --
- (void)moveToNew:(UIButton *)button
{
    CGRect frame = _lineView.frame;
    frame.origin.x = KScreenWidth - 110 + 2;
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.contentOffset = CGPointMake(0, 0);
        self.lineView.frame = frame;
    } completion:nil];
}

#pragma mark -- 滑到Hot界面 --
- (void)moveToHot:(UIButton *)button
{
    CGRect frame = _lineView.frame;
    frame.origin.x = KScreenWidth - 110 + 60 + 2;
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.contentOffset = CGPointMake(KScreenWidth, 0);
        self.lineView.frame = frame;
    } completion:nil];
}

#pragma mark -- tableView代理 --
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView.tag == 101) {
        return _aNewModelArray.count;
    }
    else {
        return _hotModelArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 101) {
        ReadListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newCell" forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor cyanColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ReadListModel *model = _aNewModelArray[indexPath.row];
        [cell cellConfigureModel:model];
        return cell;
    }
    else {
        ReadListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ReadListModel *model = _hotModelArray[indexPath.row];
        [cell cellConfigureModel:model];
        return cell;
    }
}

#pragma mark -- 结束减速 --
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 201) {
        CGRect frame = _lineView.frame;
        if (_scrollView.contentOffset.x == 0) {
            frame.origin.x = KScreenWidth - 110 + 2;
        }
        else if (_scrollView.contentOffset.x == KScreenWidth) {
            frame.origin.x = KScreenWidth - 110 + 60 + 2;
        }
        [UIView animateWithDuration:0.3 animations:^{
            self.lineView.frame = frame;
        } completion:nil];
    }
    
}

#pragma mark -- 返回cell高度 --
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (25 + 30 + 17 + 17 + 60 + 1);
}

#pragma mark -- 返回 --
- (void)returnAction:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 点击cell --
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 101) {
        ReadListModel *model = _aNewModelArray[indexPath.row];
        ReadDetailController *detailVc = [[ReadDetailController alloc]initWithContentid:model.myID type:model.title];
        [self presentViewController:detailVc animated:YES completion:nil];
    }
    else if (tableView.tag == 102) {
        ReadListModel *model = _hotModelArray[indexPath.row];
        ReadDetailController *detailVc = [[ReadDetailController alloc]initWithContentid:model.myID type:model.title];
        [self presentViewController:detailVc animated:YES completion:nil];
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
