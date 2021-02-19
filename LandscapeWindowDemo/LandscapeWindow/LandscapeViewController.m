//
//  LandscapeViewController.m
//  LandscapeWindowDemo
//
//  Created by yang on 2021/2/19.
//

#import "LandscapeViewController.h"

@interface LandscapeViewController ()
@end

@implementation LandscapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return _orientationMask ?: UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    
//    NSLog(@"### Landscape vc safe area: %@", NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
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
