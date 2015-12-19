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
    
    cell.catFactLabel.text = [self.catFacts objectAtIndex:indexPath.row];
//    NSString *catFactString;
//    self.catFacts = [catFactString componentsSeparatedByString:@"\n"];
//    
//    cell.catFactLabel.text = [self.catFacts objectAtIndex:indexPath.row];
    
    return cell;
}

//-(float)height :(NSMutableAttributedString*)string
//{
//    CGRect rect = [string boundingRectWithSize:(CGSize){self.tableView.frame.size.width - 110, MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
//    return rect.size.height;
//}

@end
