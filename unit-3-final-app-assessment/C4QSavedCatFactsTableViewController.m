//
//  C4QSavedCatFactsTableViewController.m
//  unit-3-final-app-assessment
//
//  Created by Eric Sze on 12/20/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QSavedCatFactsTableViewController.h"

@interface C4QSavedCatFactsTableViewController ()

@property (nonatomic) NSMutableArray *savedCatFacts;

@end

@implementation C4QSavedCatFactsTableViewController

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    self.tableView.estimatedRowHeight = 70.0; // for example. Set your average height
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    [self.tableView reloadData];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 70.0;

    // load array with data previously saved into it from NSUserDefaults
//    self.savedCatFacts = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedCatFacts"];
    NSArray *catFactsArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedCatFacts"];

    //    self.savedCatFacts = catFactsArray ? [NSMutableArray arrayWithArray:catFactsArray] : [NSMutableArray new];
    
    if (catFactsArray) {
        self.savedCatFacts = [NSMutableArray arrayWithArray:catFactsArray];
    } else {
        self.savedCatFacts = [NSMutableArray new];
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.savedCatFacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"savedCatFactIdentifier" forIndexPath:indexPath];
    
//    cell.textLabel.text = [self.savedCatFacts objectAtIndex:indexPath.row];
    cell.textLabel.text = self.savedCatFacts[indexPath.row];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.savedCatFacts removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}


#pragma mark - LifeCycle Method
// When view disappears, save current changes
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // remove entire array that was presented/loaded
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"savedCatFacts"];
    // add the entire array with new changes back to the same key
    [[NSUserDefaults standardUserDefaults] setObject:self.savedCatFacts forKey:@"savedCatFacts"];
    // save
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end
