//
//  ViewController.m
//  SliderMenuWithCustomView
//
//  Created by VyNV on 12/17/15.
//  Copyright © 2015 VyNV. All rights reserved.
//

#import "ViewController.h"
#import "NVSliderMenu.h"

@interface ViewController () <NVSliderMenuDelegate>{
    NVSliderMenu *mySliderMenu;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mySliderMenu = [[NVSliderMenu alloc]init:self];
    [self.view addSubview:mySliderMenu];
}

- (IBAction)showSliderClick:(id)sender {
    if (!mySliderMenu.isShow) {
        [mySliderMenu showSliderMenu];
    } else {
        [mySliderMenu hideSliderMenu];
    }
}

-(void)callback{
    // Implement call back function here
    NSLog(@"callback function is called. ");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
