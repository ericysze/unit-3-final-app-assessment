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

    [self showAlertView];
    [self saveIntoNSUserDefaults];
    
}


- (void)showAlertView {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Saved"
                                                                   message:@"New cat fact saved!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (void)saveIntoNSUserDefaults {
    // Everything returned from NSUserDefaults will return as immutable
    // If you want to add something to a returned array, you must call/send the mutableCopy message to it

    // set up NSUserDefaults with Key
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"savedCatFacts"]) {
        // create an array with NSUserDefaults and objectForKey
        NSArray *catFactArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedCatFacts"];
        // send mutableCopy message to previously created array to be able to add or remove
        // objects into said array, set it equal to an NSMutableArray to be able to mutate it
        NSMutableArray *mutableCatArr = [catFactArray mutableCopy];
        // now it can be mutated
        [mutableCatArr addObject:self.catFact];
        // send copy message to previous mutable arr to turn it back to immutable
        NSArray *catFactArr = [mutableCatArr copy];
        // save array into NSUserDefaults for the same exact key
        [[NSUserDefaults standardUserDefaults] setObject:catFactArr forKey:@"savedCatFacts"];
        
    } else {
        
        NSArray *catFactArray = [[NSArray alloc]initWithObjects:self.catFact, nil];
        [[NSUserDefaults standardUserDefaults] setObject:catFactArray forKey:@"savedCatFacts"];
    }
}

@end
