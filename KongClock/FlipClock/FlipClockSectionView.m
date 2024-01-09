//
//  FlipClockSectionView.m
//  KongClock
//
//  Created by K on 2023/10/14.
//

#import "FlipClockSectionView.h"
#import "Masonry.h"
#import "FlipClockItemView.h"


@interface FlipClockSectionView ()

@property (nonatomic, strong)UIView *holderViewLeft;
@property(nonatomic, strong)FlipClockItemView *itemLeft;
@property(nonatomic, strong)FlipClockItemView *itemRight;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation FlipClockSectionView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

#pragma - UI
- (void)setUpUI {
    [self addSubview:self.holderViewLeft];
    [self addSubview:self.itemLeft];
    [self addSubview:self.itemRight];
    [self addSubview:self.lineView];
    
    
    [self.itemLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.trailing.equalTo(self.mas_centerX).offset(-6);
        make.width.equalTo(@(90));
    }];
    
    [self.holderViewLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.itemLeft);
    }];
    
    [self.itemRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.leading.equalTo(self.mas_centerX).offset(6);
        make.width.equalTo(@(90));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(2));
        make.leading.equalTo(self.itemLeft);
        make.trailing.equalTo(self.itemRight);
        make.centerY.equalTo(self);
    }];
    
    [self configureFlipClockItem];
}

- (void)configureFlipClockItem {
    self.holderViewLeft.layer.cornerRadius = 5;
//    self.holderViewLeft.layer.masksToBounds = YES;
    [self drawShadowLayer];
}

- (void)drawShadowLayer {
    CALayer *layer = [CALayer layer];
    CGFloat margin = 55;
    CGFloat h = ([UIScreen mainScreen].bounds.size.height - (240 + margin + margin)) / 3;
    layer.frame = CGRectMake(0, 0, 90, h);
    layer.cornerRadius = 5;
    layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 90, h) cornerRadius:5].CGPath;
    layer.shadowColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1].CGColor;
    layer.shadowOffset = CGSizeMake(0, 5);
    layer.shadowRadius = 5;
    layer.shadowOpacity = 0.7;
    [self.holderViewLeft.layer addSublayer:layer];
}

- (void)updateTimeWithNumberLeft:(NSInteger)number1 right:(NSInteger)number2 {
    [self.itemLeft updateContentWithNumber:number1 shoudlAnim:YES];
    [self.itemRight updateContentWithNumber:number2 shoudlAnim:YES];
}

#pragma -Lazy


- (UIView *)holderViewLeft {
    if (!_holderViewLeft) {
        _holderViewLeft = [[UIView alloc] init];
//        _holderViewLeft.backgroundColor = [UIColor whiteColor];
    }
    return _holderViewLeft;
}

- (FlipClockItemView *)itemLeft {
    if (!_itemLeft) {
        _itemLeft = [[FlipClockItemView alloc] initWithFrame:CGRectZero];
    }
    return _itemLeft;
}

- (FlipClockItemView *)itemRight {
    if (!_itemRight) {
        _itemRight = [[FlipClockItemView alloc] initWithFrame:CGRectZero];
    }
    return _itemRight;
}


- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor colorWithRed:224/255.f green:255/255.f blue:255/255.f alpha:1];
    }
    return _lineView;
}


@end
