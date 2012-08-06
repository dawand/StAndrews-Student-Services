//
//  ThirdTimetableTVC.m
//  Modules
//
//  Created by Dawand Sulaiman on 09/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "TimetableTVC.h"

@implementation TimetableTVC

@synthesize dataArray,dataDictionary,data,StartDateData,ModulesRequest,dataSelected,titleDictionary,AlertProgress,cachedItems;

- (void) viewDidLoad{
    
    data = [[NSMutableArray alloc]init];
    StartDateData = [[NSMutableArray alloc]init];
    
 //   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  //  NSString *username = [defaults stringForKey:@"username"];
  //  NSString *password = [defaults stringForKey:@"password"];
    
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"MyPass" accessGroup:nil];
    
    NSString *password = [keychainItem objectForKey:(__bridge id) kSecValueData];
    NSString *username = [keychainItem objectForKey:(__bridge id)kSecAttrAccount];
    
    AlertProgress = [[TKProgressAlertView alloc] initWithProgressTitle:@"Loading Timetable Data ..."];
    
    cachedItems = [TimetableCache getCachedItems];

    if(cachedItems == nil){
        
        [self fetchFromServer:username :password];
    }
    
    else{
        self.data = [cachedItems objectAtIndex:0];
        self.StartDateData = [cachedItems objectAtIndex:1];        
    }
    
    if([TimetableCache isItemsStale]){
        
        [self fetchFromServer:username :password];    
    }

	[super viewDidLoad];
	[self.monthView selectDate:[NSDate month]];

}
//- (void) viewDidAppear:(BOOL)animated{
//	[super viewDidAppear:animated];
//	
//    
//    //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; 
//    //[dateFormatter setDateFormat:@"dd.MM.yy"]; 
//    //NSDate *d = [dateFormatter dateFromString:@"02.05.11"]; 
//    //[dateFormatter release];
//    //[self.monthView selectDate:d];
//	
//}

- (void) fetchFromServer: (NSString *) username :(NSString *) password {

    [AlertProgress show];
    
    ApplicationDelegate.CalendarEngine = [[iCalendarEngine alloc] initWithLoginName:username password:password];
    ApplicationDelegate.CalendarEngine.delegate = self;
    
    [ApplicationDelegate.CalendarEngine fetchTimetableItems];
    ApplicationDelegate.CalendarEngine.delegate = self;
    
    //after login is successful
    [AlertProgress.progressBar setProgress:0.5];
}

-(void) loginSucceeded:(NSString*) accessToken
{
    // note that the engine automatically remembers access tokens
    NSLog(@"Login is successful and this is the access token %@", accessToken);
    
    [AlertProgress.progressBar setProgress:0.3];

    if(self.ModulesRequest)
        [self.ModulesRequest cancel];
    
}

-(void) loginFailedWithError:(NSError*) error
{
    [AlertProgress hide];

    NSLog(@"Login failed. Check your password. Error is :%@", [error localizedDescription]);   
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                    message:[error localizedRecoverySuggestion]
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"Dismiss", @"")
                                          otherButtonTitles: nil];
    [alert show];
}

- (void) viewDidDisappear:(BOOL)animated{
    
    NSLog(@"%@", [data objectAtIndex:0]);

    NSMutableArray *bothArraysToCache = [[NSMutableArray alloc]init];
    [bothArraysToCache addObject:self.data];
    [bothArraysToCache addObject:self.StartDateData];
    
    [TimetableCache cacheItems:bothArraysToCache];
    
    if(self.ModulesRequest)
        [self.ModulesRequest cancel];
    
    [super viewDidDisappear:animated];
}

-(void) menuFetchSucceeded:(NSMutableArray *) calendarItems
{
    self.StartDateData = [calendarItems objectAtIndex:0];
    self.data = [calendarItems objectAtIndex:1];
    
    [AlertProgress.progressBar setProgress:1.0];
    [AlertProgress hide];
}

-(void) menuFetchFailed:(NSError*) error
{
    [AlertProgress hide];

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                    message:[error localizedRecoverySuggestion]
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"Dismiss", @"")
                                          otherButtonTitles: nil];
    [alert show];
}


- (NSArray*) calendarMonthView:(TKCalendarMonthView*)monthView marksFromDate:(NSDate*)startDate toDate:(NSDate*)lastDate{
    
	[self generateRandomDataForStartDate:startDate endDate:lastDate];
	return dataArray;
}

- (void) calendarMonthView:(TKCalendarMonthView*)monthView didSelectDate:(NSDate*)date{
	
	// CHANGE THE DATE TO YOUR TIMEZONE
	TKDateInformation info = [date dateInformationWithTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	NSDate *myTimeZoneDay = [NSDate dateFromDateInformation:info timeZone:[NSTimeZone systemTimeZone]];
	
//	NSLog(@"Date Selected: %@",myTimeZoneDay);
	
	[self.tableView reloadData];
}

- (void) calendarMonthView:(TKCalendarMonthView*)mv monthDidChange:(NSDate*)d animated:(BOOL)animated{
    
	[super calendarMonthView:mv monthDidChange:d animated:animated];
	[self.tableView reloadData];
    
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
	
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {	
	NSArray *ar = [dataDictionary objectForKey:[self.monthView dateSelected]];
	if(ar == nil) return 0;
	return [ar count];
}

- (UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
	NSArray *ar = [dataDictionary objectForKey:[self.monthView dateSelected]];
    NSArray *artitle = [titleDictionary objectForKey:[self.monthView dateSelected]];

	cell.textLabel.text = [ar objectAtIndex:indexPath.row];
	cell.detailTextLabel.text = [artitle objectAtIndex:indexPath.row];
    
    return cell;
	
}

- (void) generateRandomDataForStartDate:(NSDate*)start endDate:(NSDate*)end{
	// this function sets up dataArray & dataDictionary
	// dataArray: has boolean markers for each day to pass to the calendar view (via the delegate function)
	// dataDictionary: has items that are associated with date keys (for tableview)
	
	//NSLog(@"Delegate Range: %@ %@ %d",start,end,[start daysBetweenDate:end]);
    
	self.dataArray = [NSMutableArray array];
	self.dataDictionary = [NSMutableDictionary dictionary];
    self.dataSelected = [NSMutableDictionary dictionary];
    self.titleDictionary = [NSMutableDictionary dictionary];
    
 //   NSMutableArray *DuplicateStartDates = [[NSMutableArray alloc]init];
    
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];

    NSDateComponents* components = [calendar components:flags fromDate:start];

    NSDate* dateOnly = [calendar dateFromComponents:components];

    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    
	while(YES){
		
		if([StartDateData containsObject:dateOnly])
        {
            int index = [StartDateData indexOfObject:dateOnly];
         //   NSLog(@"module %@ , %d", , index);
            
            TimetableModule *tm = [[TimetableModule alloc]init];
            tm = [data objectAtIndex:index];
             
			[self.dataDictionary setObject:[NSArray arrayWithObjects:tm.ModuleCode, nil] forKey:dateOnly];
            [self.titleDictionary setObject:[NSArray arrayWithObjects:tm.ModuleTitle, nil] forKey:dateOnly];

            [self.dataSelected setObject:[NSArray arrayWithObjects:tm,nil] forKey:dateOnly];

            [self.dataArray addObject:[NSNumber numberWithBool:YES]];
            
		}
        else
			[self.dataArray addObject:[NSNumber numberWithBool:NO]];
		
		TKDateInformation info = [dateOnly dateInformationWithTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
		info.day++;
		dateOnly = [NSDate dateFromDateInformation:info timeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
		
        if([dateOnly compare:end]==NSOrderedDescending) 
            break;
	}
}


- (void) tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

	NSArray *ar = [dataSelected objectForKey:[self.monthView dateSelected]];
    
    TimetableModuleDetailsVC *details = [self.storyboard instantiateViewControllerWithIdentifier:@"TimetableModuleDetailsVC"];
    
    details.tm = [ar objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:details animated:YES];

}

- (IBAction)RefreshBtnTapped:(id)sender {
    
    //    UIActivityIndicatorView* activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //    [activity startAnimating];
    //    [self.navigationItem setRightBarButtonItem:activity];
    
    [TimetableCache clearCache];
    [self viewDidLoad];
}


@end
