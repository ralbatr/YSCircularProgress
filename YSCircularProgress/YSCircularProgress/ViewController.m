//
//  ViewController.m
//  YSCircularProgress
//
//  Created by Ralbatr on 15/6/12.
//  Copyright (c) 2015年 ralbatr Yi. All rights reserved.
//

#import "ViewController.h"
#import "YSCircularView.h"

@interface ViewController ()<YSCircularViewDelegate>
{
    NSInteger time;
    NSTimer *timer;
    
    YSCircularView *circularView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor brownColor];
    
    circularView = [[YSCircularView alloc] init];
    circularView.lineWidth = 8;
    circularView.displayType = secondAndMinute;
    circularView.frame = CGRectMake(0, 40, 110, 210);
    circularView.center = self.view.center;
    circularView.circularViewDelegate = self;
    //    circularView.countUp = YES;
    [self.view addSubview:circularView];
}

- (IBAction)startAciton {
    circularView.total = 25*60.0;
    [circularView start];
    time = 0;
}
- (IBAction)stopAciton:(UIButton *)sender {
    [circularView stop];
}
- (IBAction)suspend:(UIButton *)sender {
    [circularView suspend];
}
- (IBAction)continue:(UIButton *)sender {
    [circularView continue];
}
#pragma mark 计时完成后代理
- (void)yscircularTimeRunOut {
    NSLog(@"yscircularTimeRunOut计时完成");
}


@end
