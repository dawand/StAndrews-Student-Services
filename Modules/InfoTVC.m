//
//  InfoTVC.m
//  Modules
//
//  Created by Dawand Sulaiman on 28/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "InfoTVC.h"

@implementation InfoTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!expandedSections)
    {
        expandedSections = [[NSMutableIndexSet alloc] init];
    }
}

-(void) viewDidAppear:(BOOL)animated{
    
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    
}

- (BOOL)tableView:(UITableView *)tableView canCollapseSection:(NSInteger)section
{
    //expandable rows for first and second section
    if (section>=0 && section<2) return YES;
    
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self tableView:tableView canCollapseSection:section])
    {
        if ([expandedSections containsIndex:section])
        {
            return 4; // return rows when expanded
        }
        
        return 1; // only top row showing
    }
    
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"InfoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)
        {
            cell.textLabel.font = [UIFont systemFontOfSize:20];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.numberOfLines = 3;
            
            if(indexPath.section==0){
                // first row
                
                cell.textLabel.text = @"About Uni of St Andrews"; // only top row showing
                cell.detailTextLabel.text = @"General information about University of St Andrews";
                
                if ([expandedSections containsIndex:indexPath.section])
                {
                    cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeUp];
                }
                else
                {
                    cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeDown];
                }
                
            }
            
            else if(indexPath.section==1){
                // second row
                cell.textLabel.text = @"FAQ"; // only top row showing
                cell.detailTextLabel.text = @"View the most Frequently Asked Questions about this app";
                
                
                if ([expandedSections containsIndex:indexPath.section])
                {
                    cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeUp];
                }
                else
                {
                    cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeDown];
                }
                
            }
            
        }
        
        
        else
        {
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.textLabel.textColor = [UIColor blueColor];
            cell.detailTextLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.numberOfLines = 2;
            cell.detailTextLabel.numberOfLines = 6;
            cell.accessoryView = nil;
            
            // expanded rows
            if(indexPath.section==0 && indexPath.row==1 && [expandedSections containsIndex:indexPath.section]){
                cell.textLabel.text = @"University of St Andrews";
                cell.detailTextLabel.text = @"St Andrews is Scotland's first university and the third oldest in the English-speaking world, founded in 1413.";
            }
            
            else if (indexPath.section==0 && indexPath.row==2 && [expandedSections containsIndex:indexPath.section]){
                cell.textLabel.text = @"St Andrews Town";
                cell.detailTextLabel.text = @"St Andrews is relatively small, despite being a \"city\", with a basic population approaching 17,000. The University population (staff and students) numbers nearly 9,000. On average one in three people you see in the street have something to do with the University. You start to feel very quickly that you belong.";
            }
            
            
            else if (indexPath.section==0 && indexPath.row==3 && [expandedSections containsIndex:indexPath.section]){
                cell.textLabel.text = @"Address";
                cell.detailTextLabel.text = @"College Gate, St Andrews, Fife KY16 9AJ, Scotland, United Kingdom. \n Telephone: +44 (0)1334 476161";
            }
            
            // second section expanded rows
            else if(indexPath.section==1 && indexPath.row==1 && [expandedSections containsIndex:indexPath.section]){
                cell.textLabel.text = @"I cannot login to the system";
                cell.detailTextLabel.text = @"You need to be an admitted and marticulated St Andrews Student to own a University username and password. \n If you can sign in to iSaint and other web-based St Andrews Services, check with IT Helpdesk that you have the correct username and password. \n If the problem continues, contact djs21@st-andrews.ac.uk";
            }
            
            else if (indexPath.section==1 && indexPath.row==2 && [expandedSections containsIndex:indexPath.section]){
                cell.textLabel.text = @"My list of assignments is not accurate";
                cell.detailTextLabel.text = @"try to refresh the list by pressing the Refresh button next to the label 'Updated' to retrieve your assignments from server.";
                
            }
            
            else if (indexPath.section==1 && indexPath.row==3 && [expandedSections containsIndex:indexPath.section]){
                cell.textLabel.text = @"Not all my selected modules show up on timetable";
                cell.detailTextLabel.text = @"There might be some problems with this beta timetable server. Some optional modules do not appear on the University timetable";
            }
            
        }
    }
    
    
    if(indexPath.section==2){
        cell.textLabel.font = [UIFont systemFontOfSize:20];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.numberOfLines = 3;
        cell.accessoryView = nil;
        
        cell.textLabel.text = @"Guest Login";
        cell.detailTextLabel.text = @"Sign in as a guest to view the functions which do not require University username and passowrd";
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        if([defaults boolForKey:@"loggedin"]){
            
              cell.detailTextLabel.text =@"You are already logged in as a student";
        }
        if([defaults boolForKey:@"guestlogin"]){
            
            cell.detailTextLabel.text = @"You are already logged in as a guest. To logout go to Settings and choose logout guest";
        }
    }
    
    if(indexPath.section==3){
        cell.textLabel.font = [UIFont systemFontOfSize:20];
        cell.textLabel.textColor = [UIColor blueColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.numberOfLines = 3;
        cell.accessoryView = nil;
        
        cell.textLabel.text = @"Close this Window";
        cell.detailTextLabel.text = @"Dismiss this window to go back to your previous window";
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0 && [expandedSections containsIndex:indexPath.section])
        return 150;
    
    if(indexPath.section==1 && [expandedSections containsIndex:indexPath.section])
        return 150;
    
    else if (indexPath.section==2 || indexPath.section==3)
        return 100;
    
    else
        return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)
        {
            // only first row toggles exapand/collapse
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            NSInteger section = indexPath.section;
            BOOL currentlyExpanded = [expandedSections containsIndex:section];
            NSInteger rows;
            
            NSMutableArray *tmpArray = [NSMutableArray array];
            
            if (currentlyExpanded)
            {
                rows = [self tableView:tableView numberOfRowsInSection:section];
                [expandedSections removeIndex:section];
                
            }
            else
            {
                [expandedSections addIndex:section];
                rows = [self tableView:tableView numberOfRowsInSection:section];
            }
            
            
            for (int i=1; i<rows; i++)
            {
                NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:i 
                                                               inSection:section];
                [tmpArray addObject:tmpIndexPath];
            }
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (currentlyExpanded)
            {
                [tableView deleteRowsAtIndexPaths:tmpArray 
                                 withRowAnimation:UITableViewRowAnimationTop];
                
                cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeDown];
                
            }
            else
            {
                [tableView insertRowsAtIndexPaths:tmpArray 
                                 withRowAnimation:UITableViewRowAnimationTop];
                cell.accessoryView =  [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeUp];
                
            }
        }
    }
    
    if(indexPath.section==2){
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

        [defaults setBool:YES forKey:@"guestlogin"];
        
        [self dismissModalViewControllerAnimated:YES];
    }
    
    if(indexPath.section==3){
        [self dismissModalViewControllerAnimated:YES];
    }
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)path
{
    // Determine if row is selectable based on the NSIndexPath.
    BOOL rowIsSelectable=TRUE;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if([defaults boolForKey:@"guestlogin"] && path.section==2){
        //     [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        //   [cell setUserInteractionEnabled:NO];
        rowIsSelectable = FALSE;
    }
    
    if([defaults boolForKey:@"loggedin"] && path.section==2){
        //     [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        //   [cell setUserInteractionEnabled:NO];
        rowIsSelectable = FALSE;
    }
    
    if (rowIsSelectable)
    {
        return path;
    }
    
    return nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
