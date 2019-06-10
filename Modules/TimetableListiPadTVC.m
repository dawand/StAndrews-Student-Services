
#import "TimetableListiPadTVC.h"

@interface TimetableListiPadTVC ()

@end

@implementation TimetableListiPadTVC

@synthesize data,startDateData,username,password,AlertProgress,cachedItems,dateLabel,dateLabelStr,sortedTimetableList;

- (void)viewDidLoad
{
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"MyPass" accessGroup:nil];
    
    password = [keychainItem objectForKey:(__bridge id) kSecValueData];
    username = [keychainItem objectForKey:(__bridge id)kSecAttrAccount];
    
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
    
    sortedTimetableList = [NSArray new];
    
    sortedTimetableList = [data sortedArrayUsingComparator:^(id a, id b) {
        
        NSDate *first = [(TimetableModule*)a StartDate ];
        NSDate *second = [(TimetableModule*)b StartDate];
        return [first compare:second];
    }];
    
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];

    self.tableView.dataSource = self;
    
    [self.tableView reloadData];
    
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
    [AlertProgress.progressBar setProgress:0.8];
    
    [ApplicationDelegate.CalendarEngine fetchTimetableItems];
    ApplicationDelegate.CalendarEngine.delegate = self;
    
}

- (void) loginFailedWithError:(NSError*) error
{
    [AlertProgress hide];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                    message:[error localizedRecoverySuggestion]
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"Dismiss", @"")
                                          otherButtonTitles: nil];
    
    [alert show];
}

-(void) viewDidAppear:(BOOL)animated{
    
    [self.navigationController setToolbarHidden:NO];
    [super viewDidAppear:animated];
    
}

- (void) viewDidDisappear:(BOOL)animated{
    
    NSMutableArray *bothArraysToCache = [[NSMutableArray alloc]init];
    [bothArraysToCache addObject:self.data];
    [bothArraysToCache addObject:self.startDateData];
    
    [TimetableCache cacheItems:bothArraysToCache];
    
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
    
    [self.tableView reloadData];
}

-(void) menuFetchFailed:(NSError*) error
{
    [AlertProgress hide];
    
    TKAlertCenter *alert = [[TKAlertCenter alloc]init];
    [alert postAlertWithMessage:[error localizedDescription]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [sortedTimetableList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TimetableListCell";
    //  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    TDBadgedCell *cell = [[TDBadgedCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    UIView* bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    bgview.opaque = YES;
    
    [cell setHighlighted:YES];
    
    bgview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    [cell setBackgroundView:bgview];
    
    TimetableModule *tm = [[TimetableModule alloc]init];
    tm = [self.sortedTimetableList objectAtIndex:[indexPath row]];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"EEEE dd-LLL-YYYY"];
    NSString *startdateStr = [dateFormat stringFromDate:tm.StartDate]; 
    cell.textLabel.font = [UIFont systemFontOfSize:24];
    cell.textLabel.textColor = [UIColor whiteColor];    
    cell.textLabel.text =startdateStr ;
    
    [dateFormat setDateFormat:@"HH:mm"];
    NSString *startHour = [dateFormat stringFromDate:tm.StartDate]; 
    cell.badgeString = startHour;
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:20];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.numberOfLines=2;
    cell.detailTextLabel.text =[NSString stringWithFormat:@"%@\n%@",tm.ModuleTitle, tm.ModuleCode];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

-(void) tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TimetableModule *t = [sortedTimetableList objectAtIndex:indexPath.row];
    
    TimetableModuleDetailsVC *details = [self.storyboard instantiateViewControllerWithIdentifier:@"TimetableModuleDetailsVC"];
    
    details.tm = t;
    
    [self.navigationController pushViewController:details animated:YES];
}

- (IBAction)RefreshBtnTapped:(id)sender {
    
    [self fetchFromServer];
}

@end
