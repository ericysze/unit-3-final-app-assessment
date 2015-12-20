//
//  C4QSavedCatFactsTableViewController.m
//  unit-3-final-app-assessment
//
//  Created by Eric Sze on 12/20/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QSavedCatFactsTableViewController.h"

@interface C4QSavedCatFactsTableViewController ()

@property (nonatomic) NSArray *savedCatFacts;

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
    self.savedCatFacts = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedCatFacts"];
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
    
    cell.textLabel.text = [self.savedCatFacts objectAtIndex:indexPath.row];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;

    return cell;
}

@end
