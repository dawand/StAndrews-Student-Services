//
//  ThirdTimetableTVC.m
//  Modules
//
//  Created by Dawand Sulaiman on 09/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "TimetableTVC.h"

@implementation TimetableTVC
@synthesize SegmentedControlOutlet;

@synthesize dataArray,dataDictionary,data,startDateData,ModulesRequest,dataSelected,titleDictionary,AlertProgress,cachedItems,dateLabelStr,dateLabel,username,password,selectedDate;

- (void) viewDidLoad{
    
 //   username = ApplicationDelegate.username;
 //   password = ApplicationDelegate.password;
   
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"MyPass" accessGroup:nil];
    
       password = [keychainItem objectForKey:(__bridge id) kSecValueData];
       username = [keychainItem objectForKey:(__bridge id)kSecAttrAccount];
    
    NSLog(username);
    NSLog(password);
    
    data = [[NSMutableArray alloc]init];
    startDateData = [[NSMutableArray alloc]init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    dateLabelStr = [defaults stringForKey:@"dateTimetableUpdated"];
    [dateLabel setTitle:dateLabelStr];
    
    cachedItems = [TimetableCache getCachedItems];

    if(cachedItems == nil){
        
        [self fetchFromServer];
    }
    
    else{
        self.data = [cachedItems objectAtIndex:0];
        self.StartDateData = [cachedItems objectAtIndex:1];        
    }

	[self.monthView selectDate:[NSDate month]];

    [super viewDidLoad];

}

- (void) fetchFromServer {

    AlertProgress = [[TKProgressAlertView alloc] initWithProgressTitle:@"Loading Timetable Data ..."];
    [AlertProgress show];
    
    ApplicationDelegate.CalendarEngine = [[iCalendarEngine alloc] initWithLoginName:username password:password];
    ApplicationDelegate.CalendarEngine.delegate = self;
    
}

- (void) loginSucceeded
{
    // note that the engine automatically remembers access tokens
    
    [AlertProgress.progressBar setProgress:0.8];

    [ApplicationDelegate.CalendarEngine fetchTimetableItems];
    ApplicationDelegate.CalendarEngine.delegate = self;
    
}

- (void) loginFailedWithError:(NSError*) error
{
    [AlertProgress hide];

    TKAlertCenter *alert = [[TKAlertCenter alloc]init];
    [alert postAlertWithMessage:[error localizedDescription]];
}

-(void) viewDidAppear:(BOOL)animated{
    
    [SegmentedControlOutlet setSelectedSegmentIndex:0];
    [self.navigationController setToolbarHidden:NO];
    [super viewDidAppear:animated];
    
}

- (void) viewDidDisappear:(BOOL)animated{
    
    NSMutableArray *bothArraysToCache = [[NSMutableArray alloc]init];
    [bothArraysToCache addObject:self.data];
    [bothArraysToCache addObject:self.startDateData];
    
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
    
    CFGregorianDate currentDate = CFAbsoluteTimeGetGregorianDate(CFAbsoluteTimeGetCurrent(), CFTimeZoneCopySystem());
    
    dateLabelStr = [NSString stringWithFormat:@"%02d/%02d/%02d %02d:%02d", currentDate.day, currentDate.month,currentDate.year, currentDate.hour, currentDate.minute];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:dateLabelStr forKey:@"dateTimetableUpdated"];
    [defaults synchronize];
    
    [dateLabel setTitle:dateLabelStr];
}

-(void) menuFetchFailed:(NSError*) error
{
    [AlertProgress hide];

    TKAlertCenter *alert = [[TKAlertCenter alloc]init];
    [alert postAlertWithMessage:[error localizedDescription]];
}


- (NSArray*) calendarMonthView:(TKCalendarMonthView*)monthView marksFromDate:(NSDate*)startDate toDate:(NSDate*)lastDate{
    
	[self generateDataForStartDate:startDate endDate:lastDate];
	return dataArray;
}

- (void) calendarMonthView:(TKCalendarMonthView*)monthView didSelectDate:(NSDate*)date{
	
	// CHANGE THE DATE TO YOUR TIMEZONE
	TKDateInformation info = [date dateInformationWithTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	selectedDate = [NSDate dateFromDateInformation:info timeZone:[NSTimeZone systemTimeZone]];
	
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
    
    if(SegmentedControlOutlet.selectedSegmentIndex==0){

	NSArray *ar = [dataDictionary objectForKey:[self.monthView dateSelected]];
    NSArray *artitle = [titleDictionary objectForKey:[self.monthView dateSelected]];

	cell.textLabel.text = [ar objectAtIndex:indexPath.row];
	cell.detailTextLabel.text = [artitle objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (void) generateDataForStartDate:(NSDate*)start endDate:(NSDate*)end{
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
    
	while(YES){
		
		if([startDateData containsObject:dateOnly])
        {
            int index = [startDateData indexOfObject:dateOnly];
            
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

- (IBAction)SegmentedControlTapped:(id)sender {
    
    if(SegmentedControlOutlet.selectedSegmentIndex==1){
    TimetableListTVC *list = [self.storyboard instantiateViewControllerWithIdentifier:@"TimetableListTVC"];
    
        [list setTimetabledata:[self.data copy]];
        [list setStartDateData:[self.startDateData copy]];
        
        [self.navigationController pushViewController:list animated:YES];
    }

}

- (IBAction)RefreshBtnTapped:(id)sender {
    
    [self fetchFromServer];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationPortrait;
}


- (void)viewDidUnload {
    [self setSegmentedControlOutlet:nil];
    [super viewDidUnload];
}

@end
