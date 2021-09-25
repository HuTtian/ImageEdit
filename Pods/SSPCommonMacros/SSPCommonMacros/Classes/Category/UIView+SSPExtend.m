//
//  UIView+SSPExtend.m
//  AirPayCounter
//
//  Created by HuiCao on 2019/4/18.
//  Copyright © 2019 Shopee. All rights reserved.
//

#import "UIView+SSPExtend.h"
#import "SSPDeviceInfo.h"

@implementation UIView (SSPExtend)

- (void)removeAllSubViews {
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
}

- (void)removeSubViewWithClass:(Class)oClass {
    for (UIView *subView in self.subviews) {
        if([subView isKindOfClass:oClass]) {
            [subView removeFromSuperview];
        }
    }
}

- (UIView *)viewWithClass:(Class)oClass {
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:oClass]) {
            return subView;
        } else {
            UIView *target = [subView viewWithClass:oClass];
            if (target) {
                return target;
            }
        }
    }
    return nil;
}

- (void)subviewsWithClass:(Class)oClass insertIntoArray:(NSMutableArray*)subviewArray {
    for (UIView *subView in self.subviews) {
        if([subView isKindOfClass:oClass]) {
            if (subView) {
                [subviewArray addObject:subView];
            }
        }
        [subView subviewsWithClass:oClass insertIntoArray:subviewArray];
    }
    return ;
}

- (NSArray *)subviewsWithClass:(Class)oClass {
    NSMutableArray *subviewArray = [[NSMutableArray alloc] init];
    [self subviewsWithClass:oClass insertIntoArray:subviewArray];
    return subviewArray;
}

- (UIView *)subViewOfClassName:(NSString*)className {
    for (UIView* subView in self.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            return subView;
        }
        
        UIView* resultFound = [subView subViewOfClassName:className];
        if (resultFound) {
            return resultFound;
        }
    }
    return nil;
}

- (void)removeAllGestureRecognizer {
    if (![self respondsToSelector:@selector(gestureRecognizers)]) return;
    
    for (UIGestureRecognizer *gestureRecognizer in self.gestureRecognizers) {
        [self removeGestureRecognizer:gestureRecognizer];
    }
}

- (UIImage *)getSnapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        CGFloat offset = scrollView.contentOffset.y;
        if (offset < 0) offset = 0;
        CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0, -offset);
    }
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshotImage;
}

@end


@implementation UIView(SSPViewFrameGeometry)

- (void)setExOrigin:(CGPoint)exOrigin {
    if (isnan(exOrigin.x) || isnan(exOrigin.y)) return;
    
    CGRect newframe = self.frame;
    newframe.origin = exOrigin;
    self.frame = newframe;
}

- (CGPoint)exOrigin {
    return self.frame.origin;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    if(isnan(size.width) || isnan(size.height)) return;
    
    CGRect newframe = self.frame;
    newframe.size = size;
    self.frame = newframe;
}

// Query other frame locations
- (CGPoint)bottomRight {
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)bottomLeft {
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)topRight {
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}

// Retrieve and set height, width, top, bottom, left, right
- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    if (isnan(x)) return;
    
    CGRect newframe = self.frame;
    newframe.origin.x = x;
    self.frame = newframe;
}

- (CGFloat)y {
    return self.frame.origin.y ;
}

- (void)setY:(CGFloat)y {
    if (isnan(y)) return;
    
    CGRect newframe = self.frame;
    newframe.origin.y = y ;
    self.frame = newframe;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    if (isnan(centerX)) return;
    
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    if(isnan(centerY)) return;
    
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    if (isnan(height)) return;
    
    CGRect newframe = self.frame;
    newframe.size.height = height;
    self.frame = newframe;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    if(isnan(width)) return;
    
    CGRect newframe = self.frame;
    newframe.size.width = width;
    self.frame = newframe;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
    if (isnan(top)) return;
    
    CGRect newframe = self.frame;
    newframe.origin.y = top;
    self.frame = newframe;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
    if (isnan(left)) return;
    
    CGRect newframe = self.frame;
    newframe.origin.x = left;
    self.frame = newframe;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    if (isnan(bottom)) return;
    
    CGRect newframe = self.frame;
    newframe.origin.y = bottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    if (isnan(right)) return;
    
    CGFloat delta = right - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta;
    self.frame = newframe;
}

- (UIEdgeInsets)realSafeAreaInsets {
    if (@available(iOS 11.0, *)) {
        if ([SSPDeviceInfo isiPad]) {
            return UIEdgeInsetsZero;
        }
        
        // safeAreaInsets还没赋值的时候，先拿hardcode值
        if (self.safeAreaInsets.bottom == 0) {
            if (MIsiPhoneXSeries) {
                UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
                if (UIDeviceOrientationIsPortrait(orientation)) {
                    return UIEdgeInsetsMake(44, 0, 34, 0);
                } else {
                    return UIEdgeInsetsMake(0, 44, 21, 44);
                }
            }
        }
        
        return self.safeAreaInsets;
    }
    return UIEdgeInsetsZero;
}

- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
