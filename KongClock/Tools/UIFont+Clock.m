//
//  UIFont+Clock.m
//  KongClock
//
//  Created by K on 2024/6/27.
//

#import "UIFont+Clock.h"

@implementation UIFont (Clock)

+ (UIFont *)clock_defaultFontWithSize:(CGFloat)fontSize {
    UIFont *font = [UIFont fontWithName:@"KeepDisplay-Regular" size:fontSize];
    if (font) {
        return font;
    }
    return [UIFont systemFontOfSize:fontSize];
}

@end
