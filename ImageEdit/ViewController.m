//
//  ViewController.m
//  ImageEdit
//
//  Created by 胡天翔 on 2021/9/16.
//

#import "ViewController.h"
#import "ImageCroppingViewController.h"
#import <Masonry/Masonry.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =  @"图片编辑";
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    [button setTitle:@"跳转到图片裁剪页面" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [button setTitleColor:UIColor.blueColor forState:UIControlStateHighlighted];
    [button.layer setBorderWidth:1.0];
    [button.layer setBorderColor:[UIColor blackColor].CGColor];
    
    [self.view addSubview:button];
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.mas_equalTo(self.view);
            make.centerY.mas_equalTo(self.view);
    }];
}

- (void)clickButton{
    ImageCroppingViewController *imageCropping = [[ImageCroppingViewController alloc] init];
    [self.navigationController pushViewController:imageCropping animated:nil];
}

@end
