//
//  TimeView.m
//  Test
//
//  Created by 孔繁武 on 2023/10/9.
//

#import "TimeView.h"
#import "Masonry.h"

@interface TimeView ()

@property (nonatomic, strong)UIImageView * hourImgView;
@property (nonatomic, strong)UIImageView * minImgView;
@property (nonatomic, strong)UIImageView * secImgView;
@property (nonatomic, strong)UIImageView * centerView;

@end

@implementation TimeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.centerView];
    [self addSubview:self.hourImgView];
    [self addSubview:self.minImgView];
    [self addSubview:self.secImgView];
    [self.centerView setImage:[UIImage imageNamed:@"center"]];
    self.centerView.hidden = YES;
    
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    [self.minImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.centerView.mas_top).offset(-10);
    }];
    
    [self.hourImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.minImgView);
        make.trailing.equalTo(self.minImgView.mas_leading);
        make.size.mas_equalTo(CGSizeMake(55, 55));
    }];
    
    [self.secImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.centerView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerX.equalTo(self);
    }];
}

- (void)setNumberWithHour:(NSInteger)hour min:(NSInteger)min sec:(NSInteger)sec{
    UIImage *hourImage = [UIImage imageNamed:[NSString stringWithFormat:@"%zd",hour]];
    UIImage *minImage = [UIImage imageNamed:[NSString stringWithFormat:@"%zd", min]];
    UIImage *secImage = [UIImage imageNamed:[NSString stringWithFormat:@"%zd",sec]];
    
    [self.hourImgView setImage:hourImage];
    [self.minImgView setImage:minImage];
    [self.secImgView setImage:secImage];
    self.centerView.hidden = NO;
    [self startBlinkingAnimation];
}

- (void)startBlinkingAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:1.0];
    animation.duration = 1; // 闪烁一次的时间
    animation.autoreverses = YES; // 动画结束后自动返回初始状态
    animation.repeatCount = HUGE_VALF; // 无限重复
    [self.centerView.layer addAnimation:animation forKey:@"opacityAnimation"];
}

- (UIImageView *)hourImgView{
    if (!_hourImgView) {
        _hourImgView = [[UIImageView alloc] init];
    }
    return _hourImgView;
}

- (UIImageView *)minImgView{
    if (!_minImgView) {
        _minImgView = [[UIImageView alloc] init];
    }
    return _minImgView;
}

- (UIImageView *)secImgView{
    if (!_secImgView) {
        _secImgView = [[UIImageView alloc] init];
    }
    return _secImgView;
}

- (UIImageView *)centerView{
    if (!_centerView) {
        _centerView = [[UIImageView alloc] init];
    }
    return _centerView;
}




@end
