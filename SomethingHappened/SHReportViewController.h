//
//  SHReportViewController.h
//  SomethingHappened
//
//  Created by Scott Hoyt on 3/5/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHWebApiFetcher.h"

@interface SHReportViewController : UITableViewController

@property (strong, nonatomic) SHWebApiFetcher *fetcher;

@end
