//
//  FlipClockItem.h
//  KongClock
//
//  Created by K on 2023/10/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface FlipClockItemView : UIView

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color textColor:(UIColor *)textColor;;
- (void)updateContentWithNumber:(NSInteger)number shoudlAnim:(BOOL)anim;

@end

NS_ASSUME_NONNULL_END
