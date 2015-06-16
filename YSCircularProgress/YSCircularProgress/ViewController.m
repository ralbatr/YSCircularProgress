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
    
    YSCircularView *circularView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    circularView = [[YSCircularView alloc] init];
    circularView.lineWidth = 8;
    circularView.displayType = secondAndMinute;
    circularView.frame = CGRectMake(0, 40, 110, 210);
    circularView.center = self.view.center;
    //    circularView.countUp = YES;
    [self.view addSubview:circularView];
}



// 简单思路，每次移除后再添加
- (void)repeats1 {
    for (id subView in [self.view subviews]) {
        if ([subView isKindOfClass:[YSCircularView class]]) {
            [subView removeFromSuperview];
        }
    }
    YSCircularView *circularView1 = [[YSCircularView alloc] init];
    circularView1.second = (CGFloat)time++;
    circularView1.total = 65.0;
    circularView1.lineWidth = 8;
    circularView1.displayType = secondAndMinute;
    circularView1.frame = CGRectMake(0, 40, 110, 210);
    if (time-1 == circularView1.total) {
        [timer invalidate];
        NSLog(@"计时完成");
    }
//    circularView.countUp = YES;
    [self.view addSubview:circularView1];
}
// 如果，时间改变，重绘视图
- (void)repeats {
    
    circularView.second = (CGFloat)time++;
    
    if (time-1 == circularView.total) {
        [timer invalidate];
        NSLog(@"计时完成");
    }
    
}

- (IBAction)startAciton {
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(repeats) userInfo:nil repeats:YES];
    circularView.total = 5.0;
    time = 0;
}


@end
