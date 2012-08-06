//
//  ThirdTimetableTVC.h
//  Modules
//
//  Created by Dawand Sulaiman on 09/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapkuLibrary.h"
#import "iCalendarEngine.h"
#import "AppDelegate.h"
#import "TimetableModule.h"
#import "TimetableModuleDetailsVC.h"
#import "TKProgressAlertView.h"
#import "TimetableCache.h"
#import "timetableListTVC.h"
/**
 Timetable Table View Controller
 
 This class shows subclasses Tapku Calendar Month Table View Controller and it conforms iCalendarEngineDelegate protocol
 */

@interface TimetableTVC :TKCalendarMonthTableViewController <iCalendarEngineDelegate>
{
    NSMutableArray *dataArray; 
	NSMutableDictionary *dataDictionary;
    NSMutableDictionary *dataSelected;
    NSMutableDictionary *titleDictionary;
    NSMutableArray *data;
    NSMutableArray *startDateData;
    
    NSMutableArray *cachedItems;
    NSString *dateLabelStr;
    NSString *username;
    NSString *password;
    NSDate *selectedDate;
}

@property (retain,nonatomic) NSMutableArray *dataArray;
@property (retain,nonatomic) NSMutableDictionary *dataDictionary;
@property (retain,nonatomic) NSMutableDictionary *dataSelected;
@property (retain,nonatomic) NSMutableDictionary *titleDictionary;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSMutableArray *startDateData;
@property (nonatomic,strong) NSString *dateLabelStr;
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSDate *selectedDate;

@property (nonatomic, strong) RESTRequest *ModulesRequest;
@property (nonatomic,retain)TKProgressAlertView *AlertProgress;
@property (nonatomic,strong) NSMutableArray *cachedItems;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *dateLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SegmentedControlOutlet;

/**
 This method performs the retrieval of the timetable modules by calling the methods in the iCalendarEngine protocol
 */
- (void) fetchFromServer;

/**
 This method generates a list of dates which contain modules so they will be marked as a dot on the timetable
 
 @param startDate of the current view of the timetable
 @param endDate of the current view of the timetable
 */
- (void) generateDataForStartDate:(NSDate*)start endDate:(NSDate*)end;

/**
 This method handles the changes when the segment control is tapped (Month view, List view) segments
 */
- (IBAction)SegmentedControlTapped:(id)sender;

/**
 This method performs the retrieval of timetable modules from the server again by calling the fetchFromServer method when Refresh button is pressed
 */
- (IBAction)RefreshBtnTapped:(id)sender;

@end