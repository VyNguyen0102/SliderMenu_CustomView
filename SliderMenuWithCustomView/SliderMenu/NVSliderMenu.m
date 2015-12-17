//
//  NVSliderMenu.m
//  SliderMenuWithCustomView
//
//  Created by VyNV on 12/17/15.
//  Copyright © 2015 VyNV. All rights reserved.
//

#import "NVSliderMenu.h"

#define SLIDE_TIMING .2
#define MARGIN_LEFT 100
#define TOUCH_AREA 30
#define SHADOW_OFFSET 2

@interface NVSliderMenu(){
    BOOL availableTouchPoint;
}
@end

@implementation NVSliderMenu

#pragma init.
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self load];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self load];
    }
    return self;
}

- (instancetype)init:(UIViewController *)viewController {
    CGRect sliderRect = CGRectMake(MARGIN_LEFT - viewController.view.frame.size.width, 0, viewController.view.frame.size.width - MARGIN_LEFT, viewController.view.frame.size.height);
    if (self = [super initWithFrame:sliderRect]) {
        self.delegate = viewController;
        [self load];
    }
    return self;
}
- (void)load {
    UIView *view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"NVSliderMenu" owner:self options:nil] firstObject];
    [self addSubview:view];
    view.frame = self.bounds;
}

#pragma overide
- (void)didMoveToWindow {
    [self setupGestures];
}

#pragma handle action

- (IBAction)buttonClick:(id)sender {
    [self.delegate callback];
}
#pragma Design.

- (void)setViewShadow:(BOOL)isShow {
    if (isShow) {
        [self.layer setShadowColor:[UIColor blackColor].CGColor];
        [self.layer setShadowOpacity:0.8];
        [self.layer setShadowOffset:CGSizeMake(SHADOW_OFFSET, SHADOW_OFFSET)];
    } else {
        [self.layer setShadowOffset:CGSizeMake(0, 0)];
    }
}

#pragma Show, Hide slider.

- (void)showSliderMenu {
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
                     completion:^(BOOL finished) {
                         if (finished) {
                             self.isShow = YES;
                             [self setViewShadow:YES];
                         }
                     }];
}
- (void)hideSliderMenu {
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.frame = CGRectMake( - self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    }
                     completion:^(BOOL finished) {
                         if (finished) {
                             self.isShow = NO;
                             [self setViewShadow:NO];
                         }
                     }];
}

#pragma Handle touch event

- (void)setupGestures {
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(movePanel:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    [self.superview addGestureRecognizer:panRecognizer];
}

- (void)movePanel:(id)sender {
    [[[(UITapGestureRecognizer*)sender view] layer] removeAllAnimations];
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        availableTouchPoint = fabs([sender locationInView:self].x - self.frame.size.width) < TOUCH_AREA;
    }
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        if (availableTouchPoint) {
            CGPoint touchPoint = [sender locationInView:self.superview];
            float xCenter = touchPoint.x - self.frame.size.width/2;
            xCenter = xCenter > self.frame.size.width/2 ? self.frame.size.width/2: xCenter;
            self.center = CGPointMake(xCenter, self.center.y);
        }
    }
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [(UIPanGestureRecognizer*)sender velocityInView:[sender view]];
        if (self.center.x + velocity.x > 0) {
            [self showSliderMenu];
        } else {
            [self hideSliderMenu];
        }
    }
}
@end
