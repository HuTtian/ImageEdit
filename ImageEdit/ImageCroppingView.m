//
//  ImageCroppingView.m
//  ImageEdit
//
//  Created by 胡天翔 on 2021/9/17.
//

#import "ImageCroppingView.h"
#import <QuartzCore/QuartzCore.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define MIN_CROPPING_WIDTH 50.0
#define MIN_CROPPING_HEIGHT 50.0
// 边界有效区域宽度
#define JUDGE_AREA_WIDTH 20.0


@implementation CroppingLayer

static CGFloat const lineWidth = 2;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cropAreaLeft = 50;
        _cropAreaTop = 50;
        _cropAreaRight = SCREEN_WIDTH - self.cropAreaLeft;
        _cropAreaBottom = 400;
    }
    return self;
}

- (void)drawInContext:(CGContextRef)ctx
{
    UIGraphicsPushContext(ctx);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(ctx, lineWidth);
    CGContextMoveToPoint(ctx, self.cropAreaLeft, self.cropAreaTop);
    CGContextAddLineToPoint(ctx, self.cropAreaLeft, self.cropAreaBottom);
    CGContextStrokePath(ctx);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(ctx, lineWidth);
    CGContextMoveToPoint(ctx, self.cropAreaLeft, self.cropAreaTop);
    CGContextAddLineToPoint(ctx, self.cropAreaRight, self.cropAreaTop);
    CGContextStrokePath(ctx);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(ctx, lineWidth);
    CGContextMoveToPoint(ctx, self.cropAreaRight, self.cropAreaTop);
    CGContextAddLineToPoint(ctx, self.cropAreaRight, self.cropAreaBottom);
    CGContextStrokePath(ctx);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(ctx, lineWidth);
    CGContextMoveToPoint(ctx, self.cropAreaLeft, self.cropAreaBottom);
    CGContextAddLineToPoint(ctx, self.cropAreaRight, self.cropAreaBottom);
    CGContextStrokePath(ctx);
    
    UIGraphicsPopContext();
}

- (void)setCropAreaLeft:(NSInteger)cropAreaLeft
{
    _cropAreaLeft = cropAreaLeft;
    [self setNeedsDisplay];
}

- (void)setCropAreaTop:(NSInteger)cropAreaTop
{
    _cropAreaTop = cropAreaTop;
    [self setNeedsDisplay];
}

- (void)setCropAreaRight:(NSInteger)cropAreaRight
{
    _cropAreaRight = cropAreaRight;
    [self setNeedsDisplay];
}

- (void)setCropAreaBottom:(NSInteger)cropAreaBottom
{
    _cropAreaBottom = cropAreaBottom;
    [self setNeedsDisplay];
}

- (void)setCropAreaLeft:(NSInteger)cropAreaLeft CropAreaTop:(NSInteger)cropAreaTop CropAreaRight:(NSInteger)cropAreaRight CropAreaBottom:(NSInteger)cropAreaBottom
{
    _cropAreaLeft = cropAreaLeft;
    _cropAreaRight = cropAreaRight;
    _cropAreaTop = cropAreaTop;
    _cropAreaBottom = cropAreaBottom;
    
    [self setNeedsDisplay];
}

@end

@interface ImageCroppingView()

@property(nonatomic, strong) CroppingLayer *croppingLayer;

// 裁剪区域的属性，实际上等价于displayFrame
@property(assign, nonatomic) CGFloat cropAreaX;
@property(assign, nonatomic) CGFloat cropAreaY;
@property(assign, nonatomic) CGFloat cropAreaWidth;
@property(assign, nonatomic) CGFloat cropAreaHeight;
// 以这个frame作为底，裁剪区域不应该超过这个frame
@property(assign, nonatomic) CGRect baseFrame;
// 实际显示的裁剪区域的frame
@property(assign, nonatomic) CGRect displayFrame;
// 与父控价的x坐标差异
@property(assign, nonatomic) CGFloat distantX;
// 与父控件的y坐标差异
@property(assign, nonatomic) CGFloat distantY;
// 传入的用于裁剪的图像
@property(strong, nonatomic) UIImageView *imageView;
// 存储手势的起点位置
@property(assign, nonatomic) CGPoint beginPoint;
// 存储裁剪框的四条边的判断范围，为了加速运算过程设为属性
@property(assign, nonatomic) CGRect judgeRectLeft;
@property(assign, nonatomic) CGRect judgeRectRight;
@property(assign, nonatomic) CGRect judgeRectTop;
@property(assign, nonatomic) CGRect judgeRectBottom;
@property(assign, nonatomic) BOOL whetherMove;
// 存储裁剪框的四条边在手势开始时的判断结果，YES代表手势作用于该边
@property(assign, nonatomic) BOOL rightMove;
@property(assign, nonatomic) BOOL leftMove;
@property(assign, nonatomic) BOOL upMove;
@property(assign, nonatomic) BOOL downMove;

@end

@implementation ImageCroppingView

- (instancetype)initWithImageView:(UIImageView *)imageView{
    self = [super initWithFrame:imageView.frame];
    
    self.imageView = imageView;
    self.distantX = imageView.frame.origin.x;
    self.distantY = imageView.frame.origin.y;
    self.baseFrame = [self getImageFrame:imageView];
    [self resetCroppingArea];
    self.userInteractionEnabled = YES;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDynamicPanGesture:)];
    [self addGestureRecognizer:panGesture];
    
    return self;
}

//  获取imageView中image的实际frame（相对于imageView的frame）
- (CGRect)getImageFrame:(UIImageView *)imageView{
    CGFloat scaleWidth = imageView.frame.size.width / imageView.image.size.width;
    CGFloat scaleHeight = imageView.frame.size.height / imageView.image.size.height;
    CGFloat aspect = MIN(scaleWidth, scaleHeight);
    CGRect imageRect = CGRectMake(0, 0, imageView.image.size.width * aspect, imageView.image.size.height * aspect);
    imageRect.origin.x = (imageView.frame.size.width - imageRect.size.width) / 2;
    imageRect.origin.y = (imageView.frame.size.height - imageRect.size.height) / 2;
    return imageRect;
}

//  取两个frame的相交部分
- (CGRect)getIntersectOfFrame1:(CGRect)frame1 andFrame2:(CGRect)frame2{
    CGRect intersectFrame = CGRectMake(MIN(frame1.origin.x, frame2.origin.x)
                                       ,MAX(frame1.origin.y, frame2.origin.y)
                                       ,MIN(frame1.size.width, frame2.size.width)
                                       ,MIN(frame1.size.height, frame2.size.height));
    return intersectFrame;
                                        
}

// 根据裁剪区域对传入的图片进行限制
- (CGRect)limitImageViewFrame:(UIImageView *)imageView{
    // 对图片进行位置修正
    CGRect resetPosition = imageView.frame;
    CGRect currentImageFrame = [self getImageFrame:imageView];
    if ((currentImageFrame.origin.x + resetPosition.origin.x) > (self.distantX + self.cropAreaX)){
        resetPosition.origin.x = (self.distantX + self.cropAreaX) - currentImageFrame.origin.x;
    }
    if ((currentImageFrame.origin.y + resetPosition.origin.y) > (self.distantY + self.cropAreaY)){
        resetPosition.origin.y = (self.distantY + self.cropAreaY) - currentImageFrame.origin.y;
    }
    CGFloat leftedX = (self.distantX + self.cropAreaX + self.cropAreaWidth) - (currentImageFrame.origin.x + resetPosition.origin.x + currentImageFrame.size.width);
    if (leftedX > 0){
        resetPosition.origin.x += leftedX;
    }
    CGFloat downY = (self.distantY + self.cropAreaY + self.cropAreaHeight) - (currentImageFrame.origin.y + resetPosition.origin.y + currentImageFrame.size.height);
    if (downY > 0){
        resetPosition.origin.y += downY;
    }
    
    return resetPosition;
}

- (NSString *)randomName:(NSInteger)randomLength{
    //1.UUIDString
    NSString *string = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        
    //2.时间戳
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSString *timeStr = [NSString stringWithFormat:@"%.0f",time];
        
    //3.随机字符串kRandomLength位
    static const NSString *kRandomAlphabet = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: randomLength];
    for (int i = 0; i < randomLength; i++) {
        [randomString appendFormat: @"%C", [kRandomAlphabet characterAtIndex:arc4random_uniform((u_int32_t)[kRandomAlphabet length])]];
    }
        
    //==> UUIDString去掉最后一项,再拼接上"时间戳"-"随机字符串randomLength位"
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[string componentsSeparatedByString:@"-"]];
    [array removeLastObject];
    [array addObject:timeStr];
    [array addObject:randomString];
    return [array componentsJoinedByString:@"-"];
}

#pragma mark--裁剪区域设置的相关操作

// 画出方形裁剪区域
- (void)setUpRectCroppingLayer{
    self.layer.sublayers = nil;
    self.croppingLayer = [[CroppingLayer alloc] init];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    UIBezierPath *cropPath = [UIBezierPath bezierPathWithRect:self.displayFrame];
    [path appendPath:cropPath];
    self.croppingLayer.path = path.CGPath;
    self.croppingLayer.fillRule = kCAFillRuleEvenOdd;
    self.croppingLayer.fillColor = [[UIColor blackColor] CGColor];
    self.croppingLayer.opacity = 0.6;
    self.croppingLayer.frame = self.bounds;
    [self.croppingLayer setCropAreaLeft:self.cropAreaX CropAreaTop:self.cropAreaY CropAreaRight:self.cropAreaX + self.cropAreaWidth CropAreaBottom:self.cropAreaY + self.cropAreaHeight];
    [self.layer addSublayer:self.croppingLayer];
}

//  任意一条边变化则重制裁剪区域
- (void)anySideChanged{
    self.displayFrame = CGRectMake(self.cropAreaX, self.cropAreaY, self.cropAreaWidth, self.cropAreaHeight);
    [self setUpRectCroppingLayer];
}

//  初始化并画出裁剪区域
- (void)resetCroppingArea{
    self.cropAreaX = self.baseFrame.origin.x + 30;
    self.cropAreaY = self.baseFrame.origin.y + 3;
    self.cropAreaWidth = self.baseFrame.size.width - 60;
    self.cropAreaHeight = self.baseFrame.size.height - 6;
    self.displayFrame = CGRectMake(self.cropAreaX, self.cropAreaY, self.cropAreaWidth, self.cropAreaHeight);
    [self setUpRectCroppingLayer];
}

//  用rect设置裁剪区域
- (void)setCroppingAreaRect:(CGRect)rect{
    self.displayFrame = rect;
    self.cropAreaX = rect.origin.x;
    self.cropAreaY = rect.origin.y;
    self.cropAreaWidth = rect.size.width;
    self.cropAreaHeight = rect.size.height;
    [self setUpRectCroppingLayer];
}

// 返回裁剪后的图片
- (UIImage *)returnCroppingImage:(UIImageView *)imageView{
    CGRect currentImageFrame = [self getImageFrame:imageView];
    CGRect viewFrame = imageView.frame;
    
    CGFloat imageScale = MAX(imageView.image.size.width / imageView.frame.size.width, imageView.image.size.height / imageView.frame.size.height);
    CGImageRef imageRef = imageView.image.CGImage;
    CGFloat cgScaleWidth = CGImageGetWidth(imageRef) / imageView.image.size.width;
    CGFloat cgScaleHeight = CGImageGetHeight(imageRef) / imageView.image.size.height;
    CGFloat cropRectX = (self.cropAreaX - currentImageFrame.origin.x + self.distantX - viewFrame.origin.x) * imageScale * cgScaleWidth;
    CGFloat cropRectY = (self.cropAreaY - currentImageFrame.origin.y + self.distantY - viewFrame.origin.y) * imageScale * cgScaleHeight;
    CGFloat cropRectWidth = self.cropAreaWidth * imageScale * cgScaleWidth;
    CGFloat cropRectHeight = self.cropAreaHeight * imageScale * cgScaleHeight;
    CGRect cropRect = CGRectMake(cropRectX, cropRectY, cropRectWidth, cropRectHeight);
    CGImageRef cutImageRef = CGImageCreateWithImageInRect(imageView.image.CGImage, cropRect);
    UIImage *croppedImage = [UIImage imageWithCGImage:cutImageRef];
    CGImageRelease(cutImageRef);
    return croppedImage;
}

#pragma mark--gesture
- (BOOL)croppingGestureJudge:(CGPoint)beginPoint{
    return self.whetherMove;
}

- (void)handleDynamicPanGesture:(UIPanGestureRecognizer *)panGesture{
    if (panGesture.state == UIGestureRecognizerStateBegan){
        self.beginPoint = [panGesture locationInView:self];
        self.beginPoint = CGPointMake(self.beginPoint.x + self.distantX, self.beginPoint.y + self.distantY);
        self.judgeRectLeft = CGRectMake(self.displayFrame.origin.x - JUDGE_AREA_WIDTH, self.displayFrame.origin.y, 2 * JUDGE_AREA_WIDTH, self.displayFrame.size.height);
        self.judgeRectRight = CGRectMake(self.displayFrame.origin.x + self.displayFrame.size.width - JUDGE_AREA_WIDTH, self.displayFrame.origin.y, 2 * JUDGE_AREA_WIDTH, self.displayFrame.size.height);
        self.judgeRectTop = CGRectMake(self.displayFrame.origin.x, self.displayFrame.origin.y - JUDGE_AREA_WIDTH, self.displayFrame.size.width, 2 * JUDGE_AREA_WIDTH);
        self.judgeRectBottom = CGRectMake(self.displayFrame.origin.x, self.displayFrame.origin.y + self.displayFrame.size.height - JUDGE_AREA_WIDTH, self.displayFrame.size.width, 2 * JUDGE_AREA_WIDTH);
        CGPoint beginPoint = CGPointMake(self.beginPoint.x - self.distantX, self.beginPoint.y - self.distantY);
        self.leftMove = CGRectContainsPoint(self.judgeRectLeft, beginPoint);
        self.rightMove = CGRectContainsPoint(self.judgeRectRight, beginPoint);
        self.upMove = CGRectContainsPoint(self.judgeRectTop, beginPoint);
        self.downMove = CGRectContainsPoint(self.judgeRectBottom, beginPoint);
        self.whetherMove = self.leftMove | self.rightMove | self.upMove | self.downMove;
    }
    if (self.whetherMove && panGesture.state == UIGestureRecognizerStateChanged){
        CGPoint movePoint = [panGesture locationInView:self];
        
        if (self.leftMove){
            if ((movePoint.x >= self.baseFrame.origin.x) && (movePoint.x <= (self.baseFrame.origin.x + self.baseFrame.size.width))){
                CGFloat diff = movePoint.x - self.cropAreaX;
                self.cropAreaX = movePoint.x;
                self.cropAreaWidth -= diff;
            }
        }
        if (self.rightMove){
            if ((movePoint.x >= self.baseFrame.origin.x) && (movePoint.x <= (self.baseFrame.origin.x + self.baseFrame.size.width))){
                CGFloat diff = movePoint.x - (self.cropAreaX + self.cropAreaWidth);
                self.cropAreaWidth += diff;
            }
        }
        if (self.upMove){
            if ((movePoint.y >= self.baseFrame.origin.y) && (movePoint.y <= (self.baseFrame.origin.y + self.baseFrame.size.height))){
                CGFloat diff = movePoint.y - self.cropAreaY;
                self.cropAreaY = movePoint.y;
                self.cropAreaHeight -= diff;
            }
        }
        if (self.downMove){
            if ((movePoint.y >= self.baseFrame.origin.y) && (movePoint.y <= (self.baseFrame.origin.y + self.baseFrame.size.height))){
                CGFloat diff = movePoint.y - (self.cropAreaY + self.cropAreaHeight);
                self.cropAreaHeight += diff;
            }
        }
        [self anySideChanged];
    }
    else if (panGesture.state == UIGestureRecognizerStateEnded){
//        self.imageView.frame = [self limitImageViewFrame:self.imageView];
    }
}

#pragma mark--getter
- (BOOL)whetherMove{
    if(!_whetherMove){
        _whetherMove = NO;
    }
    return _whetherMove;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
