//
//  KKClockCollectionViewCell.m
//  KongClock
//
//  Created by K on 2023/10/12.
//

#import "KKClockCollectionViewCell.h"
#import "Masonry.h"
#import "TimeView.h"

@interface KKClockCollectionViewCell ()

@property (nonatomic, strong)TimeView * timeView;

@end

@implementation KKClockCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self registerForNotification];
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.timeView = [[TimeView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.timeView];
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    self.contentView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.f green:arc4random_uniform(255)/255.f blue:arc4random_uniform(255)/255.f alpha:0.5];
}

- (void)registerForNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti:) name:@"Time_Noti" object:nil];
}

- (void)noti:(NSNotification *)noti {
    NSLog(@"-------%@",noti.userInfo);
    NSInteger hours = [[noti.userInfo objectForKey:@"hours"] integerValue];
    NSInteger min = [[noti.userInfo objectForKey:@"min"] integerValue];
    NSInteger sec = [[noti.userInfo objectForKey:@"Sec"] integerValue];
    [self.timeView setNumberWithHour:hours min:min sec:sec];
}


@end
