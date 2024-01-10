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

@end

@implementation FlipClockItemView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.number = -1;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    [self addSubview:self.wholeItemView];
    [self addSubview:self.halfItemViewC];
    [self addSubview:self.halfItemViewA];
    [self addSubview:self.halfItemViewB];
    
    [self.wholeItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.halfItemViewA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.halfItemViewB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.edges.equalTo(self);
    }];
    [self.halfItemViewC mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
        make.edges.equalTo(self);
    }];
}

- (void)updateContentWithNumber:(NSInteger)number shoudlAnim:(BOOL)anim {
    if (self.number != number) {
        self.number = number;
        [self startAnimA];
        [self startAnimC];
    }
    [self performSelector:@selector(initializeABC) withObject:nil afterDelay:AnimDurationAfterDelay];
}

#pragma - Animation
- (void)startAnimA {
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    anim1.fromValue = @(0.0);
    anim1.byValue = @(-M_PI);
    anim1.duration = AnimDuration;
    anim1.delegate = self;
    [self.halfItemViewA.layer addAnimation:anim1 forKey:@"anim1"];
}

- (void)startAnimC {
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    anim1.fromValue = @(M_PI);
    anim1.byValue = @(-M_PI);
    anim1.duration = AnimDuration_ADD;
    [self.halfItemViewC.layer addAnimation:anim1 forKey:@"anim2"];
};

- (void)animationDidStart:(CAAnimation *)anim {
    self.halfItemViewA.text = [NSString stringWithFormat:@"%zd", self.originNumber];
    self.halfItemViewB.text = [NSString stringWithFormat:@"%zd", self.originNumber];
    self.halfItemViewC.text = [NSString stringWithFormat:@"%zd", self.number];
    self.wholeItemView.text = [NSString stringWithFormat:@"%zd", self.number];
    
    self.halfItemViewA.alpha = 1;
    self.halfItemViewB.alpha = 1;
    self.halfItemViewC.alpha = 1;
    [self bringSubviewToFront:self.halfItemViewB];
}

- (void)initializeABC {
    self.originNumber = self.number;
    self.halfItemViewA.alpha = 0;
    self.halfItemViewB.alpha = 0;
    self.halfItemViewC.alpha = 0;
}

#pragma - Getter
- (HalfTransparentLabel *)wholeItemView {
    if (!_wholeItemView) {
        _wholeItemView = [[HalfTransparentLabel alloc] initWithFrame:kItemRect type:FlipLabelShowType_Whole color:[UIColor whiteColor]];
    }
    return _wholeItemView;
}

- (HalfTransparentLabel *)halfItemViewA {
    if (!_halfItemViewA) {
        _halfItemViewA = [[HalfTransparentLabel alloc] initWithFrame:kItemRect type:FlipLabelShowType_Half_Top color:[UIColor whiteColor]];
//        CATransform3D t = CATransform3DIdentity;
//        t.m34 = -1.0/500.0;
//        t = CATransform3DRotate(t, M_PI, -1, 0, 0);
//        _halfItemViewA.layer.transform = t;
    }
    return _halfItemViewA;
}

- (HalfTransparentLabel *)halfItemViewB {
    if (!_halfItemViewB) {
        _halfItemViewB = [[HalfTransparentLabel alloc] initWithFrame:kItemRect type:FlipLabelShowType_Half_Bottom color:[UIColor whiteColor]];
    }
    return _halfItemViewB;
}

- (HalfTransparentLabel *)halfItemViewC {
    if (!_halfItemViewC) {
        _halfItemViewC = [[HalfTransparentLabel alloc] initWithFrame:kItemRect type:FlipLabelShowType_Half_Bottom color:[UIColor whiteColor]];
//        CATransform3D t = CATransform3DIdentity;
//        t.m34 = -1.0/500.0;
//        t = CATransform3DRotate(t, M_PI, -1, 0, 0);
//        _halfItemViewC.layer.transform = t;
//        [_halfItemViewC initRotate];
    }
    return _halfItemViewC;
}


@end
