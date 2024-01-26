//
//  KLoopBannerView.m
//  srollView_text
//
//  Created by 孔繁武 on 2016/10/31.
//  Copyright © 2016年 孔繁武. All rights reserved.
//

#import "KBannerViewFollow.h"
#import "SConentView.h"

@interface KBannerViewFollow () <UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) NSArray * imageArr;

@end

@implementation KBannerViewFollow

- (void)setUpBannerViewWithImageArr:(NSArray *)imageArray{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    scrollView.delegate = self;
    CGFloat contentWidth = imageArray.count ? self.frame.size.width * imageArray.count : self.frame.size.width;
    scrollView.contentSize = CGSizeMake(contentWidth, 0);
    scrollView.pagingEnabled = YES;
    self.scrollView = scrollView;
    
    // 创建多个图片view
    for (int i = 0; i < 10; i++) {
        UIColor *color = i % 2 ? [UIColor systemRedColor] : [UIColor systemBlueColor];
        UIColor *textColor = i % 2 ? [UIColor whiteColor] : [UIColor blackColor];
        SConentView *sContentView = [[SConentView alloc] initWithFrame:CGRectMake(i * scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height) color:color bgColor:color textColor:textColor];
        if (!imageArray.count) {
            sContentView.backgroundColor = [UIColor lightGrayColor];
        }else{
            sContentView.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArray[i]]];
        }
        [scrollView addSubview:sContentView];
    }
    
    [self addSubview:scrollView];
}

- (void)setUpBannerViewWithCount:(NSInteger)count{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    scrollView.delegate = self;
    CGFloat contentWidth = count ? self.frame.size.width * count : self.frame.size.width;
    scrollView.contentSize = CGSizeMake(contentWidth, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView = scrollView;
    
    // 创建多个图片view
    for (int i = 0; i < count; i++) {
        UIColor *color = i % 2 ? [UIColor systemRedColor] : [UIColor systemBlueColor];
        UIColor *textColor = i % 2 ? [UIColor colorWithRed:66/255.f green:66/255.f blue:66/255.f alpha:1] : [UIColor whiteColor];
        UIColor *bgColor = i % 2 ? [UIColor colorWithRed:238/255.f green:154/255.f blue:0/255.f alpha:1] : [UIColor colorWithRed:176/255.f green:48/255.f blue:96/255.f alpha:1];

        SConentView *sContentView = [[SConentView alloc] initWithFrame:CGRectMake(i * scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height) color:color bgColor:bgColor textColor:textColor];
        [scrollView addSubview:sContentView];
    }
    
    [self addSubview:scrollView];
}

#pragma mark -- ScrollViewDidScroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.scrollView]) {
        for (SConentView *contentView in scrollView.subviews) {
            if ([contentView respondsToSelector:@selector(imageOffset)] ) {
                [contentView imageOffset];
            }
        }
    }
}

#pragma mark -- Create Banner
+ (KBannerViewFollow *)loopViewTypeFollowWithFrame:(CGRect)rect images:(NSArray *)imageArray{
    KBannerViewFollow *loopBannerFollowView = [[KBannerViewFollow alloc] initWithFrame:rect];
    [loopBannerFollowView setUpBannerViewWithImageArr:imageArray];
    return loopBannerFollowView;
}


+ (KBannerViewFollow *)loopViewTypeFollowWithFrame:(CGRect)rect count:(NSInteger)count {
    KBannerViewFollow *loopBannerFollowView = [[KBannerViewFollow alloc] initWithFrame:rect];
    [loopBannerFollowView setUpBannerViewWithCount:count];
    return loopBannerFollowView;
}
@end
