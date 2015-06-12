//
//  ViewController.m
//  YSCircularProgress
//
//  Created by Ralbatr on 15/6/12.
//  Copyright (c) 2015年 ralbatr Yi. All rights reserved.
//

#import "ViewController.h"
#import "YSCircularView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YSCircularView *circularView = [[YSCircularView alloc] init];
    circularView.frame = CGRectMake(0, 40, 20, 20);
    [self.view addSubview:circularView];
}


@end
