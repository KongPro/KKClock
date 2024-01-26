//
//  HalfLabel.m
//  KongClock
//
//  Created by K on 2024/1/10.
//

#import "HalfTransparentLabel.h"

@interface HalfTransparentLabel()

@property (nonatomic, strong) UILabel *halfLabel;
@property (nonatomic, assign) CGFloat upperAlpha; // 上半部分透明度，默认为0
@property (nonatomic, assign) CGFloat lowerAlpha; // 下半部分透明度，默认为1
@property (nonatomic, assign) FlipLabelShowType type;
@property (nonatomic, strong) UIColor *color;

@end

@implementation HalfTransparentLabel

- (instancetype)initWithFrame:(CGRect)frame type:(FlipLabelShowType)type color:(UIColor *)color textColor:(UIColor *)textColor {
    if (self = [super initWithFrame:frame]) {
        self.type = type;
        self.color = color;
        self.textColor = textColor;
        self.textAlignment = NSTextAlignmentCenter;
        [self setFont:[UIFont fontWithName:@"AvenirNext-DemiBold" size:100]];
//        [self setTextColor:[UIColor colorWithRed:66/255.f green:66/255.f blue:66/255.f alpha:1]];
    }
    return self;
}


- (void)drawTextInRect:(CGRect)rect {
    // 计算要剪裁的一半宽度
    CGFloat halfHeight = self.type == FlipLabelShowType_Whole ? rect.size.height : rect.size.height * 0.5;
    UIColor *topColor = self.type == FlipLabelShowType_Half_Bottom ? [UIColor clearColor] : self.color;
    UIColor *bottomColor = self.type == FlipLabelShowType_Half_Bottom ? self.color : [UIColor clearColor];
    
    // 获取上半部分的矩形
    CGRect upperRect = CGRectMake(0, 0, rect.size.width, halfHeight);

    // 获取下半部分的矩形
    CGRect lowerRect = CGRectMake(0, halfHeight, rect.size.width, halfHeight);

    // 绘制上半部分透明背景
    [topColor set];
    UIRectFill(upperRect);

    // 绘制下半部分白色背景
    [bottomColor set];
    UIRectFill(lowerRect);

    // 绘制文本
    [super drawTextInRect:rect];
}

- (void)drawRect:(CGRect)rect {
    // 获取UILabel的边界
    CGRect bounds = self.bounds;

    // 计算要剪裁的一半宽度
    CGFloat halfHeight = self.type == FlipLabelShowType_Whole ? bounds.size.height : bounds.size.height * 0.5;
    CGFloat halfY = self.type == FlipLabelShowType_Half_Bottom ? bounds.size.height * 0.5 : 0;
    // 创建剪裁区域
    CGRect clippingRect = CGRectMake(0, halfY, bounds.size.width, halfHeight);

    // 获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();

    // 添加剪裁区域到上下文
    CGContextAddRect(context, clippingRect);
    CGContextClip(context);

    // 设置剪裁区域透明度
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, clippingRect);

    // 绘制文本
    [super drawRect:rect];
}
@end


