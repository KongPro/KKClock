//
//  FlipClockItem.m
//  KongClock
//
//  Created by K on 2023/10/14.
//

#import "FlipClockItemView.h"
#import "Masonry.h"
#import "HalfTransparentLabel.h"

@interface FlipClockItemView () <CAAnimationDelegate>

/*
    A C X
    \ | |
      | |
      B Y
 */

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat animationStartTime;
@property (nonatomic, assign) NSInteger originNumber;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *textColor;


@property (nonatomic, strong) UIView *wholeView;
@property (nonatomic, strong) UIView *wholeViewA;
@property (nonatomic, strong) UIView *wholeViewB;
@property (nonatomic, strong) UIView *wholeViewC;


@property (nonatomic, strong) UIView *halfViewA;
@property (nonatomic, strong) UIView *halfViewB;
@property (nonatomic, strong) UIView *halfViewC;


@property (nonatomic, strong) UIImageView *wholeImgTop;
@property (nonatomic, strong) UIImageView *wholeImgBottom;
@property (nonatomic, strong) UIImageView *halfImgA;
@property (nonatomic, strong) UIImageView *halfImgB;
@property (nonatomic, strong) UIImageView *halfImgC;

@property (nonatomic, strong) HalfTransparentLabel *wholeLbl;
@property (nonatomic, strong) HalfTransparentLabel *halfLblA;
@property (nonatomic, strong) HalfTransparentLabel *halfLblB;
@property (nonatomic, strong) HalfTransparentLabel *halfLblC;

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
    
    [self addSubview:self.wholeView];
    [self addSubview:self.wholeViewC];
    [self addSubview:self.wholeViewA];
    [self addSubview:self.wholeViewB];
    
    [self.wholeView addSubview:self.wholeImgTop];
    [self.wholeView addSubview:self.wholeImgBottom];
    [self.wholeView addSubview:self.wholeLbl];
    
    [self.wholeImgTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.wholeView);
        make.bottom.equalTo(self.wholeView.mas_centerY);
    }];
    [self.wholeImgBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wholeView.mas_centerY);
        make.leading.bottom.trailing.equalTo(self.wholeView);
    }];
    [self.wholeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.wholeView);
    }];
    
    [self.wholeViewA addSubview:self.halfViewA];
    [self.wholeViewB addSubview:self.halfViewB];
    [self.wholeViewC addSubview:self.halfViewC];
    

    [self.halfViewA addSubview:self.halfImgA];
    [self.halfViewA addSubview:self.halfLblA];
    
    [self.halfViewB addSubview:self.halfImgB];
    [self.halfViewB addSubview:self.halfLblB];
    
    
    [self.halfViewC addSubview:self.halfImgC];
    [self.halfViewC addSubview:self.halfLblC];
    

    
    [self.wholeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.wholeViewA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.wholeViewB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.wholeViewC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
  
    
    [self.halfViewA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.wholeViewA);
        make.bottom.equalTo(self.wholeViewA.mas_centerY);
    }];
    [self.halfViewB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(self.wholeViewB);
        make.top.equalTo(self.wholeViewB.mas_centerY);
    }];
    [self.halfViewC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(self.wholeViewC);
        make.top.equalTo(self.wholeViewC.mas_centerY);
    }];
    
    
    
    [self.halfImgA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.halfViewA);
    }];
    [self.halfImgB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.halfViewB);
    }];
    [self.halfImgC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.halfViewC);
    }];
    
    
    [self.halfLblA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.halfViewA);
        make.centerX.equalTo(self.halfViewA);
        make.size.mas_equalTo(KITEMSIZE);
    }];
    [self.halfLblB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.halfViewB);
        make.centerX.equalTo(self.halfViewB);
        make.size.mas_equalTo(KITEMSIZE);
    }];
    [self.halfLblC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.halfViewC);
        make.centerX.equalTo(self.halfViewC);
        make.size.mas_equalTo(KITEMSIZE);
    }];
    
    self.wholeView.backgroundColor = [UIColor redColor];
//    self.wholeViewB.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
}

- (void)updateContentWithNumber:(NSInteger)number shoudlAnim:(BOOL)anim {
    if (self.number != number) {
        self.number = number;
        [self startAnimA];
        [self startAnimC];
    }
    [self performSelector:@selector(initializeABC) withObject:nil afterDelay:AnimDurationAfterDelay inModes:@[NSRunLoopCommonModes]];
}

#pragma - Animation
- (void)startAnimA {
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    anim1.fromValue = @(0.0);
    anim1.byValue = @(-M_PI);
    anim1.duration = AnimDuration;
    anim1.delegate = self;
//    [self.halfItemViewA.layer addAnimation:anim1 forKey:@"anim1"];
    [self.wholeViewA.layer addAnimation:anim1 forKey:@"anim1"];
}

- (void)startAnimC {
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    anim1.fromValue = @(M_PI);
    anim1.byValue = @(-M_PI);
    anim1.duration = AnimDuration_ADD;
//    [self.halfItemViewC.layer addAnimation:anim1 forKey:@"anim2"];
    [self.wholeViewC.layer addAnimation:anim1 forKey:@"anim2"];
}

- (void)animationDidStart:(CAAnimation *)anim {
    self.halfLblA.text = [NSString stringWithFormat:@"%zd", self.originNumber];
    self.halfLblB.text = [NSString stringWithFormat:@"%zd", self.originNumber];
    self.halfLblC.text = [NSString stringWithFormat:@"%zd", self.number];
    self.wholeLbl.text = [NSString stringWithFormat:@"%zd", self.number];
    
//    self.halfItemViewA.alpha = 1;
//    self.halfItemViewB.alpha = 1;
//    self.halfItemViewC.alpha = 1;
    self.wholeViewA.alpha = 1;
    self.wholeViewB.alpha = 1;
    self.wholeViewC.alpha = 1;
    [self bringSubviewToFront:self.halfViewB];
}

- (void)initializeABC {
    self.originNumber = self.number;
//    self.halfItemViewA.alpha = 0;
//    self.halfItemViewB.alpha = 0;
//    self.halfItemViewC.alpha = 0;
    self.wholeViewA.alpha = 0;
    self.wholeViewB.alpha = 0;
    self.wholeViewC.alpha = 0;
    
}

#pragma - Getter
- (HalfTransparentLabel *)wholeLbl {
    if (!_wholeLbl) {
        _wholeLbl = [[HalfTransparentLabel alloc] initWithFrame:KITEMRECT type:FlipLabelShowType_Whole color:self.color textColor:self.textColor];
    }
    return _wholeLbl;
}

- (HalfTransparentLabel *)halfLblA {
    if (!_halfLblA) {
        _halfLblA = [[HalfTransparentLabel alloc] initWithFrame:KITEMRECT type:FlipLabelShowType_Half_Top color:self.color textColor:self.textColor];
//        _halfItemViewA = [[HalfTransparentLabel alloc] initWithFrame:kItemRect type:FlipLabelShowType_Half_Top color:[UIColor colorWithRed:240/255.f green:248/255.f blue:255/255.f alpha:1]];
//        CATransform3D t = CATransform3DIdentity;
//        t.m34 = -1.0/500.0;
//        t = CATransform3DRotate(t, M_PI, -1, 0, 0);
//        _halfItemViewA.layer.transform = t;
    }
    return _halfLblA;
}

- (HalfTransparentLabel *)halfLblB {
    if (!_halfLblB) {
        _halfLblB = [[HalfTransparentLabel alloc] initWithFrame:KITEMRECT type:FlipLabelShowType_Half_Bottom color:self.color textColor:self.textColor];
    }
    return _halfLblB;
}

- (HalfTransparentLabel *)halfLblC {
    if (!_halfLblC) {
        _halfLblC = [[HalfTransparentLabel alloc] initWithFrame:KITEMRECT type:FlipLabelShowType_Half_Bottom color:self.color textColor:self.textColor];
//        _halfItemViewC = [[HalfTransparentLabel alloc] initWithFrame:kItemRect type:FlipLabelShowType_Half_Bottom color:[UIColor colorWithRed:240/255.f green:248/255.f blue:255/255.f alpha:1]];
//        CATransform3D t = CATransform3DIdentity;
//        t.m34 = -1.0/500.0;
//        t = CATransform3DRotate(t, M_PI, -1, 0, 0);
//        _halfItemViewC.layer.transform = t;
//        [_halfItemViewC initRotate];
    }
    return _halfLblC;
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
        _halfViewA.layer.masksToBounds = YES;
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
        _halfViewB.layer.masksToBounds = YES;
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
        _halfViewC.layer.masksToBounds = YES;
    }
    return _halfViewC;
}
- (UIImageView *)halfImgC {
    if (!_halfImgC) {
        _halfImgC = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flip_bg_light_bottom"]];
    }
    return _halfImgC;
}


- (UIView *)wholeViewA {
    if (!_wholeViewA) {
        _wholeViewA = [[UIView alloc] init];
    }
    return _wholeViewA;
}

- (UIView *)wholeViewB {
    if (!_wholeViewB) {
        _wholeViewB = [[UIView alloc] init];
    }
    return _wholeViewB;
}

- (UIView *)wholeViewC {
    if (!_wholeViewC) {
        _wholeViewC = [[UIView alloc] init];
    }
    return _wholeViewC;
}
@end
