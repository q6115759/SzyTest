//
//  ViewController.m
//  个人详情页Test
//
//  Created by test on 16/12/28.
//  Copyright © 2016年 Szy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
    CGFloat _szyTempImageHeight;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;

@property (weak, nonatomic) IBOutlet UITableView *szyTableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _szyTempImageHeight = self.imageHeight.constant;
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.szyTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.szyTableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    self.szyTableView.showsVerticalScrollIndicator = NO;
    UILabel *label = [[UILabel alloc] init];
    label.text = @"个人详情页";
    [label sizeToFit];
    label.textColor = [UIColor colorWithWhite:0 alpha:0];
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
    
    CGFloat tempHeight = _szyTempImageHeight - (scrollView.contentOffset.y + _szyTempImageHeight);
    
    if (tempHeight < 64) {
        
        tempHeight = 64;
    }
    self.imageHeight.constant = tempHeight;
    
    CGFloat alphaF = (scrollView.contentOffset.y + _szyTempImageHeight) / 134;
    
    if (alphaF >= 1) {
        
        alphaF = 0.99;
    }
    
    [self.navigationController.navigationBar setBackgroundImage:[self _returnImageWithColor:[UIColor colorWithWhite:1 alpha:alphaF]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[self _returnImageWithColor:[UIColor colorWithWhite:0 alpha:alphaF]]];
    UILabel *title = (UILabel *)self.navigationItem.titleView;
    title.textColor = [UIColor colorWithWhite:0 alpha:alphaF];
}

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
