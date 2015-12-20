//
//  C4QCatFactDetailViewController.m
//  unit-3-final-app-assessment
//
//  Created by Michael Kavouras on 12/18/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QCatFactsDetailViewController.h"
#import <AFNetworking/AFNetworking.h>

#define CAT_GIF_URL @"http://api.giphy.com/v1/gifs/search?q=funny+cat&api_key=dc6zaTOxFJmzC"

@interface C4QCatFactsDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *catImageView;
@property (weak, nonatomic) IBOutlet UILabel *catFactDetailLabel;

@end

@implementation C4QCatFactsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.catFactDetailLabel.text = self.catFact;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:CAT_GIF_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        int upperBound = [[responseObject[@"pagination"] objectForKey:@"count"] intValue];
        int randomNumber = arc4random_uniform(upperBound);
        
        NSDictionary *randomDictionary = responseObject[@"data"][randomNumber];
        NSString *urlString = randomDictionary[@"images"][@"fixed_width"][@"url"];
        
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:urlString]];
            if (data == nil)
                return;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.catImageView.image = [UIImage imageWithData:data];
            });
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@",error);
    }];
}

- (IBAction)backButtonTapped:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
