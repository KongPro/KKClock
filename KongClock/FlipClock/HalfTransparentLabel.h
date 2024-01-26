//
//  HalfLabel.h
//  KongClock
//
//  Created by K on 2024/1/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    FlipLabelShowType_Whole,
    FlipLabelShowType_Half_Top,
    FlipLabelShowType_Half_Bottom
} FlipLabelShowType;


@interface HalfTransparentLabel : UILabel

- (instancetype)initWithFrame:(CGRect)frame type:(FlipLabelShowType)type color:(UIColor *)color textColor:(UIColor *)textColor;

@end

NS_ASSUME_NONNULL_END
