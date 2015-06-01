//
//  NViewController.m
//  NHWebViewController
//
//  Created by Naithar on 06/01/2015.
//  Copyright (c) 2014 Naithar. All rights reserved.
//

#import "NViewController.h"
#import <NHWebNavigationViewController.h>

@interface NViewController ()

@end

@implementation NViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NHWebNavigationViewController *navigation = [[NHWebNavigationViewController alloc] init];
        
        [self presentViewController:navigation animated:YES completion:nil];
        [navigation.webViewController setUrlPath:@"http://google.com"];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
