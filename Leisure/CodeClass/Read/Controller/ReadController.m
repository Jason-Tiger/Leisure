//
//  ReadController.m
//  Leisure
//
//  Created by 若愚 on 16/2/10.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "ReadController.h"
#import "ReadCell.h"
#import "ReadListController.h"



@interface ReadController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)WheelView *scrollView;
@property(nonatomic, strong)UIPageControl *page;
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)UIImageView *downView;
@property(nonatomic, strong)NSMutableArray *modelArray;
@property(nonatomic, strong)NSMutableArray *imageArray;

@end

@implementation ReadController

- (void)dealloc
{
    [_scrollView.timer invalidate];
    _scrollView.timer = nil;
}

#pragma mark -- 布局 --
- (void)addSubViews
{
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight * 0.3 + 71, KScreenWidth, 1)];
    line1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line1];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, KScreenHeight * 0.3 + 71 + 1, KScreenWidth, KScreenHeight * 0.5) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[ReadCell class] forCellWithReuseIdentifier:@"readCell"];
    [self.view addSubview:_collectionView];
    
    self.downView = [[UIImageView alloc]initWithFrame:CGRectMake(0, KScreenHeight * 0.3 + 71 + 1 + KScreenHeight * 0.5, KScreenWidth, (KScreenHeight - (KScreenHeight * 0.3 + 71 + 1 + KScreenHeight * 0.5)))];
    self.downView.backgroundColor = [UIColor colorWithRed:231 / 255.0 green:233 / 255.0 blue:195 / 255.0 alpha:0.5];
//    self.downView.image = [UIImage imageNamed:@"xiaoGuang06"];
    [self.view addSubview:_downView];
    
//    self.page = [[UIPageControl alloc]initWithFrame:CGRectMake(KScreenWidth - 100 - 10, KScreenHeight * 0.3 + 71 - 10 - 20, 100, 20)];
//    self.page.backgroundColor = [UIColor clearColor];
//    self.page.numberOfPages = 5;
//    self.page.currentPageIndicatorTintColor = [UIColor blackColor];
//    self.page.currentPageIndicatorTintColor = [UIColor lightGrayColor];
//    [self.view addSubview:_page];
}

#pragma mark -- 获得轮播图数据 --
- (void)getImageArray
{
    [RequestManager requestWithUrl:KReadColumnsUrl requestType:requestTypePost parDic:nil finish:^(NSData *data) {
        NSMutableArray *imageArr = [ReadModel getImageArray:data];
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        self.imageArray = [NSMutableArray array];
        for (NSString *imageStr in imageArr) {
            [manager downloadImageWithURL:[NSURL URLWithString:imageStr] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                [self.imageArray addObject:image];
                if (_imageArray) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        self.scrollView = [[WheelView alloc]initWithFrame:CGRectMake(0, 71, KScreenWidth, KScreenHeight * 0.3) imageArray:_imageArray];
                        //            self.scrollView.backgroundColor = [UIColor colorWithRed:150 / 255.0 green:150 / 255.0 blue:250 / 255.0 alpha:1];
                        //    self.scrollView.contentSize =
                        [self.view addSubview:_scrollView];
                    });
                    
                }
            }];
        }
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
}

#pragma mark -- 获得数据 --
- (void)getModelArray:(NSString *)url requestType:(RequestType)requestType parDic:(NSDictionary *)dic
{
    [RequestManager requestWithUrl:url requestType:requestType parDic:dic finish:^(NSData *data) {
        self.modelArray = [ReadModel modelConfigureData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.collectionView reloadData];
            
        });
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
}

#pragma mark -- 加下拉刷新 --
- (void)addHeader
{
//    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshData:)];
//    [header setImages:@[[UIImage imageNamed:@"01-refresh"]] duration:0.5 forState:MJRefreshStateIdle];
//    [self.collectionView addSubview:header];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshData:)];
    header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.collectionView addSubview:header];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.typeLabel.text = @"阅读";
    [self getModelArray:KReadColumnsUrl requestType:requestTypePost parDic:nil];
    [self getImageArray];
    [self addSubViews];
    [self addHeader];
}


//#pragma mark -- 下拉刷新 --
//- (void)headerRefreshData:(MJRefreshGifHeader *)header
//{
////    [self getModelArray];
//    NSLog(@"刷新");
//    [header endRefreshing];
//}

#pragma mark -- 下拉刷新 --
- (void)headerRefreshData:(MJRefreshNormalHeader *)header
{
    [self getModelArray:KReadColumnsUrl requestType:requestTypePost parDic:nil];
//    NSLog(@"刷新");
    [header endRefreshing];
}

#pragma mark -- collectionView代理 --
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _modelArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ReadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"readCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    ReadModel *model = _modelArray[indexPath.item];
//    cell.userInteractionEnabled = YES;
    [cell cellConfigureModel:model];
    return cell;
}

#pragma mark -- 点击item --
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ReadModel *model = _modelArray[indexPath.item];
    ReadListController *readListVc = [[ReadListController alloc]initWithTypeID:[NSString stringWithFormat:@"%ld", model.type] typeName:model.name];
    [self.view.window.rootViewController presentViewController:readListVc animated:YES completion:nil];
    
}

#pragma mark -- 设置cell大小 --
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((KScreenWidth - 41) / 3, (KScreenWidth - 41) / 3);
}

#pragma mark -- 行边距 --
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

#pragma mark -- 列边距 --
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

#pragma mark -- 上下左右边距 --
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
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
