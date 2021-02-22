//
//  PlayerViewController.h
//  LandscapeWindowDemo
//
//  Created by yang on 2021/2/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LayoutGuide : UILayoutGuide
//@property (nonatomic, weak)UILayoutGuide *window_safeAreaGuide;
@end

@interface PlayerView : UIView
@property (nonatomic, strong)LayoutGuide *ov_safeAreaGuide;

//- (void)setWindowSafeAreaGuide:(UILayoutGuide *)layoutGuide;
@end


@interface PlayerViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
