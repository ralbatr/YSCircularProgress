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
@property (nonatomic,copy) UIColor *strokeColor;
@property (nonatomic,copy) UIColor *fillColor;

@end
