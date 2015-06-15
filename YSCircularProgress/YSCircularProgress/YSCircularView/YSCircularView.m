//
//  YSCircularView.m
//  YSCircularProgress
//
//  Created by Ralbatr on 15/6/12.
//  Copyright (c) 2015年 ralbatr Yi. All rights reserved.
//

#import "YSCircularView.h"

@implementation YSCircularView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
//        self.text = @"asdfa";
//        [self setNeedsDisplay];
//         [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(repeats) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)repeats {
    self.text =[NSString stringWithFormat:@"%d",self.second--];
    [self setNeedsDisplay];
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
    }
    
    CGPoint centerPoint = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetWidth(self.frame)/2);
    // 添加圆到path
    if (self.countUp) {
        // 正向计时
        [path addArcWithCenter:centerPoint radius:(self.radius-path.lineWidth) startAngle:1.5*M_PI endAngle:M_PI*2*(self.second/self.total)+1.5*M_PI clockwise:YES];
    } else {
        // 倒计时
        [path addArcWithCenter:centerPoint radius:(self.radius-path.lineWidth) startAngle:1.5*M_PI endAngle:M_PI*2*(1-self.second/self.total)+1.5*M_PI clockwise:YES];
    }
    
    
    //设置颜色（颜色设置也可以放在最上面，只要在绘制前都可以）
    if (!self.strokeColor) {
        [[UIColor blueColor] setStroke];
    }
    if (!self.fillColor) {
        [[UIColor brownColor] setFill];
    }
    // 描边和填充
    [path stroke];
    [path fill];
    
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
    textLabel.text = [NSString stringWithFormat:@"%ld",self.countUp?(NSInteger)self.second:(NSInteger)(self.total - self.second)];
    [self addSubview:textLabel];
}

@end
