//
//  ViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 11/30/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QViewController.h"
#import "C4QColorPickerViewController.h"

@interface C4QViewController () <ColorPassingDelegate>

@end

@implementation C4QViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"colorPickerVCSegue"]) {
        C4QColorPickerViewController *colorPickerVC = segue.destinationViewController;
        colorPickerVC.delegate = self;
    }
}

- (void)userDidSelectColor:(UIColor *)color {
    self.view.backgroundColor = color;
}

@end
