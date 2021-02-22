//
//  PlayerViewController.m
//  LandscapeWindowDemo
//
//  Created by yang on 2021/2/19.
//

#import "PlayerViewController.h"
#import "Masonry.h"

@implementation LayoutGuide

//- (CGRect)layoutFrame {
//    return _window_safeAreaGuide.layoutFrame;
//}

@end

/*==========================================================================================*/
#pragma mark - PlayerView
/*==========================================================================================*/

@implementation PlayerView

//- (UILayoutGuide *)safeAreaLayoutGuide {
//    return [super safeAreaLayoutGuide];
//}
//- (void)setWindowSafeAreaGuide:(UILayoutGuide *)layoutGuide {
//    if (layoutGuide) {
//        self.ov_safeAreaGuide.window_safeAreaGuide = layoutGuide;
//        [self addLayoutGuide:self.ov_safeAreaGuide];
//    } else {
//        self.ov_safeAreaGuide.window_safeAreaGuide = layoutGuide;
//        [self removeLayoutGuide:self.ov_safeAreaGuide];
//    }
//}
//- (LayoutGuide *)ov_safeAreaGuide {
//    if (!_ov_safeAreaGuide) {
//        _ov_safeAreaGuide = [[LayoutGuide alloc] init];
//    }
//    return _ov_safeAreaGuide;
//}
@end


/*==========================================================================================*/
#pragma mark - PlayerViewController
/*==========================================================================================*/
@interface PlayerViewController ()<UITextFieldDelegate>
@property (nonatomic, strong)UIView *containerView;

@property (nonatomic, strong)UIView *topBar;
@property (nonatomic, strong)UIView *bottomBar;

@property (nonatomic, strong)UITextField *textField;
@end

@implementation PlayerViewController

- (void)loadView {
    self.view = [[PlayerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    [self setupSubviews];
}
- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    NSLog(@"###Player safe area: %@", NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
    NSLog(@"###Window safe area: %@", NSStringFromUIEdgeInsets(UIApplication.sharedApplication.windows.firstObject.safeAreaInsets));
}

- (void)setupSubviews {
    self.containerView = [UIView new];
    self.containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view.mas_safeAreaLayoutGuide);
    }];
    
    _topBar = [UIView new];
    _topBar.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_topBar];
    [_topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view.mas_safeAreaLayoutGuide);
        make.height.equalTo(@44);
    }];
    
    _textField = [[UITextField alloc] init];
    _textField.backgroundColor = [UIColor whiteColor];
    [_textField setDelegate:self];
    [self.view addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@40);
        make.width.equalTo(@150);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.textField) {
        [self.textField resignFirstResponder];
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
