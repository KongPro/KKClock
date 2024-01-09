//
//  KKSkinView.h
//  KongClock
//
//  Created by K on 2023/10/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^KKSkinViewEventBlock)(NSInteger index);

@interface KKSkinView : UIView

@property (nonatomic, copy)KKSkinViewEventBlock chooseEvent;

- (void)setData:(NSArray *)dataArray;

@end

NS_ASSUME_NONNULL_END
