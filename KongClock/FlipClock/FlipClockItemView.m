//
//  FlipClockItem.m
//  KongClock
//
//  Created by K on 2023/10/14.
//

#import "FlipClockItemView.h"
#import "Masonry.h"
#import "FlipClockItemContentView.h"

#define AnimDuration1 (0.9)
#define AnimDuration2 (0.9)
#define AnimDuration3 (0.9)

@interface FlipClockItemView () <CAAnimationDelegate>

/*
    A C X
    \ | |
      | |
      B Y
 
     ACBX
     \|||
        |
        Y
 */

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat animationStartTime;
@property (nonatomic, strong) FlipClockItemContentView *wholeItemView;
@property (nonatomic, strong) FlipClockItemContentView *halfItemViewA;
@property (nonatomic, strong) FlipClockItemContentView *halfItemViewB;
@property (nonatomic, strong) FlipClockItemContentView *halfItemViewC;
@property (nonatomic, assign) NSInteger originNumber;
@property (nonatomic, assign) NSInteger number;

@end

@implementation FlipClockItemView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    [self addSubview:self.wholeItemView];
    [self addSubview:self.halfItemViewC];
    [self addSubview:self.halfItemViewA];
    [self addSubview:self.halfItemViewB];
//    self.wholeItemView.hidden = YES;
//    self.halfItemViewA.hidden = YES;
//    self.halfItemViewB.hidden = YES;
//    self.halfItemViewC.hidden = YES;
//    
    [self.wholeItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.halfItemViewA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.halfItemViewB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
        make.edges.equalTo(self);
    }];
    [self.halfItemViewC mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
        make.edges.equalTo(self);
    }];
    
//    [self.layer insertSublayer:self.wholeItemView.layer atIndex:-1];
//    CATransform3D t = CATransform3DIdentity;
//    t.m34 = -1.0/500.0;
//    t = CATransform3DRotate(t, M_PI, -1, 0, 0);
//    self.halfItemViewC.layer.transform = t;
    
}

- (void)updateContentWithNumber:(NSInteger)number shoudlAnim:(BOOL)anim {
//    if (!self.number) {
//        self.originNumber = number;
//    }
    
//    CATransform3D t = CATransform3DIdentity;
//    t.m34 = -1.0/500.0;
//    t = CATransform3DRotate(t, M_PI, -1, 0, 0);
//    self.halfItemViewC.layer.transform = CATransform3DMakeRotation(M_PI, -1, 0, 0);
//    [self.halfItemViewC setNumber:number];
//    self.halfItemViewC.alpha = 1;
    

    
//    [self startAnimB];
//    [self startAnimC];
//    [self sendSubviewToBack:self.wholeItemView];
//    [self sendSubviewToBack:self.halfItemViewB];
//    [self.halfItemViewA setNumber:self.number.intValue];
//    [self.halfItemViewB setNumber:self.number.intValue];
//    [self.halfItemViewC setNumber:number];
//    [self.wholeItemView setNumber:number];
//    [self.halfItemViewA setNumber:self.number.intValue];
//    [self.halfItemViewB setNumber:self.number.intValue];
//    [self.halfItemViewC setNumber:number];
//    self.halfItemViewA.alpha = 1;
//    self.halfItemViewB.alpha = 1;
//    self.halfItemViewC.alpha = 1;
//    [self.wholeItemView setNumber:number];
//    self.halfItemViewA.hidden = self.halfItemViewB.hidden = self.halfItemViewC.hidden = NO;
//    self.halfItemViewA.hidden = NO;
//    self.halfItemViewB.hidden = NO;
//    self.halfItemViewC.hidden = NO;
    [self performSelector:@selector(initializeABC) withObject:nil afterDelay:0.4];

    NSLog(@"kkkk---- number = %zd, self.number = %zd", self.number, self.originNumber);
    if (self.number != number) {
        self.number = number;
        [self startAnimA];
        [self startAnimC];
    }
//    self.number = number;
}

#pragma - Animation
- (void)startAnimA {
//    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
////    anim1.fromValue = @((-10/360)*M_PI);
////    anim1.toValue = @((-355/360)*M_PI);
//    anim1.fromValue = @(0);
//    anim1.toValue = @(M_PI);
//    anim1.duration = 1.0;
//    anim1.repeatCount = 0;
//    anim1.delegate = self;
    
//    [self.halfItemViewA.layer addAnimation:anim1 forKey:@"Anim1"];
    
    
//    anim1.fromValue = [NSValue valueWithCATransform3D:self.halfItemViewA.layer.transform];
//    anim1.fromValue = [NSValue valueWithCATransform3D:<#(CATransform3D)#>] (-10/360)*M_PI;
    
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
//    anim1.fillMode = kCAFillModeForwards;
//    anim1.removedOnCompletion = NO;
    anim1.fromValue = @(0.0);
    anim1.byValue = @(-M_PI);
    anim1.duration = 0.5;
    anim1.delegate = self;
//    anim1.removedOnCompletion = YES;
//    anim1.repeatCount = CGFLOAT_MAX;
    [self.halfItemViewA.layer addAnimation:anim1 forKey:@"anim1"];
//
//    CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"transform"];
//    anim2.fillMode = kCAFillModeForwards;
//    anim2.removedOnCompletion = NO;
//    anim2.fromValue = [NSValue valueWithCATransform3D:self.halfItemViewC.layer.transform];
//    CATransform3D t1 = CATransform3DIdentity;
//    t1.m34 = -1.0/500.0;
//    t1 = CATransform3DRotate(t1, M_PI, 1, 0, 0);
//    anim2.toValue = [NSValue valueWithCATransform3D:t1];
//    anim2.repeatCount = 1;
//    anim2.removedOnCompletion = YES;
//    anim2.duration = AnimDuration2;
//    
//    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//    [self.halfItemViewA.layer addAnimation:anim1 forKey:@"trans"];
//    [self.halfItemViewC.layer addAnimation:anim2 forKey:@"123"];
//    // 开始监听
//    self.animationStartTime = CACurrentMediaTime();
//    if (!self.displayLink) {
//        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(animationTimeUpdate:)];
//    }
}

- (void)startAnimC {
//    CATransform3D t = CATransform3DIdentity;
//    t.m34 = -1.0/500.0;
//    t = CATransform3DRotate(t, M_PI, -1, 0, 0);
//    self.halfItemViewC.layer.transform = t;
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
//    anim1.fillMode = kCAFillModeForwards;
//    anim1.removedOnCompletion = NO;
    anim1.fromValue = @(M_PI);
    anim1.byValue = @(-M_PI);
    anim1.duration = 0.501;
//    anim1.delegate = self;
//    anim1.removedOnCompletion = YES;
//    anim1.repeatCount = CGFLOAT_MAX;
    [self.halfItemViewC.layer addAnimation:anim1 forKey:@"anim2"];
};

- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"动画开始了");
    [self.halfItemViewA setNumber:self.originNumber];
    [self.halfItemViewB setNumber:self.originNumber];
    [self.halfItemViewC setNumber:self.number];
    [self.wholeItemView setNumber:self.number];
    self.halfItemViewA.alpha = 1;
    self.halfItemViewB.alpha = 1;
    self.halfItemViewC.alpha = 1;
}

//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
//    NSLog(@"隐藏咯 %lf");
//    self.halfItemViewA.alpha = 0;
//    self.halfItemViewB.alpha = 0;
//    self.halfItemViewC.alpha = 0;
//}

- (void)initializeABC {
    self.originNumber = self.number;
    self.halfItemViewA.alpha = 0;
    self.halfItemViewB.alpha = 0;
    self.halfItemViewC.alpha = 0;
}

- (void)animationTimeUpdate:(CADisplayLink *)displayLink {
    CFTimeInterval currentTime = CACurrentMediaTime();
    CFTimeInterval elapsedTime = currentTime - self.animationStartTime;
    if (elapsedTime >= AnimDuration3) {
        NSLog(@"可以恢复了 %lf", elapsedTime);
//        [self bringSubviewToFront:self.wholeItemView];
//        [self.wholeItemView setNumber:self.number.intValue];
        self.halfItemViewA.hidden = YES;
        self.halfItemViewB.hidden = YES;
        self.halfItemViewC.hidden = YES;
        [self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//        self.halfItemViewA.hidden = self.halfItemViewB.hidden = self.halfItemViewC.hidden = YES;
//        self.halfItemViewA.hidden = YES;
//        self.halfItemViewB.hidden = YES;
//        self.halfItemViewC.hidden = YES;

    }
}

#pragma - Getter
- (FlipClockItemContentView *)wholeItemView {
    if (!_wholeItemView) {
        _wholeItemView = [[FlipClockItemContentView alloc] initWithFrame:CGRectZero showType:FlipItemShowType_Whole color:[UIColor systemBlueColor]];
    }
    return _wholeItemView;
}

- (FlipClockItemContentView *)halfItemViewA {
    if (!_halfItemViewA) {
        _halfItemViewA = [[FlipClockItemContentView alloc] initWithFrame:CGRectZero showType:FlipItemShowType_Half_Top color:[UIColor redColor]];
        
    }
    return _halfItemViewA;
}

- (FlipClockItemContentView *)halfItemViewB {
    if (!_halfItemViewB) {
        _halfItemViewB = [[FlipClockItemContentView alloc] initWithFrame:CGRectZero showType:FlipItemShowType_Half_Bottom color:[UIColor greenColor]];
    }
    return _halfItemViewB;
}

- (FlipClockItemContentView *)halfItemViewC {
    if (!_halfItemViewC) {
        _halfItemViewC = [[FlipClockItemContentView alloc] initWithFrame:CGRectZero showType:FlipItemShowType_Half_Bottom color:[UIColor yellowColor]];
//        CATransform3D t = CATransform3DIdentity;
//        t.m34 = -1.0/500.0;
//        t = CATransform3DRotate(t, M_PI, -1, 0, 0);
//        _halfItemViewC.layer.transform = t;
//        [_halfItemViewC initRotate];
    }
    return _halfItemViewC;
}


@end
