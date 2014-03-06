//
//  SHArrayTableViewController.h
//  SomethingHappened
//
//  Created by Scott Hoyt on 3/5/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHArrayTableViewController;

@protocol SHArrayTableViewControllerDelegate <NSObject>

- (void)arrayTableViewController:(SHArrayTableViewController*)sender DidSelectIndex:(NSUInteger)index;

@end

@interface SHArrayTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *data; // of NSStrings
@property (nonatomic, weak) id<SHArrayTableViewControllerDelegate> delegate;

@end
