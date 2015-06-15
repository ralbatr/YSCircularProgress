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
{
    NSInteger time;
    NSTimer *timer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    time = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(repeats) userInfo:nil repeats:YES];
}

- (void)repeats {
    for (id subView in [self.view subviews]) {
        if ([subView isKindOfClass:[YSCircularView class]]) {
            [subView removeFromSuperview];
        }
    }
    YSCircularView *circularView = [[YSCircularView alloc] init];
    circularView.second = (CGFloat)time++;
    circularView.total = 10.0;
    circularView.lineWidth = 8;
    circularView.frame = CGRectMake(0, 40, 110, 210);
    if (time-1 == circularView.total) {
        [timer invalidate];
        NSLog(@"计时完成");
    }
//    circularView.countUp = YES;
    [self.view addSubview:circularView];
}


@end
