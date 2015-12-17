//
//  NVSliderMenu.h
//  SliderMenuWithCustomView
//
//  Created by VyNV on 12/17/15.
//  Copyright © 2015 VyNV. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NVSliderMenuDelegate <NSObject>
@required
- (void) callback;
@end

@interface NVSliderMenu : UIView <UIGestureRecognizerDelegate>

@property (nonatomic,strong) id delegate;
@property (nonatomic) BOOL isShow;

- (instancetype)init:(UIViewController *)viewController;

- (void)showSliderMenu;
- (void)hideSliderMenu;
@end
