//
//  ViewController.m
//  KongClock
//
//  Created by K on 2023/10/9.
//

#import "ViewController.h"
#import "Masonry.h"
#import "KKClockView.h"
#import "FlipClockView.h"
#import "HalfTransparentLabel.h"


@interface ViewController ()

@property (nonatomic, strong)KKClockView *clockView;

@property (nonatomic, strong)FlipClockView *flipClock;

@property (nonatomic, strong)NSTimer * timer;
@property (nonatomic, strong)NSDate * startDate;

@property (nonatomic, strong) UIDatePicker *pickView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTime];
    
    [self.view addSubview:self.flipClock];
    [self.flipClock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(80);
        make.bottom.equalTo(self.view).offset(-80);
        make.leading.trailing.equalTo(self.view);
    }];

    self.view.backgroundColor = [UIColor colorWithRed:240/255.f green:255/255.f blue:255/255.f alpha:1];
    
    UIView *v = [[UIView alloc] init];
    [self.view addSubview:v];
    
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.center.equalTo(self.view);
    }];
    v.backgroundColor = [UIColor redColor];
    
    CATransform3D t = CATransform3DIdentity;
    t.m34 = -1.0/1000.0;
    t = CATransform3DRotate(t, M_PI * 0.4, -1, 0, 0);
    v.layer.transform = t;
    
//    HalfTransparentLabel *lbl = [[HalfTransparentLabel alloc] initWithFrame:CGRectMake(0, 0, 90, 128) type:FlipLabelShowType_Half_Bottom];
//    [self.view addSubview:lbl];
//    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(90, 128));
//        make.center.equalTo(self.view);
//    }];
//    lbl.text = @"2";
    
//    [self.view addSubview:self.clockView];
//    [self.clockView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.trailing.equalTo(self.view);
//        make.height.mas_equalTo(self.view.bounds.size.height + 140);
//    }];
//    
//    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUp:)];
//    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
//    [self.clockView addGestureRecognizer:swipeUp];
//    
//    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
//    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
//    [self.clockView addGestureRecognizer:swipeDown];
    
}

#pragma - Timer
- (void)setUpTime {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    self.startDate = [NSDate date];
}

- (void)updateTime{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];

    NSInteger hours = [components hour];
    NSInteger minutes = [components minute];
    NSInteger seconds = [components second];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Time_Noti" object:nil userInfo:@{@"hours" : @(hours), @"min" : @(minutes), @"Sec" : @(seconds)}];
}


#pragma - 手势
- (void)swipeUp:(UISwipeGestureRecognizer *)gesture {
    [self.clockView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(-140);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)swipeDown:(UISwipeGestureRecognizer *)gesture {
    [self.clockView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma - Lazy
- (KKClockView *)clockView {
    if (!_clockView) {
        _clockView = [[KKClockView alloc] initWithFrame:CGRectZero];
    }
    return _clockView;
}


- (FlipClockView *)flipClock {
    if (!_flipClock) {
        _flipClock = [[FlipClockView alloc] initWithFrame:CGRectZero];
    }
    return _flipClock;
}

@end
