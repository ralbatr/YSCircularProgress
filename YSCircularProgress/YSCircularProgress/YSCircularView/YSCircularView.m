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
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super init];
//    if (self) {
//        self.frame = frame;
//        self.backgroundColor = [UIColor clearColor];
//    }
//    return self;
//}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //创建path
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 添加圆到path
    [path addArcWithCenter:self.center radius:30.0 startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
    // 设置描边宽度（为了让描边看上去更清楚）
    [path setLineWidth:15.0];
    //设置颜色（颜色设置也可以放在最上面，只要在绘制前都可以）
    [[UIColor blueColor] setStroke];
    [[UIColor brownColor] setFill];
    // 描边和填充
    [path stroke];
    [path fill];
}

@end
