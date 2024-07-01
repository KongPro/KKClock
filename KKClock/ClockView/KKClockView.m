//
//  KKClockView.m
//  KongClock
//
//  Created by K on 2023/10/11.
//

#import "KKClockView.h"
#import "Masonry.h"
#import "KKSkinView.h"
#import "KKClockContentView.h"


@interface KKClockView ()


@property (nonatomic, strong)KKSkinView *skinView;
@property (nonatomic, strong)KKClockContentView *clockContentView;

@end

@implementation KKClockView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor clearColor];
    
    [self setUpClockUI];
    [self setUpSkinView];
    
    __weak typeof(self) weakSelf = self;
    self.skinView.chooseEvent = ^(NSInteger index) {
        [weakSelf.clockContentView scrollToIndex:index];
    };
}

- (void)setUpClockUI{
    [self addSubview:self.clockContentView];
    [self.clockContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self);
        make.bottom.equalTo(self).offset(-140);
    }];
}

- (void)setUpSkinView {
    [self addSubview:self.skinView];
    self.skinView.backgroundColor = [UIColor orangeColor];
    [self.skinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.clockContentView.mas_bottom);
        make.leading.trailing.equalTo(self);
        make.height.mas_equalTo(140);
    }];
}

- (KKClockContentView *)clockContentView {
    if (!_clockContentView) {
        _clockContentView = [[KKClockContentView alloc] initWithFrame:CGRectZero];
    }
    return _clockContentView;
}

- (KKSkinView *)skinView {
    if (!_skinView) {
        _skinView = [[KKSkinView alloc] init];
    }
    return _skinView;
}

@end
