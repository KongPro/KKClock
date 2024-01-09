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

#import "CoreBluetooth/CBCentralManager.h"


@interface ViewController () //<CBCentralManagerDelegate>

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
    
//    [[CBCentralManager alloc] initWithDelegate:self queue:nil options:@{CBCentralManagerOptionShowPowerAlertKey : }];
//    CBCentralManager *centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
//    [centralManager scanForPeripheralsWithServices:nil options:nil];
    
//    UIView *greenView = [[UIView alloc] init];
//    greenView.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:greenView];
//    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self.view);
//        make.size.mas_equalTo(CGSizeMake(100, 100));
//    }];
    
//    
//    UIView *redView = [[UIView alloc] init];
//    redView.backgroundColor = [UIColor colorWithRed:238 green:0 blue:0 alpha:0.5];
//    [self.view addSubview:redView];
//    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self.view);
//        make.size.mas_equalTo(CGSizeMake(100, 100));
//    }];
    
    
    
//    CATransform3D t = CATransform3DIdentity;
//    t.m34 = -1.0/500.0;
//    t = CATransform3DRotate(t, M_PI*0.4, -1, 0, 0);
//    redView.layer.transform = t;
//    redView.layer.speed = 1;
    
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

//- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
//    if (central.state == CBManagerStatePoweredOn) {
//        // 中心管理器已准备好，可以开始扫描设备等操作
//        NSLog(@"on");
//    } else {
//        NSLog(@"on");
//        // 中心管理器不可用，处理相应的情况
//    }
//}

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
