//
//  secondTimetableVC.m
//  Modules
//
//  Created by Dawand Sulaiman on 08/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "secondTimetableVC.h"

static int calendarShadowOffset = (int)-20;

@implementation secondTimetableVC

@synthesize objects, calendar, data;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
//- (void)loadView
//{
//
//    
//
//}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    calendar = 	[[TKCalendarMonthView alloc] init];
    calendar.delegate = self;
    calendar.dataSource = self;
    
    calendar.frame = CGRectMake(0, 0, calendar.frame.size.width, calendar.frame.size.height);
	// Ensure this is the last "addSubview" because the calendar must be the top most view layer	
	[self.view addSubview:calendar];
	[calendar reload];
    
    [ApplicationDelegate.CalendarEngine fetchTimetableItems];
     ApplicationDelegate.CalendarEngine.delegate = self;

    data = [[NSMutableArray alloc]init];
    
    [super viewDidLoad];
}

-(void) menuFetchSucceeded:(NSString *) calendarItems
{
    CGICalendar *ical = [[CGICalendar alloc] init];
    if ([ical parseWithString:calendarItems error:nil]) {
        self.objects = ical.objects;
        
        for (CGICalendarObject *icalObj in [self objects]) {
            for (CGICalendarComponent *icalComp in [icalObj components]) {
                NSDate *start = [icalComp dateTimeStart];
                NSDate *end = [icalComp dateTimeEnd];
                
                NSString *icalCompType = [icalComp type];
                
            //    NSString *startString = [NSString stringWithFormat:@"%@",start];
                
                if(!(start==nil)){
                [data addObject:start];
                }
                
             //   NSLog([data description]);
             //   NSLog([NSString stringWithFormat:@"%@ , %@ , %@", icalCompType,start,end]);
                
                for (CGICalendarProperty *icalProp in [icalComp properties]) {
                    NSString *icalPropName = [icalProp name];
                    NSString *icalPropValue = [icalProp value];
          //          NSLog(icalPropName);
          //          NSLog(icalPropValue);
                    for (CGICalendarParameter *icalParam in [icalProp parameters]) {
                        NSString *icalParamName = [icalProp name];
                        NSString *icalPropValue = [icalProp value];
          //              NSLog(icalPropName);
          //              NSLog(icalPropValue);
                    }
                }
            }
        }
    }
    
}

-(void) menuFetchFailed:(NSError*) error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                    message:[error localizedRecoverySuggestion]
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"Dismiss", @"")
                                          otherButtonTitles: nil];
    [alert show];
}

- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d {
	NSLog(@"calendarMonthView didSelectDate");
}

- (void)calendarMonthView:(TKCalendarMonthView *)monthView monthDidChange:(NSDate *)d {
	NSLog(@"calendarMonthView monthDidChange");	
    [calendar reload];

}

#pragma mark -
#pragma mark TKCalendarMonthViewDataSource methods

- (NSArray*)calendarMonthView:(TKCalendarMonthView *)monthView marksFromDate:(NSDate *)startDate toDate:(NSDate *)lastDate {	
//	NSLog(@"calendarMonthView marksFromDate toDate");	
//	NSLog(@"Make sure to update 'data' variable to pull from CoreData, website, User Defaults, or some other source.");
	// When testing initially you will have to update the dates in this array so they are visible at the
	// time frame you are testing the code.
    
//	NSArray *data = [NSArray arrayWithObjects:
//					 @"2011-01-01 00:00:00 +0000", @"2011-01-09 00:00:00 +0000", @"2011-01-22 00:00:00 +0000",
//					 @"2011-01-10 00:00:00 +0000", @"2011-01-11 00:00:00 +0000", @"2011-01-12 00:00:00 +0000",
//					 @"2011-01-15 00:00:00 +0000", @"2011-01-28 00:00:00 +0000", @"2011-01-04 00:00:00 +0000",					 
//					 @"2011-01-16 00:00:00 +0000", @"2011-01-18 00:00:00 +0000", @"2011-01-19 00:00:00 +0000",					 
//					 @"2011-01-23 00:00:00 +0000", @"2011-01-24 00:00:00 +0000", @"2011-01-25 00:00:00 +0000",					 					 
//					 @"2011-02-01 00:00:00 +0000", @"2011-03-01 00:00:00 +0000", @"2011-04-01 00:00:00 +0000",
//					 @"2011-05-01 00:00:00 +0000", @"2011-06-01 00:00:00 +0000", @"2011-07-01 00:00:00 +0000",
//					 @"2011-08-01 00:00:00 +0000", @"2011-09-01 00:00:00 +0000", @"2011-10-01 00:00:00 +0000",
//					 @"2011-11-01 00:00:00 +0000", @"2011-12-01 00:00:00 +0000", nil]; 
	
    
	// Initialise empty marks array, this will be populated with TRUE/FALSE in order for each day a marker should be placed on.
	NSMutableArray *marks = [NSMutableArray array];
	
	// Initialise calendar to current type and set the timezone to never have daylight saving
	NSCalendar *cal = [NSCalendar currentCalendar];
	[cal setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	
	// Construct DateComponents based on startDate so the iterating date can be created.
	// Its massively important to do this assigning via the NSCalendar and NSDateComponents because of daylight saving has been removed 
	// with the timezone that was set above. If you just used "startDate" directly (ie, NSDate *date = startDate;) as the first 
	// iterating date then times would go up and down based on daylight savings.
	NSDateComponents *comp = [cal components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit) 
                                    fromDate:startDate];
	NSDate *d = [cal dateFromComponents:comp];
	
   
	
    // Init offset components to increment days in the loop by one each time
	NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
	[offsetComponents setDay:1];	
	
    
	// for each date between start date and end date check if they exist in the data array
	while (YES) {
		// Is the date beyond the last date? If so, exit the loop.
		// NSOrderedDescending = the left value is greater than the right
		if ([d compare:lastDate] == NSOrderedDescending) {
			break;
		}
		        
		// If the date is in the data array, add it to the marks array, else don't
		if ([data containsObject:[d description]]) {
			[marks addObject:[NSNumber numberWithBool:YES]];
		} else {
			[marks addObject:[NSNumber numberWithBool:NO]];
		}
		
		// Increment day using offset components (ie, 1 day in this instance)
		d = [cal dateByAddingComponents:offsetComponents toDate:d options:0];
	}
	
	return [NSArray arrayWithArray:marks];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
