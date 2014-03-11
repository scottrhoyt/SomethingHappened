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
#import "SHEvent.h"

@interface SHReportViewController () <SHArrayTableViewControllerDelegate, CenterPinMapViewControllerDelegate> /*<UIPickerViewDataSource, UIPickerViewDelegate>*/

@property (nonatomic) BOOL editingDateTime;
@property (nonatomic) BOOL editingEventType;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) NSArray *eventTypes; // of NSString *
@property (weak, nonatomic) IBOutlet UILabel *eventTypeLabel;
@property (strong, nonatomic) SHWebApiFetcher *fetcher;
@property (weak, nonatomic) CenterPinMapViewController *cpmvc;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) SHEvent *event;
@property (weak, nonatomic) IBOutlet UITextView *commentsTextView;

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

- (SHEvent *)event
{
    if (!_event) {
        _event = [[SHEvent alloc] init];
    }
    
    return _event;
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
    
    self.eventTypes = [self.fetcher getEventTypes];
    self.cpmvc = self.childViewControllers[0];
    self.cpmvc.zoomToUser = YES;
    self.cpmvc.doesDisplayPointAccuracyIndicators = YES;
    self.cpmvc.requiredPointAccuracy = 10;
    self.cpmvc.showUserTrackingButton = YES;
    self.cpmvc.shouldReverseGeocode = YES;
    self.cpmvc.delegate = self;
    
    self.addressLabel.text = @"";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setDateLabelWithDate:[NSDate date]];
    [self setTimeLabelWithDate:[NSDate date]];
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
    self.event.reportedAt = selectedDate;
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
    } else {
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
}

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
            destination.key = EVENT_TYPE_NAME_KEY;
        }
    }
}

#pragma mark - SHArrayTableViewController delegate

- (void)arrayTableViewController:(SHArrayTableViewController *)sender DidSelectIndex:(NSUInteger)index
{
    self.eventTypeLabel.text = [self.eventTypes[index] valueForKey:EVENT_TYPE_NAME_KEY];
    self.event.eventTypeId = index; // This needs to be changed;
}

#pragma mark - CenterPinMapViewController delegate

- (void)centerPinMapViewController:(CenterPinMapViewController *)sender didResolvePlacemark:(CLPlacemark *)placemark
{
    self.addressLabel.text = placemark.name;
}

- (IBAction)donePressed:(UIBarButtonItem *)sender {
    self.event.userId = 1;
    self.event.eventLocationLatitude = self.cpmvc.selectedCoordinate.latitude;
    self.event.eventLocationLongitude = self.cpmvc.selectedCoordinate.longitude;
    self.event.reportedLocationLatitude = self.cpmvc.selectedCoordinate.latitude; // need to change
    self.event.reportedLocationLongitude = self.cpmvc.selectedCoordinate.longitude; // need to change
    self.event.comments = self.commentsTextView.text;
    [self.fetcher createNewEvent:self.event];
}

@end
