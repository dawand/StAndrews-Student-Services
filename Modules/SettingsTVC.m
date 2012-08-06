//
//  SettingsTVC.m
//  Modules
//
//  Created by Dawand Sulaiman on 04/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "SettingsTVC.h"

@implementation SettingsTVC
@synthesize settings,usernameChecked;

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
    usernameChecked=TRUE;
    
    // [self.navigationController setNavigationBarHidden:NO];
    
    NSArray *firstSection = [NSArray arrayWithObjects:@"User", @"Autofill Username", nil];
    
    NSArray *secondSection = [NSArray arrayWithObjects:@"Notifications", nil];
    
    NSArray *thirdSection = [NSArray arrayWithObjects:@"Logout",nil];
    
    settings = [[NSMutableArray alloc] initWithObjects:firstSection,secondSection,thirdSection, nil];
    
    [self.tableView reloadData];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)viewDidAppear:(BOOL)animated{
    
    self.navigationItem.hidesBackButton = YES;
    
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sections = [[self settings] count];
	
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionContents = [[self settings] objectAtIndex:section];
    NSInteger rows = [sectionContents count];
	
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *sectionContents = [[self settings] objectAtIndex:[indexPath section]];
    NSString *contentForThisRow = [sectionContents objectAtIndex:[indexPath row]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    static NSString *CellIdentifier = @"SettingsCell";
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }

    TDBadgedCell *cell = [[TDBadgedCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];

    [[cell textLabel]setText:contentForThisRow];
    
    if([indexPath section]==0 && [indexPath row]==0){
     //  UITableViewCell  *cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cellType"];

        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:16];
        cell.textLabel.textColor = [UIColor blackColor];
        
        KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"MyPass" accessGroup:nil];
        
        [[cell textLabel]setText:contentForThisRow];
        cell.detailTextLabel.text =[NSString stringWithFormat:@"%@@st-andrews.ac.uk", [keychainItem objectForKey:(__bridge id)kSecAttrAccount]];
        
        //set user label to guest
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        if([defaults boolForKey:@"guestlogin"]){
        cell.detailTextLabel.text = @"Guest";
        }
    }
    
    if([indexPath section]==0 && [indexPath row]==1){
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UISwitch *usernameswitchview = [[UISwitch alloc] initWithFrame:CGRectZero];
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:16];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.accessoryView = usernameswitchview;
        
        if([defaults boolForKey:@"guestlogin"]){
            cell.badgeString = @"Login Required";
            cell.badgeColor = [UIColor colorWithRed:0.792 green:0.197 blue:0.219 alpha:1.000];
        }
        
        if([defaults boolForKey:@"rememberusername"]){
            usernameswitchview.on=YES;
            usernameChecked=TRUE;
        }else{
            usernameswitchview.on=NO;
        }
        
        [usernameswitchview addTarget:self action:@selector(usernameswitchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    //    if([indexPath section]==0 && [indexPath row]==1){
    //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //
    //        UISwitch *passwordswitchview = [[UISwitch alloc] initWithFrame:CGRectZero];
    //        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:16];
    //        cell.accessoryView = passwordswitchview;
    //        
    //        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //
    //        if([defaults boolForKey:@"rememberpassword"]){
    //            passwordswitchview.on=YES;
    //            password=TRUE;
    //        }else{
    //            passwordswitchview.on=NO;
    //        }
    
    //        [passwordswitchview addTarget:self action:@selector(passwordswitchChanged:) forControlEvents:UIControlEventValueChanged];
    //    }
    
    if([indexPath section]==1 && [indexPath row]==0){
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        if([defaults boolForKey:@"guestlogin"]){
            cell.badgeString = @"Login Required";
            cell.badgeColor = [UIColor colorWithRed:0.792 green:0.197 blue:0.219 alpha:1.000];

        }
        
    }
    
    //logout button
    if([indexPath section]==2 && [indexPath row]==0){
        [cell setBackgroundColor:[UIColor redColor]];
        cell.textLabel.font = [UIFont fontWithName:@"New Times Roman" size:18];
        [cell.textLabel setTextAlignment:UITextAlignmentCenter];

        if([defaults boolForKey:@"guestlogin"]){
            cell.textLabel.text = @"Logout Guest";
        }

    }
    
    return cell;
}

- (void) usernameswitchChanged:(id)sender {
    UISwitch* switchControl = sender;
    if(switchControl.on)
        usernameChecked=YES;
    else
        usernameChecked=NO;
}

- (void)updateSwitchAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UISwitch *switchView = (UISwitch *)cell.accessoryView;
    
    //if set to off
    if ([switchView isOn]) {
        [switchView setOn:NO animated:YES];
    }
    
    else {
        [switchView setOn:YES animated:YES];
    }
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"MyPass" accessGroup:nil];
    
    if(indexPath.section == 1 && indexPath.row == 0){
        
        NotificationsTVC *notification = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationTVC"];
        
        [self.navigationController pushViewController:notification animated:YES];
    }
    
    else if(indexPath.section == 2 && indexPath.row == 0){
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:NO forKey:@"loggedin"];
        [defaults setBool:NO forKey:@"guestlogin"];

   //     [ApplicationDelegate setUsername:@""];
   //     [ApplicationDelegate setPassword:@""];
        
        // remove cached data
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        [fileManager removeItemAtPath:cachePath error:nil];

        //clear memory of cached data
        [TimetableCache clearCache];
        [ModulesCache clearCache];
        
        if(!usernameChecked){
            [defaults setBool:NO forKey:@"rememberusername"];
        }
        
        [defaults synchronize];
        
        //clear keychain
        [keychainItem resetKeychainItem];
        
        [self setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        //dismiss the modal view controller
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)path
{
    BOOL rowIsSelectable=TRUE;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if([defaults boolForKey:@"guestlogin"] && path.section==0 && path.row==1){
        rowIsSelectable = FALSE;
    }
    
    if([defaults boolForKey:@"guestlogin"] && path.section==1 && path.row==0){
        rowIsSelectable = FALSE;
    }
    
    if (rowIsSelectable)
    {
        return path;
    }
    
    return nil;
}

- (IBAction)saveBtnTapped:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if(!usernameChecked){
        [defaults setBool:NO forKey:@"rememberusername"];
    }
    
    [defaults synchronize];
    
    [self dismissModalViewControllerAnimated:YES];
    
}

@end
