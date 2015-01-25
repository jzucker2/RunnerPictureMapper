//
//  SecondViewController.m
//  RPM
//
//  Created by Jordan Zucker on 1/24/15.
//  Copyright (c) 2015 Jordan Zucker. All rights reserved.
//

#import "SecondViewController.h"
@import MapKit;

@interface SecondViewController () <MKMapViewDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Pictures";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
