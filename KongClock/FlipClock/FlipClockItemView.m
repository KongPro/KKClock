//
//  FlipClockItem.m
//  KongClock
//
//  Created by K on 2023/10/14.
//

#import "FlipClockItemView.h"
#import "Masonry.h"
#import "HalfTransparentLabel.h"

#define AnimDuration (0.3)
#define AnimDuration_ADD (AnimDuration + 0.01)
#define AnimDurationAfterDelay (AnimDuration - 0.1)

#define kCLockItemMargin (55)
#define kCLockItemH (([UIScreen mainScreen].bounds.size.height - (240 + kCLockItemMargin + kCLockItemMargin)) / 3)
#define kItemRect CGRectMake(0, 0, 90, kCLockItemH)

@interface FlipClockItemView () <CAAnimationDelegate>

/*
    A C X
    \ | |
      | |
      B Y
 */

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat animationStartTime;
@property (nonatomic, strong) HalfTransparentLabel *wholeItemView;
@property (nonatomic, strong) HalfTransparentLabel *halfItemViewA;
@property (nonatomic, strong) HalfTransparentLabel *halfItemViewB;
@property (nonatomic, strong) HalfTransparentLabel *halfItemViewC;
@property (nonatomic, assign) NSInteger originNumber;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *textColor;


@property (nonatomic, strong) UIView *wholeView;
@property (nonatomic, strong) UIImageView *wholeImgTop;
@property (nonatomic, strong) UIImageView *wholeImgBottom;

@property (nonatomic, strong) UIView *halfViewA;
@property (nonatomic, strong) UIImageView *halfImgA;

@property (nonatomic, strong) UIView *halfViewB;
@property (nonatomic, strong) UIImageView *halfImgB;

@property (nonatomic, strong) UIView *halfViewC;
@property (nonatomic, strong) UIImageView *halfImgC;

@end

@implementation FlipClockItemView

- (instancetype)initWithFrame:(CGRect)frame color:(nonnull UIColor *)color textColor:(UIColor *)textColor {
    if (self = [super initWithFrame:frame]) {
        self.number = -1;
//        self.color = color;
        self.color = [UIColor clearColor];
//        self.textColor = textColor;
        self.textColor = [UIColor blackColor];
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10.f;
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor colorWithRed:202/255.f green:224/255.f blue:255/255.f alpha:1].CGColor;
//    [self addSubview:self.wholeItemView];
//    [self addSubview:self.halfItemViewC];
//    [self addSubview:self.halfItemViewA];
//    [self addSubview:self.halfItemViewB];
//    
//    [self.wholeItemView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
//    [self.halfItemViewA mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
//    [self.halfItemViewB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
//    [self.halfItemViewC mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
    
    [self addSubview:self.wholeView];
    [self.wholeView addSubview:self.wholeImgTop];
    [self.wholeView addSubview:self.wholeImgBottom];
    [self.wholeView addSubview:self.wholeItemView];
    
    [self addSubview:self.halfViewC];
    [self.halfViewC addSubview:self.halfImgC];
    [self.halfViewC addSubview:self.halfItemViewC];
    
    [self addSubview:self.halfViewA];
    [self.halfViewA addSubview:self.halfImgA];
    [self.halfViewA addSubview:self.halfItemViewA];
    
    [self addSubview:self.halfViewB];
    [self.halfViewB addSubview:self.halfImgB];
    [self.halfViewB addSubview:self.halfItemViewB];
    
    
    
    
    [self.wholeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.wholeImgTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.wholeView);
        make.bottom.equalTo(self.wholeView.mas_centerY);
    }];
    [self.wholeImgBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(self.wholeView);
        make.top.equalTo(self.wholeView.mas_centerY);
    }];
    [self.wholeItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.wholeView);
    }];
    
    
    
    
    
    
    [self.halfViewC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(self);
        make.top.equalTo(self.mas_centerY);
//        make.top.leading.trailing.equalTo(self);
//        make.bottom.equalTo(self.mas_centerY);
    }];
    [self.halfImgC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.halfViewC);
//        make.leading.bottom.trailing.equalTo(self.halfViewC);
//        make.top.equalTo(self.halfViewC.mas_centerY);
    }];
    [self.halfItemViewC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.wholeView);
    }];
    
    
    
    
    
    
    [self.halfViewA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self);
        make.bottom.equalTo(self.mas_centerY);
    }];
    [self.halfImgA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.halfViewA);
//        make.top.leading.trailing.equalTo(self.halfViewA);
//        make.bottom.equalTo(self.halfViewA.mas_centerY);
    }];
    [self.halfItemViewA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.wholeView);
    }];
    
    
    
    
    
    
    [self.halfViewB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(self);
        make.top.equalTo(self.mas_centerY);
//        make.edges.equalTo(self);
    }];
    [self.halfImgB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.halfViewB);
//        make.leading.bottom.trailing.equalTo(self.halfViewB);
//        make.top.equalTo(self.halfViewB.mas_centerY);
    }];
    [self.halfItemViewB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.wholeView);
    }];
    
    
    
    self.halfViewA.backgroundColor = [UIColor redColor];
    self.halfViewB.backgroundColor = [UIColor greenColor];
    self.halfViewC.backgroundColor = [UIColor yellowColor];
    self.halfViewA.layer.masksToBounds = YES;
    self.halfViewB.layer.masksToBounds = YES;
    self.halfViewC.layer.masksToBounds = YES;
    
    self.halfImgA.layer.anchorPoint = CGPointMake(0.5, 1);
    self.halfImgB.layer.anchorPoint = CGPointMake(0.5, 0);
    self.halfImgC.layer.anchorPoint = CGPointMake(0.5, 0);
    self.halfImgA.layer.position = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height);
    self.halfImgB.layer.position = CGPointMake(self.frame.size.width * 0.5, 0);
    self.halfImgC.layer.position = CGPointMake(self.frame.size.width * 0.5, 0);
}

- (void)updateContentWithNumber:(NSInteger)number shoudlAnim:(BOOL)anim {
//    if (self.number != number) {
//        self.number = number;
//        [self startAnimA];
//        [self startAnimC];
//    }
//    [self performSelector:@selector(initializeABC) withObject:nil afterDelay:AnimDurationAfterDelay inModes:@[NSRunLoopCommonModes]];
}

#pragma - Animation
- (void)startAnimA {
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    anim1.fromValue = @(0.0);
    anim1.byValue = @(-M_PI);
    anim1.duration = AnimDuration;
    anim1.delegate = self;
//    [self.halfItemViewA.layer addAnimation:anim1 forKey:@"anim1"];
    [self.halfViewA.layer addAnimation:anim1 forKey:@"anim1"];
}

- (void)startAnimC {
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    anim1.fromValue = @(M_PI);
    anim1.byValue = @(-M_PI);
    anim1.duration = AnimDuration_ADD;
//    [self.halfItemViewC.layer addAnimation:anim1 forKey:@"anim2"];
    [self.halfViewC.layer addAnimation:anim1 forKey:@"anim2"];
}

- (void)animationDidStart:(CAAnimation *)anim {
    self.halfItemViewA.text = [NSString stringWithFormat:@"%zd", self.originNumber];
    self.halfItemViewB.text = [NSString stringWithFormat:@"%zd", self.originNumber];
    self.halfItemViewC.text = [NSString stringWithFormat:@"%zd", self.number];
    self.wholeItemView.text = [NSString stringWithFormat:@"%zd", self.number];
    
//    self.halfItemViewA.alpha = 1;
//    self.halfItemViewB.alpha = 1;
//    self.halfItemViewC.alpha = 1;
//    [self bringSubviewToFront:self.halfItemViewB];
    self.halfViewA.alpha = 1;
    self.halfViewB.alpha = 1;
    self.halfViewC.alpha = 1;
    [self bringSubviewToFront:self.halfViewB];
}

- (void)initializeABC {
    self.originNumber = self.number;
//    self.halfItemViewA.alpha = 0;
//    self.halfItemViewB.alpha = 0;
//    self.halfItemViewC.alpha = 0;
    self.halfViewA.alpha = 0;
    self.halfViewB.alpha = 0;
    self.halfViewC.alpha = 0;
}

#pragma - Getter
- (HalfTransparentLabel *)wholeItemView {
    if (!_wholeItemView) {
        _wholeItemView = [[HalfTransparentLabel alloc] initWithFrame:kItemRect type:FlipLabelShowType_Whole color:self.color textColor:self.textColor];
//        _wholeItemView = [[HalfTransparentLabel alloc] initWithFrame:kItemRect type:FlipLabelShowType_Whole color:[UIColor colorWithRed:240/255.f green:248/255.f blue:255/255.f alpha:1]];
    }
    return _wholeItemView;
}

- (HalfTransparentLabel *)halfItemViewA {
    if (!_halfItemViewA) {
        _halfItemViewA = [[HalfTransparentLabel alloc] initWithFrame:kItemRect type:FlipLabelShowType_Half_Top color:self.color textColor:self.textColor];
//        _halfItemViewA = [[HalfTransparentLabel alloc] initWithFrame:kItemRect type:FlipLabelShowType_Half_Top color:[UIColor colorWithRed:240/255.f green:248/255.f blue:255/255.f alpha:1]];
//        CATransform3D t = CATransform3DIdentity;
//        t.m34 = -1.0/500.0;
//        t = CATransform3DRotate(t, M_PI, -1, 0, 0);
//        _halfItemViewA.layer.transform = t;
    }
    return _halfItemViewA;
}

- (HalfTransparentLabel *)halfItemViewB {
    if (!_halfItemViewB) {
        _halfItemViewB = [[HalfTransparentLabel alloc] initWithFrame:kItemRect type:FlipLabelShowType_Half_Bottom color:self.color textColor:self.textColor];
//        _halfItemViewB = [[HalfTransparentLabel alloc] initWithFrame:kItemRect type:FlipLabelShowType_Half_Bottom color:[UIColor colorWithRed:240/255.f green:248/255.f blue:255/255.f alpha:1]];
    }
    return _halfItemViewB;
}

- (HalfTransparentLabel *)halfItemViewC {
    if (!_halfItemViewC) {
        _halfItemViewC = [[HalfTransparentLabel alloc] initWithFrame:kItemRect type:FlipLabelShowType_Half_Bottom color:self.color textColor:self.textColor];
//        _halfItemViewC = [[HalfTransparentLabel alloc] initWithFrame:kItemRect type:FlipLabelShowType_Half_Bottom color:[UIColor colorWithRed:240/255.f green:248/255.f blue:255/255.f alpha:1]];
//        CATransform3D t = CATransform3DIdentity;
//        t.m34 = -1.0/500.0;
//        t = CATransform3DRotate(t, M_PI, -1, 0, 0);
//        _halfItemViewC.layer.transform = t;
//        [_halfItemViewC initRotate];
    }
    return _halfItemViewC;
}

- (UIView *)wholeView {
    if (!_wholeView) {
        _wholeView = [[UIView alloc] init];
    }
    return _wholeView;
}

- (UIImageView *)wholeImgTop {
    if (!_wholeImgTop) {
        _wholeImgTop = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flip_bg_light_top"]];
    }
    return _wholeImgTop;
}

- (UIImageView *)wholeImgBottom {
    if (!_wholeImgBottom) {
        _wholeImgBottom = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flip_bg_light_bottom"]];
    }
    return _wholeImgBottom;
}

- (UIView *)halfViewA {
    if (!_halfViewA) {
        _halfViewA = [[UIView alloc] init];
    }
    return _halfViewA;
}
- (UIImageView *)halfImgA {
    if (!_halfImgA) {
        _halfImgA = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flip_bg_light_top"]];
    }
    return _halfImgA;
}

- (UIView *)halfViewB {
    if (!_halfViewB) {
        _halfViewB = [[UIView alloc] init];
    }
    return _halfViewB;
}
- (UIImageView *)halfImgB {
    if (!_halfImgB) {
        _halfImgB = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flip_bg_light_bottom"]];
    }
    return _halfImgB;
}

- (UIView *)halfViewC {
    if (!_halfViewC) {
        _halfViewC = [[UIView alloc] init];
    }
    return _halfViewC;
}
- (UIImageView *)halfImgC {
    if (!_halfImgC) {
        _halfImgC = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flip_bg_light_bottom"]];
    }
    return _halfImgC;
}


@end
