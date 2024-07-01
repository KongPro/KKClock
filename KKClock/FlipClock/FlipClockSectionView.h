//
//  FlipClockSectionView.h
//  KongClock
//
//  Created by K on 2023/10/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlipClockSectionView : UIView

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color textColor:(UIColor *)textColor;;
- (void)updateTimeWithNumberLeft:(NSInteger)number1 right:(NSInteger)number2;

@end

NS_ASSUME_NONNULL_END
