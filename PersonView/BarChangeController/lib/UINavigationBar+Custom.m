//
//  UINavigationBar+Custom.m
//  PersonView
//
//  Created by 付宗建 on 16/8/12.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "UINavigationBar+Custom.h"
#import <objc/runtime.h>
@implementation UINavigationBar (Custom)
static char customlayKey;
- (UIView *)customlay{
    return objc_getAssociatedObject(self, &customlayKey);
}
- (void)setCustomlay:(UIView *)customlay{
    objc_setAssociatedObject(self, &customlayKey, customlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)custom_setBackgroundColor:(UIColor *)backgroundColor{
    if (!self.customlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.customlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.customlay.userInteractionEnabled = NO;
        self.customlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.customlay atIndex:0];
    }
    self.customlay.backgroundColor = backgroundColor;
}
- (void)custom_setAlpha:(CGFloat)alpha{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}
- (void)custom_setTranslationY:(CGFloat)translationY{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}
- (void)custom_reset{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.customlay removeFromSuperview];
    self.customlay = nil;
    
}
@end
