//
//  FlipClockItemContentView.h
//  KongClock
//
//  Created by K on 2023/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    FlipItemShowType_Whole,
    FlipItemShowType_Half_Top,
    FlipItemShowType_Half_Bottom
} FlipItemShowType;

@interface FlipClockItemContentView : UIView

@property (nonatomic, strong)UIView *holderView;
@property (nonatomic, strong)UILabel *numLbl;

- (instancetype)initWithFrame:(CGRect)frame showType:(FlipItemShowType)type color:(UIColor *)color;

- (void)setNumber:(NSInteger)number;

- (void)initRotate;

@end

NS_ASSUME_NONNULL_END
