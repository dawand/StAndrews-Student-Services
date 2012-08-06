//
//  ModulesTVC.m
//  Modules
//
//  Created by Dawand Sulaiman on 30/06/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "ModulesTVC.h"

@implementation ModulesTVC

@synthesize dateLabel, password,username, dateLabelStr;
@synthesize ModuleSemSeg;
@synthesize Modules, SelectedModuleCode,courseworkArray, FirstSemModules,SecondSemModules,AlertProgress,ModulesRequest,cachedItems;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)viewDidLoad
{   
   
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"MyPass" accessGroup:nil];
    
    password = [keychainItem objectForKey:(__bridge id) kSecValueData];
    username = [keychainItem objectForKey:(__bridge id)kSecAttrAccount];
    
    
    FirstSemModules = [NSMutableArray new];
    SecondSemModules = [NSMutableArray new];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    dateLabelStr = [defaults stringForKey:@"dateModulesUpdated"];
    [dateLabel setTitle:dateLabelStr];

    cachedItems = [ModulesCache getCachedMenuItems];
        
    if(cachedItems == nil){
        
        [self fetchFromServer];
    }
    
    else{
        
        self.Modules = cachedItems;
        [self splitToTwoSemesters:[self Modules]];
    }
    
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];

    [self.tableView reloadData];
    
    [super viewDidLoad];

}

- (void) fetchFromServer{
    
    AlertProgress = [[TKProgressAlertView alloc] initWithProgressTitle:@"Loading Your Modules..."];
    [AlertProgress show];
    
    ApplicationDelegate.engine = [[RESTEngine alloc] initWithLoginName:username password:password];
    ApplicationDelegate.engine.delegate = self;        
}

-(void) loginSucceeded
{
    [AlertProgress.progressBar setProgress:0.5];

    [ApplicationDelegate.engine fetchModuleItems];
     ApplicationDelegate.engine.delegate = self;  
    
  //  if(self.ModulesRequest)
  //      [self.ModulesRequest cancel];
}

-(void) loginFailedWithError:(NSError*) error
{
    [AlertProgress hide];
    
    TKAlertCenter *alert = [[TKAlertCenter alloc]init];
    [alert postAlertWithMessage:[error localizedDescription]];
}


-(void) moduleFetchSucceeded:(NSMutableArray*) menuItems
{    
    [AlertProgress hide];

//    NSLog([NSString stringWithFormat:@"%d", [menuItems count]]);
//    NSLog([NSString stringWithFormat:@"%d", [Modules count]]);
    
//    [self checkForChanges:menuItems];

    self.Modules = menuItems;
    
    if(FirstSemModules !=nil || SecondSemModules!=nil){
        [self.FirstSemModules removeAllObjects];
        [self.SecondSemModules removeAllObjects];
    }
    
    [self splitToTwoSemesters:[self Modules]];
    
    [AlertProgress.progressBar setProgress:0.8];
    
//    NSDate *currentDate = [NSDate date];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"EEEE dd-LLL-YYYY H:mm"];
//    dateLabelStr = [formatter stringFromDate:currentDate];
    
    CFGregorianDate currentDate = CFAbsoluteTimeGetGregorianDate(CFAbsoluteTimeGetCurrent(), CFTimeZoneCopySystem());

    dateLabelStr = [NSString stringWithFormat:@"%02d/%02d/%02d %02d:%02d", currentDate.day, currentDate.month,currentDate.year, currentDate.hour, currentDate.minute];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:dateLabelStr forKey:@"dateModulesUpdated"];
    [defaults synchronize];
    
    [dateLabel setTitle:dateLabelStr];
    
}

-(void) moduleFetchFailed:(NSError*) error
{
    [AlertProgress hide];

    TKAlertCenter *alert = [[TKAlertCenter alloc]init];
    [alert postAlertWithMessage:[error localizedDescription]];
}

- (void) checkForChanges:(NSMutableArray *) LatestModulesArray{
    
    if([self.Modules isEqualToArray:LatestModulesArray]){
        TKAlertCenter *alert = [[TKAlertCenter alloc]init];
        [alert postAlertWithMessage:[NSString stringWithFormat:@"There has been no changes in your modules since %@", dateLabelStr]];
    }
    
    else{
        TKAlertCenter *alert = [[TKAlertCenter alloc]init];
        [alert postAlertWithMessage:@"There has been changes in your modules data"];
    }

}

-(void) splitToTwoSemesters: (NSMutableArray *)allYearModules{
    
    for(int i=0;i<allYearModules.count;i++){
        
        modules *mod = [allYearModules objectAtIndex:i];
        
        if([mod.semester isEqualToString:@"S1"]){
            [FirstSemModules addObject:[Modules objectAtIndex:i]];
        }
        else if([mod.semester isEqualToString:@"S2"]){
            [SecondSemModules addObject:[Modules objectAtIndex:i]];
        }
    }
    
    [self.tableView reloadData];

}

-(void) viewDidAppear:(BOOL)animated{
    
    [self.navigationController setToolbarHidden:NO];
    [super viewDidAppear:animated];

}

- (void) viewDidDisappear:(BOOL)animated{
    
    [ModulesCache cacheMenuItems:self.Modules];
    
    if(self.ModulesRequest)
        [self.ModulesRequest cancel];
    
    [super viewDidDisappear:animated];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(ModuleSemSeg.selectedSegmentIndex==0){
    return [self.Modules count];
    }
    else if(ModuleSemSeg.selectedSegmentIndex==1){
        return [self.FirstSemModules count];
    }
    
    else if(ModuleSemSeg.selectedSegmentIndex==2){
        return [self.SecondSemModules count];        
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    modules *mod=[[modules alloc]init];
    
    if(ModuleSemSeg.selectedSegmentIndex==0){
        mod = [self.Modules objectAtIndex:[indexPath row]];
    }
    
    else if(ModuleSemSeg.selectedSegmentIndex==1){
        mod = [self.FirstSemModules objectAtIndex:[indexPath row]];
    }
    
    else if(ModuleSemSeg.selectedSegmentIndex==2){
        mod = [self.SecondSemModules objectAtIndex:[indexPath row]];
        
    }
    
    static NSString *CellIdentifier = @"ModuleCell";
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
     

    TDBadgedCell *cell = [[TDBadgedCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];

    UIView* bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    bgview.opaque = YES;
    
    [cell setHighlighted:YES];
    
    bgview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    [cell setBackgroundView:bgview];
    
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:20];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@",mod.module_code]];
    
    cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:18];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
 //   cell.detailTextLabel.numberOfLines = 2;
 //   cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%@",mod.title]];
    
    coursework *cw = [[coursework alloc]init];
    cw = [mod.courseworkArray objectAtIndex:0];
    
    cell.badgeString = [NSString stringWithFormat:@"%d",[cw.assignmentsArray count]];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    modules *mod=[[modules alloc]init];

    if(ModuleSemSeg.selectedSegmentIndex==0){
        mod = [self.Modules objectAtIndex:[indexPath row]];
    }
    
    else if(ModuleSemSeg.selectedSegmentIndex==1){
        mod = [self.FirstSemModules objectAtIndex:[indexPath row]];
    }
    
    else if(ModuleSemSeg.selectedSegmentIndex==2){
        mod = [self.SecondSemModules objectAtIndex:[indexPath row]];
        
    }
    
    courseworkArray = mod.courseworkArray;
    SelectedModuleCode = mod.module_code;
    
    AssignmentsTVC *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AssignmentsTVC"];
    
    detailViewController.courseworkArray = self.courseworkArray;
    detailViewController.ModuleTitle = SelectedModuleCode;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (IBAction)ModuleSegChoiceTapped:(id)sender {
    
    [self.tableView reloadData];
}

- (IBAction)RefreshBtnTapped:(id)sender {

    [self fetchFromServer];
}

- (void)viewDidUnload {
    [self setDateLabel:nil];
    [super viewDidUnload];
}

-(void) dealloc{
    
    ApplicationDelegate.engine = nil;;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
