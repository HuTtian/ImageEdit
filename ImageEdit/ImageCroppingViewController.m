//
//  ImageCroppingViewController.m
//  ImageEdit
//
//  Created by 胡天翔 on 2021/9/17.
//

#import "ImageCroppingViewController.h"
#import <Masonry/Masonry.h>
#import <SSPCommonMacros/SSPCommonMacros.h>
#import "ImageCroppingView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
// 相比原始大小的最大缩放比例
CGFloat const scaleMaxRation = 4.0;
// 相比原始大小的最小缩放比例（裁剪时最小缩放比例为1.0）
CGFloat const scaleMinRation = 0.33;
// 旋转
NSArray<NSNumber *> *SpinDirection;

@interface ImageCroppingViewController ()<UIGestureRecognizerDelegate>

@property(nonatomic, strong, nullable) UIImage *image;

@property(nonatomic, strong, nullable) UIImageView *imageView;

@property(assign, nonatomic) CGRect originalImageViewFrame;

@property(nonatomic, strong, nullable) ImageCroppingView *imageCroppingView;

@property(assign, nonatomic) BOOL isCropping;

@property(assign, nonatomic) CGPoint beginPoint;

@property(assign, nonatomic) NSInteger currentSpinDirection;

@end

@implementation ImageCroppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.isCropping = false;
    SpinDirection = [[NSArray alloc] initWithObjects:@2, @1, @3, @0, nil];
    self.currentSpinDirection = 3;
    
    // 对图片和手势进行初始化
    self.image = [UIImage imageNamed:@"whale"];
    self.imageView = [[UIImageView alloc] initWithImage:self.image];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.imageView setFrame:CGRectMake(0, MNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT * 0.8)];
    UIPinchGestureRecognizer *pinGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleCenterPinGesture:)];
    [self.view addGestureRecognizer:pinGesture];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDynamicPanGesture:)];
    [self.view addGestureRecognizer:panGesture];
    panGesture.delegate = self;
    self.originalImageViewFrame = self.imageView.frame;
    self.view.userInteractionEnabled = YES;
    
    // CroppingView设置
    self.imageCroppingView = [[ImageCroppingView alloc] initWithImageView:self.imageView];
    
    // 对按钮进行初始化
    UIButton *resetButton = [[UIButton alloc] init];
    [self setButton:@"还原" scale:0.1 button:resetButton];
    [resetButton addTarget:self action:@selector(resetImageView) forControlEvents:UIControlEventTouchUpInside];
    UIButton *startCroppingButton = [[UIButton alloc] init];
    [self setButton:@"裁剪" scale:0.4 button:startCroppingButton];
    [startCroppingButton addTarget:self action:@selector(croppingImage) forControlEvents:UIControlEventTouchUpInside];
    UIButton *saveButton = [[UIButton alloc] init];
    [self setButton:@"保存" scale:0.7 button:saveButton];
    [saveButton addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
//    [self setButton:@"旋转" scale:0.7 button:saveButton];
//    [saveButton addTarget:self action:@selector(spinImage) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *speratorViewBottom = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT * 0.8 , SCREEN_WIDTH, SCREEN_HEIGHT * 0.2)];
    speratorViewBottom.backgroundColor = [UIColor whiteColor];
    UIView *speratorViewTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, MNavigationBarHeight + self.navigationController.navigationBar.frame.size.height)];
    speratorViewTop.backgroundColor = [UIColor whiteColor];
    
    //  添加顺序乱了就会当场暴毙
    [self.view addSubview:self.imageView];
    [self.view addSubview:speratorViewBottom];
    [self.view addSubview:speratorViewTop];
    [self.view addSubview:resetButton];
    [self.view addSubview:startCroppingButton];
    [self.view addSubview:saveButton];
}

// 还原到原始图片样式
- (void)resetImageView{
    [self.imageView setFrame:self.originalImageViewFrame];
    [self.imageCroppingView resetCroppingArea];
}

// 开始裁剪
- (void)croppingImage{
    [self.imageView setFrame:self.originalImageViewFrame];
    [self.view addSubview:self.imageCroppingView];
    [self.view bringSubviewToFront:self.imageCroppingView];
    self.isCropping = true;
}

//保存裁剪后的图片
- (void)saveImage{
    if (self.isCropping){
        NSString *imageSaveName = [self.imageCroppingView randomName:4];
        UIImage *imageSaved = [self.imageCroppingView returnCroppingImage:self.imageView];
        NSString *homePath = NSHomeDirectory();
        NSString *imagePath = [homePath stringByAppendingString:imageSaveName];
        // 具体保存在哪是个大问题
//        [UIImagePNGRepresentation(imageSaved) writeToFile:imagePath atomically:YES];
        NSLog(@"%@", imagePath);
    }
    else {
        NSLog(@"Not Cropping");
    }
}

// 每次点击都旋转90度
- (void)spinImage{
    self.currentSpinDirection = (self.currentSpinDirection + 1) % 4;
    NSInteger direction = SpinDirection[self.currentSpinDirection].intValue;
    self.imageView.image = [UIImage imageWithCGImage:self.imageView.image.CGImage scale:self.imageView.image.scale orientation:direction];
}

//  获取imageView中image的实际frame（相对于self.view的frame）
- (CGRect)getImageFrame:(UIImageView *)imageView{
    CGFloat scaleWidth = imageView.frame.size.width / imageView.image.size.width;
    CGFloat scaleHeight = imageView.frame.size.height / imageView.image.size.height;
    CGFloat aspect = MIN(scaleWidth, scaleHeight);
    CGRect imageRect = CGRectMake(0, 0, imageView.image.size.width * aspect, imageView.image.size.height * aspect);
    imageRect.origin.x = imageView.frame.origin.x + ((imageView.frame.size.width - imageRect.size.width) / 2);
    imageRect.origin.y = imageView.frame.origin.y + ((imageView.frame.size.height - imageRect.size.height) / 2);
    return imageRect;
}

// 对button进行通用化设置，减少代码
- (void)setButton:(NSString *)title scale:(CGFloat)scale button:(UIButton *)button{
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [button.layer setBorderWidth:1.0];
    [button.layer setBorderColor:[UIColor blackColor].CGColor];
    [button setFrame:CGRectMake(SCREEN_WIDTH * scale, SCREEN_HEIGHT * 0.85, SCREEN_WIDTH * 0.2, SCREEN_HEIGHT * 0.05)];
    [button setTitleColor:UIColor.blueColor forState:UIControlStateHighlighted];
}

#pragma mark--gesture
- (void)handleCenterPinGesture:(UIPinchGestureRecognizer *)pinGesture{
    UIView * view = self.imageView;
    CGFloat maxWidth = self.originalImageViewFrame.size.width * scaleMaxRation;
    CGFloat minWidth = self.originalImageViewFrame.size.width * scaleMinRation;
    if (self.isCropping){
        // 裁剪状态下最小缩放比例为1
        minWidth = self.originalImageViewFrame.size.width;
    }

    // 缩放开始与缩放中
    if (pinGesture.state == UIGestureRecognizerStateBegan || pinGesture.state == UIGestureRecognizerStateChanged) {
        // 移动缩放中心到手指中心
        CGFloat scale = pinGesture.scale;
        // 将要放大且放大后大于最大缩放限制
        if ((scale > 1.0) && (view.frame.size.width * scale > maxWidth)){
            scale = maxWidth / view.frame.size.width;
        }
        // 将要缩小且缩小后小于最小缩放限制
        if ((scale < 1.0) && (view.frame.size.width * scale < minWidth)){
            scale = minWidth / view.frame.size.width;
        }
        
        CGPoint pinchCenter = [pinGesture locationInView:view.superview];
        CGFloat distanceX = view.frame.origin.x - pinchCenter.x;
        CGFloat distanceY = view.frame.origin.y - pinchCenter.y;
        CGFloat scaledDistanceX = distanceX * scale;
        CGFloat scaledDistanceY = distanceY * scale;
        CGRect newFrame = CGRectMake(view.frame.origin.x + scaledDistanceX - distanceX, view.frame.origin.y + scaledDistanceY - distanceY, view.frame.size.width * scale, view.frame.size.height * scale);
        view.frame = newFrame;
        [pinGesture setScale:1.0];
    }

    // 缩放结束
    if (pinGesture.state == UIGestureRecognizerStateEnded) {
        if (self.isCropping){
            view.frame = [self.imageCroppingView limitImageViewFrame:self.imageView];
        }
    }
}

- (void)handleDynamicPanGesture:(UIPanGestureRecognizer *)panGesture{
    CGPoint translation = [panGesture translationInView:self.view];
    CGRect validRect = [self getImageFrame:self.imageView];
    BOOL whetherMove = YES;
    
    if (panGesture.state == UIGestureRecognizerStateBegan){
        self.beginPoint = [panGesture locationInView:self.view];
    }

    // 如果没有落在图片上或者落在了边界线上，就不起作用
    if ((!CGRectContainsPoint(validRect, self.beginPoint)) || (self.isCropping && [self.imageCroppingView croppingGestureJudge:self.beginPoint])){
        whetherMove = NO;
    }
    if (whetherMove && panGesture.state == UIGestureRecognizerStateChanged){
        [self.imageView setCenter:CGPointMake(self.imageView.center.x + translation.x, self.imageView.center.y + translation.y)];
        [panGesture setTranslation:CGPointZero inView:self.view];
    }
    // 结束拖动后如果处于裁剪状态，需要调整图片
    if (panGesture.state == UIGestureRecognizerStateEnded){
        if (self.isCropping){
            self.imageView.frame = [self.imageCroppingView limitImageViewFrame:self.imageView];
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

#pragma mark--getter


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
