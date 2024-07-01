//
//  KKClockDefind.h
//  KongClock
//
//  Created by K on 2024/7/1.
//

#ifndef KKClockDefind_h
#define KKClockDefind_h

#define AnimDuration (0.3)
#define AnimDuration_ADD (AnimDuration + 0.01)
#define AnimDurationAfterDelay (AnimDuration - 0.1)

#define KKCLOCKITEM_MARGIN (50)
#define KKCLOCKITEMSIZE_WIDTH (90)
#define KKCLOCKITEMSIZE_HEIGHT (([UIScreen mainScreen].bounds.size.height - (240 + KKCLOCKITEM_MARGIN + KKCLOCKITEM_MARGIN)) / 3)
#define KITEMSIZE CGSizeMake(KKCLOCKITEMSIZE_WIDTH, KKCLOCKITEMSIZE_HEIGHT)
#define KITEMRECT CGRectMake(0, 0, KKCLOCKITEMSIZE_WIDTH, KKCLOCKITEMSIZE_HEIGHT)

#endif /* KKClockDefind_h */
