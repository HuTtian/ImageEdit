//
//  ImageCroppingView.h
//  ImageEdit
//  专门用于实现图片裁剪功能
//  使用指南：用被裁剪的图片视图ImageView进行初始化且只支持UIViewContentModeScaleAspectFit，将该view用bringSubviewToFront方法放置到顶层
//
//  Created by 胡天翔 on 2021/9/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CroppingLayer : CAShapeLayer

@property(assign, nonatomic) NSInteger cropAreaLeft;
@property(assign, nonatomic) NSInteger cropAreaTop;
@property(assign, nonatomic) NSInteger cropAreaRight;
@property(assign, nonatomic) NSInteger cropAreaBottom;

- (void)setCropAreaLeft:(NSInteger)cropAreaLeft CropAreaTop:(NSInteger)cropAreaTop CropAreaRight:(NSInteger)cropAreaRight CropAreaBottom:(NSInteger)cropAreaBottom;

@end

@interface ImageCroppingView : UIView

- (instancetype)initWithImageView:(UIImageView *)imageView;

// 设置裁剪区域方框样式
- (void)setCroppingAreaRect:(CGRect)rect;

// 将裁剪区域还原为初始样式
- (void)resetCroppingArea;

// 根据裁剪区域对传入的图片的frame进行限制
- (CGRect)limitImageViewFrame:(UIImageView *)imageView;

// 返回裁剪后的图片
- (UIImage *)returnCroppingImage:(UIImageView *)imageView;

// 返回一个随机字符串作为图片名，组成为UUID（去掉最后一项）-时间戳-随机字符串randomLength位
- (NSString *)randomName:(NSInteger)randomLength;

// 提供点判断方法，判断该点是否在裁剪边界有效区域上
- (BOOL)croppingGestureJudge:(CGPoint)beginPoint;

@end

NS_ASSUME_NONNULL_END
