//
//  ViewController.m
//  AnalogNexworkTimeout
//
//  Created by admin on 2018/3/26.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "DetectionTimeout.h"
#import "DetectionTimeout.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *requestBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 44)];
    [requestBtn setBackgroundColor:[UIColor redColor]];
    [requestBtn setTitle:@"开始请求" forState:UIControlStateNormal];
    [self.view addSubview:requestBtn];
    [requestBtn addTarget:self action:@selector(startRequest) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)startRequest{
    [[DetectionTimeout sharedDetectionTimeout] startTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
