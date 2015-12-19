//
//  C4QCatFactsTableViewCell.m
//  unit-3-final-app-assessment
//
//  Created by Eric Sze on 12/19/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QCatFactsTableViewCell.h"
#import "C4QCatFactsTableViewController.h"
#import "AppDelegate.h"

@implementation C4QCatFactsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addButtonTapped:(UIButton *)sender {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Saved"
                                                                   message:@"New cat fact saved!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];

    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
 
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *catFactsKey = self.catFactLabel.text;
    
    [defaults setObject:@"Cat Facts" forKey:catFactsKey];
    
    if ([defaults objectForKey:catFactsKey]) {
        NSLog(@"Let's Go Home Early, %@", catFactsKey);
    } else {
        NSLog(@"Let's Keep Going");
    }
    
    
    
    
    // Everything returned from NSUserDefaults will return as immutable
    // If you want to add something to a returned array, you must call/send the mutableCopy message to it
//    NSArray *arr = @[];
//    
//    NSMutableArray *mArr = [arr mutableCopy];
//    [mArr addObject:@"butt"];
}

@end
