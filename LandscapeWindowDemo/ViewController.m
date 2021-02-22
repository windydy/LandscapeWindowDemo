//
//  ViewController.m
//  LandscapeWindowDemo
//
//  Created by yang on 2021/2/19.
//

#import "ViewController.h"
#import "PlayerViewController.h"
#import "LandscapeViewController.h"
#import "Masonry.h"
@interface ViewController ()
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)PlayerViewController *playerVC;
@property (nonatomic, strong)UIButton *rotateButton;

@property (nonatomic, assign)BOOL isLandscape;
@property (nonatomic, strong)UIWindow *landscapeWindow;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupPlayer];
    
    [self setupSubviews];
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    NSLog(@"####SareArea : %@",NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
}

- (void)setupPlayer {
    self.playerVC = [[PlayerViewController alloc] init];
    [self addChildViewController:self.playerVC];
    [self.view addSubview:self.playerVC.view];
    
    [self.playerVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view.mas_safeAreaLayoutGuide);
        make.height.equalTo(self.view.mas_width).multipliedBy(9.0/16.0);
    }];
}

- (void)setupSubviews {
    self.rotateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.rotateButton setTitle:@"旋转" forState:UIControlStateNormal];
    [self.rotateButton addTarget:self action:@selector(actionForRotate) forControlEvents:UIControlEventTouchUpInside];
    [self.playerVC.view addSubview:self.rotateButton];
    
    [self.rotateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.rotateButton.superview);
        make.width.equalTo(@80);
        make.height.equalTo(@40);
    }];
    
    self.label = [UILabel new];
    self.label.text = @"我是容器";
    self.label.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.3];
    self.label.font = [UIFont systemFontOfSize:20];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = [UIColor blackColor];
    [self.view insertSubview:self.label atIndex:0];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view.mas_safeAreaLayoutGuide);
    }];
}

- (void)actionForRotate {
    if (self.isLandscape) {
        NSLog(@"restore rotation");
        [self destroyWindow];
        [self restoreRotationAnimation];
    } else {
        NSLog(@"begin rotation");
        [self createLnadscapeWindow];
        [self beginRotateAniamtion];
    }
}

/*==========================================================================================*/
#pragma mark - Roatate
/*==========================================================================================*/
- (void)createLnadscapeWindow {
    LandscapeViewController *landscapeVC = [LandscapeViewController new];
    landscapeVC.orientationMask = UIInterfaceOrientationMaskLandscape;
    UIWindow *landScapeWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, CGRectGetWidth(UIScreen.mainScreen.bounds), CGRectGetHeight(UIScreen.mainScreen.bounds), 0)];
    landScapeWindow.hidden = NO;
    landScapeWindow.windowLevel = 10000;
    landScapeWindow.rootViewController = landscapeVC;
    self.landscapeWindow = landScapeWindow;
}
- (void)destroyWindow {
    LandscapeViewController *landscapeVC = [LandscapeViewController new];
    landscapeVC.orientationMask = UIInterfaceOrientationMaskPortrait;
    self.landscapeWindow.rootViewController = landscapeVC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.landscapeWindow.rootViewController = nil;
        self.landscapeWindow = nil;
    });
}

- (void)beginRotateAniamtion {
    UIView *targetView = self.playerVC.view;
    UIWindow *firstWindow = [UIApplication sharedApplication].windows.firstObject;
 
    UIEdgeInsets landscapeWindowSafeAreaInsets = self.landscapeWindow.safeAreaInsets;
    [self.playerVC setAdditionalSafeAreaInsets:landscapeWindowSafeAreaInsets];
    
    [firstWindow addSubview:targetView];
    [targetView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(firstWindow);
        make.width.equalTo(firstWindow.mas_height);
        make.height.equalTo(firstWindow.mas_width);
    }];

    [UIView animateWithDuration:0.25
                     animations:^{
        [targetView.superview layoutIfNeeded];
        targetView.transform = CGAffineTransformMakeRotation(M_PI_2);
    } completion:^(BOOL finished) {
        NSLog(@"$$$$ player guide: %@", self.playerVC.view.safeAreaLayoutGuide);
        self.isLandscape = YES;
    }];
}

- (void)restoreRotationAnimation {
    UIView *targetView = self.playerVC.view;
    UIView *superView = self.view;
    /// update layout
    [self.navigationController performSelector:NSSelectorFromString(@"_layoutViewController:") withObject:self];

    [superView addSubview:targetView];
    [self.playerVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view.mas_safeAreaLayoutGuide);
        make.height.equalTo(self.view.mas_width).multipliedBy(9.0/16.0);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [targetView layoutIfNeeded];
        targetView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.isLandscape = NO;
    }];
}

@end
