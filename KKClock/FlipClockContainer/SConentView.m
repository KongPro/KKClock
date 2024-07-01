//
//  SConentView.m
//  srollView_text
//
//  Created by 孔繁武 on 16/8/23.
//  Copyright © 2016年 孔繁武. All rights reserved.
//

#import "SConentView.h"
#import "FlipClockView.h"
#import "Masonry/Masonry.h"

@interface SConentView ()

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) FlipClockView *flipClock;

@end

@implementation SConentView

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color bgColor:(UIColor *)bgColor textColor:(UIColor *)textColor {
    if (self == [super initWithFrame:frame]) {
        [self setContentView:color bgColor:bgColor textColor:textColor];
    }
    return self;
}

- (void)setContentView:(UIColor *)color bgColor:(UIColor *)bgColor textColor:(UIColor *)textColor;{
    self.clipsToBounds = YES;
    
    self.flipClock = [[FlipClockView alloc] initWithFrame:self.bounds color:color bgColor:bgColor textColor:textColor];
    [self addSubview:self.flipClock];
//    self.flipClock.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
//    [self.flipClock mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
    
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    self.imgView = imageView;
//    [self addSubview:imageView];
//    
//    self.label = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 100) * 0.5, 200, self.frame.size.width, 200)];
//    [self.label setText:@"123"];
//    [self.label setFont:[UIFont boldSystemFontOfSize:100]];
//    [self.label setTextColor:color];
//    [self addSubview:self.label];
}

/**
 计算每个图片先对于屏幕中心view的偏移
 */
- (void)imageOffset{
    CGRect rect = [self convertRect:self.bounds toView:nil];
    CGFloat centerX = CGRectGetMidX(rect);
    CGFloat windowCenterX = self.window.center.x;
    CGFloat offset =  centerX - windowCenterX;
    CGFloat scale = 1;    // 平移因子
    self.flipClock.transform = CGAffineTransformMakeTranslation(-offset * scale, 0);
//    self.imgView.transform = CGAffineTransformMakeTranslation(-offset * scale, 0);
    self.label.transform = CGAffineTransformMakeTranslation(-offset * scale, 0);
}

//- (FlipClockView *)flipClock {
//    if (!_flipClock) {
//        _flipClock = [[FlipClockView alloc] initWithFrame:CGRectZero];
//    }
//    return _flipClock;
//}

@end
