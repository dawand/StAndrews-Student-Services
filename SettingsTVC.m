//
//  SettingsTVC.m
//  Modules
//
//  Created by Dawand Sulaiman on 04/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "SettingsTVC.h"

@implementation SettingsTVC
@synthesize settings,username,password;

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

    username=TRUE;
    password=TRUE;
    
   // [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.hidesBackButton = YES;
    
    NSArray *firstSection = [NSArray arrayWithObjects:@"Remember my username",@"Remember my password", nil];

    NSArray *secondSection = [NSArray arrayWithObjects:@"Logout", nil];
    
    settings = [[NSMutableArray alloc] initWithObjects:firstSection, secondSection, nil];
    
    [self.tableView reloadData];

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
    
    static NSString *CellIdentifier = @"SettingsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [[cell textLabel]setText:contentForThisRow];
    
    if([indexPath section]==0 && [indexPath row]==0){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UISwitch *usernameswitchview = [[UISwitch alloc] initWithFrame:CGRectZero];
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:16];
        cell.accessoryView = usernameswitchview;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        if([defaults boolForKey:@"rememberusername"]){
            usernameswitchview.on=YES;
            username=TRUE;
        }else{
            usernameswitchview.on=NO;
        }
        
        [usernameswitchview addTarget:self action:@selector(usernameswitchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    if([indexPath section]==0 && [indexPath row]==1){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        UISwitch *passwordswitchview = [[UISwitch alloc] initWithFrame:CGRectZero];
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:16];
        cell.accessoryView = passwordswitchview;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

        if([defaults boolForKey:@"rememberpassword"]){
            passwordswitchview.on=YES;
            password=TRUE;
        }else{
            passwordswitchview.on=NO;
        }
        
        [passwordswitchview addTarget:self action:@selector(passwordswitchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    //logout button
    if([indexPath section]==1 && [indexPath row]==0){
        [cell setBackgroundColor:[UIColor redColor]];
        [cell.textLabel setTextAlignment:UITextAlignmentCenter];
    }
    
    return cell;
}

- (void) usernameswitchChanged:(id)sender {
    UISwitch* switchControl = sender;
    if(switchControl.on)
        username=YES;
    else
        username=NO;
}

- (void) passwordswitchChanged:(id)sender {
    UISwitch* switchControl = sender;
    if(switchControl.on)
        password=YES;
    else
        password=NO;
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(section == 0)
        return @"username and password";
    else if (section == 1)
        return @"Logout";
    else
        return @"Default";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{

    if(section == 0)
        return @"it is not adviced to turn on \"remember my password \"";
    else if(section == 1)
        return @"You will be logged out";
    else
        return @"Default";
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"MyPass" accessGroup:nil];

    if(indexPath.section == 1 && indexPath.row == 0){
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:NO forKey:@"loggedin"];
                
        if(!username){
            [defaults setBool:NO forKey:@"rememberusername"];
        }
        
        if(!password){
            [defaults setBool:NO forKey:@"rememberpassword"];

        }
        
        [defaults synchronize];
        
     //   [keychainItem resetKeychainItem];
        
        [self setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (IBAction)saveBtnTapped:(id)sender {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if(!username){
        [defaults setBool:NO forKey:@"rememberusername"];
    }
    
    if(!password){
        [defaults setBool:NO forKey:@"rememberpassword"];
    }
        
    [defaults synchronize];
    
    [self dismissModalViewControllerAnimated:YES];

}

@end
