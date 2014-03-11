//
//  SHViewController.m
//  SomethingHappened
//
//  Created by Scott Hoyt on 3/4/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import "SHMainViewController.h"
#import "SHWebApiFetcher.h"
#import "SHReportViewController.h"

@interface SHMainViewController ()

@property (strong, nonatomic) SHWebApiFetcher *fetcher;

@end

@implementation SHMainViewController

#pragma mark - Setters/Getters

- (SHWebApiFetcher *)fetcher
{
    if (_fetcher) {
        _fetcher = [[SHWebApiFetcher alloc] init];
    }
    
    return _fetcher;
}

#pragma mark - VC Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Navigation

#define SEGUE_TO_REPORT_ID @"Seque To Report"

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:SEGUE_TO_REPORT_ID]) {
        if ([segue.destinationViewController isKindOfClass:[SHReportViewController class]]) {
            SHReportViewController *reportViewController = (SHReportViewController *)segue.destinationViewController;
            reportViewController.fetcher = self.fetcher;
        }
    }
}

@end
