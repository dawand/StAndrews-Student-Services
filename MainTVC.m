//
//  MainTVC.m
//  Student App
//
//  Created by Dawand Sulaiman on 25/06/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "MainTVC.h"

@implementation MainTVC

@synthesize sectionsAndRowsText, ModulesRequest, sectionsAndRowsDetailsText;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *firstSection = [NSArray arrayWithObjects:@"Assignments", @"Grades", @"Timetable", nil];
    NSArray *secondSection = [NSArray arrayWithObjects:@"University", @"Library", @"School", nil];
	
    sectionsAndRowsText = [[NSMutableArray alloc] initWithObjects:firstSection, secondSection, nil];
    
    NSArray *firstsectiondetails = [NSArray arrayWithObjects:@"View your List of assignments as shown on MMS", @"Show all your grades & overall module average grade", @"Show your personal timetable including your chosen modules", nil];
    NSArray *secondsectiondetails = [NSArray arrayWithObjects:@"Show Latest University News and Events ", @"Show Latest Library News and New Arrivals ", @"Currently only available for Computer Science Students", nil];
    
    sectionsAndRowsDetailsText = [[NSMutableArray alloc]initWithObjects:firstsectiondetails,secondsectiondetails, nil];
    
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    
    [self.tableView reloadData];
    
}

-(void) viewDidAppear:(BOOL)animated{
    
    UINavigationController * navigationController = [self navigationController];
    UINavigationBar * nb = [navigationController navigationBar];
    
    if ([[nb class]respondsToSelector:@selector(appearance)]) {
        [[[nb class] appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
    UIToolbar * tb = [navigationController toolbar];
    
    if ([[tb class]respondsToSelector:@selector(appearance)]) {
        [[[tb class]appearance] setBackgroundImage:[UIImage imageNamed:@"toolbar.png"]  forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
    }
    
    [self.navigationController setToolbarHidden:YES];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //if the user is not logged in - show login modal
    if(![defaults boolForKey:@"loggedin"] && ![defaults boolForKey:@"guestlogin"]){
        LoginVC *login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
        [self presentModalViewController:login animated:NO];
    }   
    
    [self.tableView reloadData];

    [super viewDidAppear:animated];
}

- (void) viewDidDisappear:(BOOL)animated{
    
    if(self.ModulesRequest)
        [self.ModulesRequest cancel];
    
    [super viewDidDisappear:animated];
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
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sections = [[self sectionsAndRowsText] count];
	
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionContents = [[self sectionsAndRowsText] objectAtIndex:section];
    NSInteger rows = [sectionContents count];
	
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *contentForThisRow = [[[self sectionsAndRowsText] objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    
    NSString *detailsForThisRow = [[[self sectionsAndRowsDetailsText] objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    
    static NSString *CellIdentifier = @"MainCell";
    
  //  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  //  if (cell == nil) {
      //  cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    TDBadgedCell *cell = [[TDBadgedCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];

   // }
    
    //guest login
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if([defaults boolForKey:@"guestlogin"] && indexPath.section==0){
        cell.badgeString = @"Login Required";
        cell.badgeColor = [UIColor colorWithRed:0.792 green:0.197 blue:0.219 alpha:1.000];
       // cell.badge.radius = 15;
    }
    
    UIView* bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    bgview.opaque = YES;
    
    [cell setHighlighted:YES];
    
    bgview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    [cell setBackgroundView:bgview];
    
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:24];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    [[cell textLabel]setText:contentForThisRow];
    
    
    cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:14];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.numberOfLines = 2;
    cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    
    [[cell detailTextLabel]setText:detailsForThisRow];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:36];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:22];
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@2X.png",contentForThisRow]];
        
    }
    else{
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",contentForThisRow]];
    }
    
    return cell;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 50)];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        [headerView setFrame:CGRectMake(0, 0, tableView.bounds.size.width, 100)];
    }
    
    if (section == 0 || section == 1){
        [headerView setBackgroundColor:[UIColor darkGrayColor]];
        
        UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,300,44)];
        tempLabel.backgroundColor=[UIColor clearColor]; 
        tempLabel.shadowColor = [UIColor blackColor];
        tempLabel.shadowOffset = CGSizeMake(0,2);
        tempLabel.textColor = [UIColor whiteColor];
        tempLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
        //   tempLabel.font = [UIFont boldSystemFontOfSize:20];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            tempLabel.font = [UIFont fontWithName:@"Helvetica" size:26];
            
        }
        if(section==0)
            tempLabel.text=@"Modules and Timetable";
        
        else if(section ==1)
            tempLabel.text=@"News and Events";
        
        [headerView addSubview:tempLabel];
    }
    
    else{ 
        [headerView setBackgroundColor:[UIColor clearColor]];
    }
    
    return headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(section == 0)
        return @"Modules & Timetable";
    else if (section == 1)
        return @"News & Events";
    else
        return @"No heading";
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //modules and timetable
    if(indexPath.section == 0 && indexPath.row == 0){
        ModulesTVC *modules = [self.storyboard instantiateViewControllerWithIdentifier:@"ModulesTVC"];
        [self.navigationController pushViewController:modules animated:YES];
    }
    
    else if(indexPath.section == 0 && indexPath.row == 2){
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            
           UIStoryboard *iPadStoryboard = [UIStoryboard storyboardWithName:@"iPadStoryboard" bundle:nil];
            TimetableListiPadTVC *ListTVC = [iPadStoryboard instantiateViewControllerWithIdentifier:@"TimetableListiPadTVC"];
            [self.navigationController pushViewController:ListTVC animated:YES];
        }
        else{
        TimetableTVC  *timetable = [self.storyboard instantiateViewControllerWithIdentifier:@"TimetableTVC"];
        
        [self.navigationController pushViewController:timetable animated:YES];
        }
              
    }
    
    else if(indexPath.section == 0 && indexPath.row == 1){
        
        GradesVC *grades = [self.storyboard instantiateViewControllerWithIdentifier:@"GradesVC"];
        [self.navigationController pushViewController:grades animated:YES];
    }
    
    // events and news
    else if(indexPath.section == 1 && indexPath.row == 0){
        
        UniRSSLoaderTVC  *unirssloader = [self.storyboard instantiateViewControllerWithIdentifier:@"UnirssloaderTVC"];
        
        [self.navigationController pushViewController:unirssloader animated:YES];
    }
    
    else if(indexPath.section == 1 && indexPath.row == 1){
        
        LibraryVC *lib = [self.storyboard instantiateViewControllerWithIdentifier:@"LibraryVC"];
        
        [self.navigationController pushViewController:lib animated:YES];
    }
    
    else if(indexPath.section == 1 && indexPath.row == 2){
        
        RSSLoaderTVC  *rssloader = [self.storyboard instantiateViewControllerWithIdentifier:@"rssloaderTVC"];
        
        [self.navigationController pushViewController:rssloader animated:YES];
        
    }
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)path
{
    // Determine if row is selectable based on the NSIndexPath.
    BOOL rowIsSelectable=TRUE;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if([defaults boolForKey:@"guestlogin"] && path.section==0){
        
        rowIsSelectable = FALSE;
    }
    
    if (rowIsSelectable)
    {
        return path;
    }
    
    return nil;
}

- (IBAction)SettingsBtnTapped:(id)sender {
    
    SettingsTVC *setting = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsTVC"];
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:setting];
    [self.navigationController presentModalViewController:navController animated:YES];
    
}

@end
