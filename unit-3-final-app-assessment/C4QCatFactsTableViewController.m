//
//  C4QCatsTableViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 12/17/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QCatFactsTableViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "C4QCatFactsTableViewCell.h"
#import "C4QCatFactsDetailViewController.h"
#import "C4QSavedCatFactsTableViewController.h"

#define CAT_API_URL @"http://catfacts-api.appspot.com/api/facts?number=100"

@interface C4QCatFactsTableViewController ()

@property (nonatomic) NSArray *catFacts;

@end

@implementation C4QCatFactsTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.estimatedRowHeight = 70.0; // for example. Set your average height
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // tell the table view
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    UINib *nib = [UINib nibWithNibName:@"C4QCatFactsTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CatFactIdentifier"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFJSONResponseSerializer *jsonReponseSerializer = [AFJSONResponseSerializer serializer];
    
    jsonReponseSerializer.acceptableContentTypes = nil;
    manager.responseSerializer = jsonReponseSerializer;
    
    [manager GET:CAT_API_URL parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"Reponse Object: %@",responseObject);
             if (responseObject[@"success"]) {
                 
                 self.catFacts = [[NSArray alloc]initWithArray:responseObject[@"facts"]];
//                 self.catFacts = [responseObject objectForKey:@"facts"];
                 
                 NSLog(@"%@", self.catFacts);
                 [self.tableView reloadData];
             } else {
                 NSLog(@"Network Error");
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"%@",error);
         }];

    
}

- (IBAction)savedButtonTapped:(UIBarButtonItem *)sender {
    C4QSavedCatFactsTableViewController *savedTVC = (C4QSavedCatFactsTableViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"savedTVC"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:savedTVC];
    nav.navigationBar.topItem.title = @"Saved Cat Facts";
    nav.navigationBar.topItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissView:)];
    
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)dismissView:(id)sender {
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewAutomaticDimension;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.catFacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    C4QCatFactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CatFactIdentifier" forIndexPath:indexPath];

    // stores the selected row's cat fact into C4QCatFactsTableViewCell.h's catFact string so NSUserDefaults can use it by adding it to a mutable array
    cell.catFact = [self.catFacts objectAtIndex:indexPath.row];
    cell.catFactLabel.text = [self.catFacts objectAtIndex:indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    C4QCatFactsDetailViewController *catFactsDetailVC = (C4QCatFactsDetailViewController *)[self.storyboard instantiateViewControllerWithIdentifier: @"catFactsDetailVC"];
    catFactsDetailVC.catFact = [self.catFacts objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:catFactsDetailVC animated:YES];
}


@end
