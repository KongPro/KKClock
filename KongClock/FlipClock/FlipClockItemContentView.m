//
//  FlipClockItemContentView.m
//  KongClock
//
//  Created by K on 2023/10/16.
//

#import "FlipClockItemContentView.h"
#import "Masonry.h"

@interface FlipClockItemContentView ()



@end

@implementation FlipClockItemContentView

- (instancetype)initWithFrame:(CGRect)frame showType:(FlipItemShowType)type color:(UIColor *)color{
    if (self = [super initWithFrame:frame]) {
        [self setUpUIWithShowType:type];
        self.holderView.backgroundColor = color;
    }
    return self;
}

- (void)setUpUIWithShowType:(FlipItemShowType)type{
    [self addSubview:self.holderView];
    [self.holderView addSubview:self.numLbl];
    
    [self.numLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.holderView.superview);
    }];
    
    if (type == FlipItemShowType_Half_Top) {
        [self.holderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.equalTo(self);
            make.bottom.equalTo(self.mas_centerY);
        }];
    } else if (type == FlipItemShowType_Half_Bottom) {
        [self.holderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_centerY);
            make.leading.bottom.trailing.equalTo(self);
        }];
    } else {
        [self.holderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
}

- (void)setNumber:(NSInteger)number {
    self.numLbl.text = [NSString stringWithFormat:@"%zd", number];
}

- (void)initRotate {
    self.numLbl.layer.transform = CATransform3DMakeRotation(M_PI, -1, 0, 0);
}

#pragma - Getter

- (UIView *)holderView {
    if (!_holderView) {
        _holderView = [[UIView alloc] init];
        _holderView.layer.cornerRadius = 5;
        _holderView.clipsToBounds = YES;
//        _holderView.backgroundColor = [UIColor whiteColor];
    }
    return _holderView;
}

- (UILabel *)numLbl {
    if (!_numLbl) {
        _numLbl = [[UILabel alloc] init];
        _numLbl.textAlignment = NSTextAlignmentCenter;
        [_numLbl setFont:[UIFont fontWithName:@"AvenirNext-DemiBold" size:100]];
        [_numLbl setTextColor:[UIColor colorWithRed:66/255.f green:66/255.f blue:66/255.f alpha:1]];
    }
    return _numLbl;
}

@end
