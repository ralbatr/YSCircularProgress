//
//  YSCircularView.m
//  YSCircularProgress
//
//  Created by Ralbatr on 15/6/12.
//  Copyright (c) 2015年 ralbatr Yi. All rights reserved.
//

#import "YSCircularView.h"

@interface YSCircularView()
{
    NSTimer *_timer;
    BOOL _isStart;
}

@end

IB_DESIGNABLE

@implementation YSCircularView


- (instancetype)init {
    self = [super init];
    if (self) {
        IBInspectable
        self.backgroundColor = [UIColor clearColor];
        _isStart = NO;
    }
    return self;
}

- (void)start {
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(repeats) userInfo:nil repeats:YES];
    self.second = 0;
    _isStart = YES;
}

- (void)suspend {
    [_timer setFireDate:[NSDate distantFuture]];
}
- (void)continue; {
    [_timer setFireDate:[NSDate date]];
}

- (void)stop {
    _isStart = NO;
    [_timer invalidate];
}

- (void)repeats {
    self.second++;
}

-  (void)setSecond:(CGFloat)second
{
    
    if (_second != second) {
        
        for (UIView *label in self.subviews) {
            if ([label isKindOfClass:[UILabel class]]) {
                [label removeFromSuperview];
            }
        }
        
        [self setNeedsDisplay];
        _second = second;
    }
    
}

- (void)drawRect:(CGRect)rect {
    
    //创建path
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 计算radius
    if (self.radius == 0) {
        self.radius = (CGRectGetHeight(self.frame) < CGRectGetWidth(self.frame)?CGRectGetHeight(self.frame):CGRectGetWidth(self.frame))/2;
    }
     // 设置描边宽度（为了让描边看上去更清楚）
    if (self.lineWidth == 0) {
        [path setLineWidth:15.0];
    } else {
        [path setLineWidth:self.lineWidth];
    }
    
    CGPoint centerPoint = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetWidth(self.frame)/2);
    
    // 画一个背景圆圈
    UIBezierPath *backgroundCircularPath = [UIBezierPath bezierPath];
    [backgroundCircularPath addArcWithCenter:centerPoint radius:(self.radius-path.lineWidth/2*3) startAngle:0.0 endAngle:2*M_PI clockwise:YES];
    [[UIColor colorWithRed:82.0/255.0 green:197.0/255.0 blue:238.0/255.0 alpha:1.0] setFill];
    [backgroundCircularPath fill];
    [backgroundCircularPath setLineWidth:0.0];
    [backgroundCircularPath stroke];
    
    // 添加圆到path ， clockwise 顺时针 逆时针
    if (self.countUp) {
        // 正向计时
        [path addArcWithCenter:centerPoint radius:(self.radius-path.lineWidth) startAngle:1.5*M_PI endAngle:M_PI*2*(self.second/self.total)+1.5*M_PI clockwise:NO];
    } else {
        // 倒计时
        [path addArcWithCenter:centerPoint radius:(self.radius-path.lineWidth) startAngle:1.5*M_PI endAngle:M_PI*2*(1-self.second/self.total)+1.5*M_PI clockwise:YES];
    }
    
    
    //设置颜色（颜色设置也可以放在最上面，只要在绘制前都可以）
    if (!self.strokeColor) {
        [[UIColor whiteColor] setStroke];
    }
//    if (!self.fillColor) {
//        [[UIColor brownColor] setFill];
//    }
    // 描边和填充
    [path stroke];
//    [path fill];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(self.radius/2, self.radius/2, self.radius/1, self.radius/2);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:self.radius/5];
    [self addSubview:titleLabel];
    
    // 圆圈内的文字
    if (self.text) {
        self.text = @"请设置text";
    } else {
        titleLabel.text = self.countUp?@"已经计时":@"还剩";
    }
   
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.frame = CGRectMake(self.radius/2, self.radius, self.radius/1, self.radius/2);
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont systemFontOfSize:self.radius/5];
    
    // 秒数
    NSInteger secondInt = self.countUp?(NSInteger)self.second:(NSInteger)(self.total - self.second);
    
    switch (self.displayType) {
        case second:
            textLabel.text = [NSString stringWithFormat:@"%ld秒",secondInt];
            break;
            
        case secondAndMinute:
            if (secondInt >= 60) {
                textLabel.text = [NSString stringWithFormat:@"%ld分%ld秒",secondInt/60,secondInt%60];
            } else {
                textLabel.text = [NSString stringWithFormat:@"%ld秒",secondInt%60];
            }
            
            break;
    }
    [self addSubview:textLabel];
    // 计时完成，调用代理
    if (secondInt == 0 && _isStart == YES &&[self.circularViewDelegate respondsToSelector:@selector(yscircularTimeRunOut)]) {
        [self stop];
        self.second = 0.0;
        [self.circularViewDelegate yscircularTimeRunOut];
    }
}

@end
