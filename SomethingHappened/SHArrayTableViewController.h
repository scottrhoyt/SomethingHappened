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

///@brief This is the key to use for each member of the array to get title information
@property (nonatomic, strong) NSString *key;

@property (nonatomic, weak) id<SHArrayTableViewControllerDelegate> delegate;

@end
