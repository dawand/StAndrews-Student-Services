
#import "TimetableListTVC.h"

@interface TimetableListTVC ()

@end

@implementation TimetableListTVC

@synthesize Timetabledata,StartDateData,sortedTimetableList;

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
    sortedTimetableList = [NSArray new];
    
    sortedTimetableList = [Timetabledata sortedArrayUsingComparator:^(id a, id b) {
        
        NSDate *first = [(TimetableModule*)a StartDate ];
        NSDate *second = [(TimetableModule*)b StartDate];
        return [first compare:second];
    }];
    
    //  sortedTimetableList = [[sortedTimetableList reverseObjectEnumerator] allObjects];
    
    [super viewDidLoad];
}


- (void) viewDidAppear:(BOOL)animated{
    
    [self.navigationItem.backBarButtonItem setTitle:@"Month View"];
    [self.navigationController setToolbarHidden:YES];
    [super viewDidAppear:animated];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
 //   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    TDBadgedCell *cell = [[TDBadgedCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
     
    UIView* bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    bgview.opaque = YES;
    
    [cell setHighlighted:YES];
    
    bgview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    [cell setBackgroundView:bgview];
    
    TimetableModule *tm = [[TimetableModule alloc]init];
    tm = [self.sortedTimetableList objectAtIndex:[indexPath row]];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    // Convert date object to desired output format
    [dateFormat setDateFormat:@"EEEE dd-LLL-YYYY"];
    NSString *startdateStr = [dateFormat stringFromDate:tm.StartDate]; 
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.textLabel.text =startdateStr ;
    
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    cell.detailTextLabel.numberOfLines=2;
    cell.detailTextLabel.text =[NSString stringWithFormat:@"%@\n%@",tm.ModuleTitle, tm.ModuleCode];
    
    [dateFormat setDateFormat:@"HH:mm"];
    NSString *startHour = [dateFormat stringFromDate:tm.StartDate]; 
    cell.badgeString = startHour;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void) tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TimetableModule *t = [sortedTimetableList objectAtIndex:indexPath.row];
    
    TimetableModuleDetailsVC *details = [self.storyboard instantiateViewControllerWithIdentifier:@"TimetableModuleDetailsVC"];
    
    details.tm = t;
    //   details.selectedDate = self.selectedDate;
    
    [self.navigationController pushViewController:details animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
