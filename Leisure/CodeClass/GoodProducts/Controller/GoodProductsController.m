//
//  GoodProductsController.m
//  Leisure
//
//  Created by 若愚 on 16/2/10.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "GoodProductsController.h"
#import "GoodProductCell.h"
#import "GoodProductModel.h"


@interface GoodProductsController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *modelArray;

@property(nonatomic, assign)NSInteger footNum;
@property(nonatomic, assign)CGPoint myPoint;

@property(nonatomic, assign)BOOL isRefreshing;

@property(nonatomic, strong)UILabel *headerLabel;

@end

@implementation GoodProductsController

#pragma mark -- 得到数据 --
- (void)getModelArray
{
    [RequestManager requestWithUrl:KGoodProductsUrl requestType:requestTypePost parDic:@{@"limit":@(_footNum * 10)} finish:^(NSData *data) {
        self.modelArray = [GoodProductModel modelConfigureData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
//            [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            if (_footNum - 1) {
                self.tableView.contentOffset = _myPoint;
            }
        });
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
}

#pragma mark -- 布局 --
- (void)addSubViews
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 71, KScreenWidth, KScreenHeight - 71) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[GoodProductCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    self.headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, -50, KScreenWidth, 50)];
    self.headerLabel.textAlignment = 1;
    [self.tableView addSubview:_headerLabel];
}

#pragma mark -- 加上拉加载 --
- (void)addFooter
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshData:)];
    footer.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.tableView addSubview:footer];
}

#pragma mark -- 加下拉刷新 --
- (void)addHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshData:)];
    header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.tableView addSubview:header];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.footNum = 1;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.typeLabel.text = @"良品";
    [self addSubViews];
    [self getModelArray];
    
    [self addHeader];
    [self addFooter];
    
}

/*
#pragma mark -- 自己写下拉刷新 --
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    if ([scrollView isDragging]) {
        self.isRefreshing = NO;
        if (y < 0) {
            if (y > -50) {
                self.headerLabel.text = @"再下拉一点";
            }
            else if (y < -50)
            {
                self.headerLabel.text = @"松手刷新";
            }
        }
    }
    else if(y < -50) {
        if (_isRefreshing == NO) {
            self.headerLabel.text = @"正在刷新";
            [self getModelArray];
            [scrollView setContentInset:UIEdgeInsetsMake(50, 0, 0, 0)];
            self.isRefreshing = YES;
        }
    }
}
*/

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
    return _modelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithRed:203 / 255.0 green:237 / 255.0 blue:244 / 255.0 alpha:1];
    GoodProductModel *model = _modelArray[indexPath.row];
    [cell cellConfigureModel:model];
    [cell.buyButton addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.buyButton.tag = 100 + indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark -- 购买 --
- (void)buyAction:(UIButton *)button
{
    GoodProductModel *model = _modelArray[button.tag - 100];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.buyurl]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20 + (KScreenWidth - 40) * 300 / 608 + 20 + 60;
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
