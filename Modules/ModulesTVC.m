//
//  ModulesTVC.m
//  Modules
//
//  Created by Dawand Sulaiman on 30/06/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "ModulesTVC.h"

@implementation ModulesTVC
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

    NSString *password = [keychainItem objectForKey:(__bridge id) kSecValueData];
    NSString *username = [keychainItem objectForKey:(__bridge id)kSecAttrAccount];
    
    FirstSemModules = [NSMutableArray new];
    SecondSemModules = [NSMutableArray new];
    
    AlertProgress = [[TKProgressAlertView alloc] initWithProgressTitle:@"Loading Your Modules..."];
    [AlertProgress.progressBar setProgress:0.1];

    cachedItems = [ModulesCache getCachedMenuItems];
        
    if(cachedItems == nil){
        
        [self fetchFromServer:username :password];
    }
    
    else{
        self.Modules = cachedItems;
        [self splitToTwoSemesters:[self Modules]];
    }
    
    if([ModulesCache isMenuItemsStale]){
        
        [self fetchFromServer:username :password];    
    }
    
    [self.tableView reloadData];
    
    [super viewDidLoad];

}

- (void) fetchFromServer: (NSString *) username :(NSString *) password{
    
    [AlertProgress show];
    
    ApplicationDelegate.engine = [[RESTEngine alloc] initWithLoginName:username password:password];
    ApplicationDelegate.engine.delegate = self;
    
    [ApplicationDelegate.engine fetchMenuItems];
    ApplicationDelegate.engine.delegate = self;   

//    ApplicationDelegate.engine = [[RESTEngine alloc]init];
//    [ApplicationDelegate.engine LoginAndFetchModules:username password:password];
//    ApplicationDelegate.engine.delegate = self; 
}

-(void) loginSucceeded:(NSString*) accessToken
{
    // note that the engine automatically remembers access tokens
    NSLog(@"Login is successful and this is the access token %@", accessToken);
    
    dispatch_async(dispatch_get_main_queue(), ^{
    [AlertProgress.progressBar setProgress:0.3];
    });
    
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


-(void) menuFetchSucceeded:(NSMutableArray*) menuItems
{
    self.Modules = menuItems;
    
    [self splitToTwoSemesters:[self Modules]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
    [AlertProgress.progressBar setProgress:0.8];
    });
    
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
        
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@",mod.module_code]]; 
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%@",mod.title]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    modules *mod=[[modules alloc]init];

    // Navigation logic may go here. Create and push another view controller.
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

//- (void)viewDidUnload
//{
//    [self setModuleSemSeg:nil];
//    [super viewDidUnload];
//    // Release any retained subviews of the main view.
//    // e.g. self.myOutlet = nil;
//}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}

- (IBAction)ModuleSegChoiceTapped:(id)sender {
    
    [self.tableView reloadData];
    
}

- (IBAction)RefreshBtnTapped:(id)sender {

    
    [ModulesCache clearCache];
    [self viewDidLoad];
}

@end
