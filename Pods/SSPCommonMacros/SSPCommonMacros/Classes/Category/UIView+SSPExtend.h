//
//  UIView+SSPExtend.h
//  AirPayCounter
//
//  Created by HuiCao on 2019/4/18.
//  Copyright © 2019 Shopee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SSPExtend)

/**
移除所有子视图

*/
- (void)removeAllSubViews;

/**
移除所有指定类型子视图

@param oClass 指定类型
*/
- (void)removeSubViewWithClass:(Class)oClass;

/**
获取指定类型子视图

@param oClass 指定类型
@return 第一个符合类型视图
*/
- (UIView *)viewWithClass:(Class)oClass;

/**
获取指定类型子视图

@param oClass 指定类型
@return 符合类型视图数组
*/
- (NSArray *)subviewsWithClass:(Class)oClass;

/**
获取指定类型子视图

@param className 指定类型字符串
@return 第一个符合类型视图
*/
- (UIView *)subViewOfClassName:(NSString *)className;

/**
移除所有手势

*/
- (void)removeAllGestureRecognizer;

/**
获取视图截屏

@return 当前视图截屏图片
*/
- (UIImage *)getSnapshotImage;

@end

@interface UIView (SSPViewFrameGeometry)

/// 等同于frame.origin
@property (nonatomic, assign) CGPoint exOrigin;
/// 等同于frame.size
@property (nonatomic, assign) CGSize size;
/// 获取view的左下角point
@property (nonatomic, assign, readonly) CGPoint bottomLeft;
/// 获取view的右下角point
@property (nonatomic, assign, readonly) CGPoint bottomRight;
/// 获取view的右上角point
@property (nonatomic, assign, readonly) CGPoint topRight;
/// 等同于frame.origin.x
@property (nonatomic, assign) CGFloat x;
/// 等同于frame.origin.y
@property (nonatomic, assign) CGFloat y;
/// 等同于frame.size.height
@property (nonatomic, assign) CGFloat height;
/// 等同于frame.size.width
@property (nonatomic, assign) CGFloat width;

/// 获取view顶部Y
@property (nonatomic, assign) CGFloat top;
/// 获取view左边X
@property (nonatomic, assign) CGFloat left;
/// 获取view底部Y
@property (nonatomic, assign) CGFloat bottom;
/// 获取view右边X
@property (nonatomic, assign) CGFloat right;
/// 获取view居中X
@property (nonatomic, assign) CGFloat centerX;
/// 获取view居中Y
@property (nonatomic, assign) CGFloat centerY;

/// 获取 uiscreen的四边间距
- (UIEdgeInsets)realSafeAreaInsets;

/// 获取当前view所在的viewcontroller
- (UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
