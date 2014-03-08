//
//  SHReportViewController.m
//  SomethingHappened
//
//  Created by Scott Hoyt on 3/5/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import "SHReportViewController.h"
#import "SHArrayTableViewController.h"
#import "SHWebApiFetcher.h"
#import "CenterPinMapViewController.h"

@interface SHReportViewController () <SHArrayTableViewControllerDelegate> /*<UIPickerViewDataSource, UIPickerViewDelegate>*/

@property (nonatomic) BOOL editingDateTime;
@property (nonatomic) BOOL editingEventType;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) NSArray *eventTypes; // of NSString *
//@property (weak, nonatomic) IBOutlet UIPickerView *eventTypePicker;
@property (weak, nonatomic) IBOutlet UILabel *eventTypeLabel;
@property (strong, nonatomic) SHWebApiFetcher *fetcher;
@property (weak, nonatomic) CenterPinMapViewController *cpmvc;


@end

@implementation SHReportViewController

- (SHWebApiFetcher *)fetcher
{
    if (!_fetcher) {
        _fetcher = [[SHWebApiFetcher alloc] init];
    }
    
    return _fetcher;
}

- (NSArray *)eventTypes
{
    if (!_eventTypes) {
        _eventTypes = @[@"", @"Event 1",@"Event 2",@"Event 3"];
    }
    
    return _eventTypes;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.fetcher getEventTypes];
    self.cpmvc = self.childViewControllers[0];
    self.cpmvc.zoomToUser = YES;
    self.cpmvc.doesDisplayPointAccuracyIndicators = YES;
    self.cpmvc.requiredPointAccuracy = 5;
    self.cpmvc.showUserTrackingButton = YES;

//    self.eventTypePicker.dataSource = self;
//    self.eventTypePicker.delegate = self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setDateLabelWithDate:[NSDate date]];
    [self setTimeLabelWithDate:[NSDate date]];
    //self.eventTypeLabel.text = [self.eventTypes objectAtIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDateLabelWithDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale currentLocale];
    dateFormatter.dateStyle = NSDateFormatterLongStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    self.dateLabel.text = [dateFormatter stringFromDate:date];
}

- (void)setTimeLabelWithDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale currentLocale];
    dateFormatter.dateStyle = NSDateFormatterNoStyle;
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    self.timeLabel.text = [dateFormatter stringFromDate:date];
}

- (IBAction)datePickerValueChanged:(UIDatePicker *)sender {
    NSDate *selectedDate = sender.date;
    [self setDateLabelWithDate:selectedDate];
    [self setTimeLabelWithDate:selectedDate];
}

#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [super numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

#define DATE_CELL_SECTION 1
#define DATE_CELL_ROW 1
#define EVENT_TYPE_CELL_SECTION 1
#define EVENT_TYPE_CELL_ROW 3

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == DATE_CELL_SECTION && indexPath.row == DATE_CELL_ROW) { // this is my picker cell
        if (self.editingDateTime) {
            return 219;
        } else {
            return 0;
        }
    } /*else if (indexPath.section == EVENT_TYPE_CELL_SECTION && indexPath.row == EVENT_TYPE_CELL_ROW) { // this is my picker cell
        if (self.editingEventType) {
            return 219;
        } else {
            return 0;
        }
    }*/ else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == DATE_CELL_SECTION && indexPath.row == DATE_CELL_ROW - 1) { // this is my date cell above the picker cell
        self.editingDateTime = !self.editingDateTime;
        [UIView animateWithDuration:.4 animations:^{
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:DATE_CELL_ROW inSection:DATE_CELL_SECTION]] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView reloadData];
        }];
    }
    
//    if (indexPath.section == EVENT_TYPE_CELL_SECTION && indexPath.row == EVENT_TYPE_CELL_ROW - 1) { // this is my date cell above the picker cell
//        self.editingEventType = !self.editingEventType;
//        [UIView animateWithDuration:.4 animations:^{
//            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:DATE_CELL_ROW inSection:DATE_CELL_SECTION]] withRowAnimation:UITableViewRowAnimationFade];
//            [self.tableView reloadData];
//        }];
//    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

#define EVENT_TYPE_SELECTION_ID @"Event Type Selection"

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:EVENT_TYPE_SELECTION_ID]) {
        if ([segue.destinationViewController isKindOfClass:[SHArrayTableViewController class]]) {
            SHArrayTableViewController *destination = (SHArrayTableViewController *)segue.destinationViewController;
            destination.data = self.eventTypes;
            destination.delegate = self;
        }
    }
}

//#pragma mark - picker datasource
//
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
//{
//    return 1;
//}
//
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
//{
//    return self.eventTypes.count;
//}
//
//#pragma mark - picker delegate
//
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    return [self.eventTypes objectAtIndex:row];
//}

#pragma mark - SHArrayTableViewController delegate

- (void)arrayTableViewController:(SHArrayTableViewController *)sender DidSelectIndex:(NSUInteger)index
{
    self.eventTypeLabel.text = self.eventTypes[index];
}

@end
