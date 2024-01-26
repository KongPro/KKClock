//
//  FlipClockView.m
//  KongClock
//
//  Created by K on 2023/10/14.
//

#import "FlipClockView.h"
#import "Masonry.h"
#import "FlipClockSectionView.h"

@interface FlipClockView ()

@property (nonatomic, strong)FlipClockSectionView *hourSection;
@property (nonatomic, strong)FlipClockSectionView *minSection;
@property (nonatomic, strong)FlipClockSectionView *secSection;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *textColor;

@end

@implementation FlipClockView

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color bgColor:(UIColor *)bgColor textColor:(UIColor *)textColor{
    if (self = [super initWithFrame:frame]) {
        self.color = color;
        self.bgColor = bgColor;
        self.textColor = textColor;
        [self setUpUI];
        [self registerForNotification];
    }
    return self;
}

#pragma - UI
- (void)setUpUI{
    [self addSubview:self.hourSection];
    [self addSubview:self.minSection];
    [self addSubview:self.secSection];
    self.backgroundColor = self.bgColor;
    
    CGFloat margin = 55;
    CGFloat h = ([UIScreen mainScreen].bounds.size.height - (240 + margin + margin)) / 3;
    [self.minSection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.trailing.equalTo(self);
        make.height.equalTo(@(h));
    }];
    
    [self.hourSection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.bottom.equalTo(self.minSection.mas_top).offset(-margin);
        make.height.equalTo(@(h));
    }];
    
    [self.secSection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.minSection.mas_bottom).offset(margin);
        make.leading.trailing.equalTo(self);
        make.height.equalTo(@(h));
    }];
}


#pragma - Deal Time
- (void)registerForNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti:) name:@"Time_Noti" object:nil];
}

- (void)noti:(NSNotification *)noti {
    NSInteger hours = [[noti.userInfo objectForKey:@"hours"] integerValue];
    NSInteger min = [[noti.userInfo objectForKey:@"min"] integerValue];
    NSInteger sec = [[noti.userInfo objectForKey:@"Sec"] integerValue];
    
    [self.hourSection updateTimeWithNumberLeft:(hours / 10) right:(hours % 10)];
    [self.minSection updateTimeWithNumberLeft:(min / 10) right:(min % 10)];
    [self.secSection updateTimeWithNumberLeft:(sec / 10) right:(sec % 10)];
}

#pragma - Lazy
- (FlipClockSectionView *)hourSection {
    if (!_hourSection) {
        _hourSection = [[FlipClockSectionView alloc] initWithFrame:CGRectZero color:self.color textColor:self.textColor];
    }
    return _hourSection;
}

- (FlipClockSectionView *)minSection {
    if (!_minSection) {
        _minSection = [[FlipClockSectionView alloc] initWithFrame:CGRectZero color:self.color textColor:self.textColor];
    }
    return _minSection;
}

- (FlipClockSectionView *)secSection {
    if (!_secSection) {
        _secSection = [[FlipClockSectionView alloc] initWithFrame:CGRectZero color:self.color textColor:self.textColor];
    }
    return _secSection;
}

@end
