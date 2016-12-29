//
//  ViewController.m
//  个人详情页Test
//
//  Created by test on 16/12/28.
//  Copyright © 2016年 Szy. All rights reserved.
//

#import "ViewController.h"

#define NAVIGATBARLINECOLOR(ALPHA) [UIColor colorWithRed:200 / 255.0 green:199 / 255.0 blue:204 / 255.0 alpha:ALPHA]

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate> {
    /**
     *  记录原始值
     */
    CGFloat _szyTempImageHeight;
}
/**
 *  imageView的高度约束,修改高度达到效果
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;

@property (weak, nonatomic) IBOutlet UITableView *szyTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //记录高度
    _szyTempImageHeight = self.imageHeight.constant;
    //去掉navigatbar的背景图片
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉naviagtbar的分割线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    //不允许自动调整scrollview(Tableview)的insets
    self.automaticallyAdjustsScrollViewInsets = NO;
    //注册tableviewcell
    [self.szyTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    //设置tableview的insets(y点偏移200,图片的高度)
    self.szyTableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    //tableview去线
    self.szyTableView.showsVerticalScrollIndicator = NO;
    //创建titleView
    UILabel *label = [[UILabel alloc] init];
    label.text = @"个人详情页";
    [label sizeToFit];
    label.textColor = [UIColor colorWithWhite:0 alpha:0];
    /**
     *  注:navigationbar上的所有控件,设置alpha都没有效果
     *  通过设置文字颜色,和navigationbar上image的颜色来完成效果
     */
    self.navigationItem.titleView = label;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    /**
     *  用原始图片的高度 - scrollview内容的偏移量 + 原始高度 = 现在图片的高度
     */
    CGFloat tempHeight = _szyTempImageHeight - (scrollView.contentOffset.y + _szyTempImageHeight);
    
    /**
     *  让高度停止在64(navigationbar的高度(44) + statusBar的高度(20))
     */
    if (tempHeight < 64) {
        
        tempHeight = 64;
    }
    self.imageHeight.constant = tempHeight;
    
    /**
     *  设置图片的alpha 和 titleView的text的文字alpha
     *  计算出 偏移量在滚动距离中的百分比(滚动距离为图片的高度-64 = 134)
     */
    CGFloat alphaF = (scrollView.contentOffset.y + _szyTempImageHeight) / 134;
    
    if (alphaF >= 1) {
        
        alphaF = 0.99;
    }
    [self.navigationController.navigationBar setBackgroundImage:[self _returnImageWithColor:[UIColor colorWithWhite:1 alpha:alphaF]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[self _returnImageWithColor:NAVIGATBARLINECOLOR(alphaF)]];
    UILabel *title = (UILabel *)self.navigationItem.titleView;
    title.textColor = [UIColor colorWithWhite:0 alpha:alphaF];
}

/**
 *  传入color返回image
 */
- (UIImage *)_returnImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef rectContext = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(rectContext, [color CGColor]);
    CGContextFillRect(rectContext, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
