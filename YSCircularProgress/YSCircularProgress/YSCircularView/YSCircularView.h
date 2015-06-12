//
//  YSCircularView.h
//  YSCircularProgress
//
//  Created by Ralbatr on 15/6/12.
//  Copyright (c) 2015年 ralbatr Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSCircularView : UIView

@property (nonatomic,assign) CGFloat radius;
@property (nonatomic,assign) CGFloat lineWidth;
@property (nonatomic,strong) UIColor *strokeColor;
@property (nonatomic,strong) UIColor *fillColor;
// 圆圈内显示的文字
@property (nonatomic,copy)   NSString *text;

@end