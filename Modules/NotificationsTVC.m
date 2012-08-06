//
//  NotificationsTVC.m
//  Modules
//
//  Created by Dawand Sulaiman on 24/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "NotificationsTVC.h"

@interface NotificationsTVC ()
{
    BOOL deleteReminder;
}
@end

@implementation NotificationsTVC

@synthesize ListOfNotifications;
@synthesize EmptyView;

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

    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];

    [EmptyView setHidden:YES];
    
    ListOfNotifications =[NSMutableArray arrayWithArray:[[UIApplication sharedApplication] scheduledLocalNotifications]];
            
    if([ListOfNotifications count]==0){
    
        [EmptyView setHidden:NO];
    }
    
    [self.tableView reloadData];
    
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setEmptyView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) viewDidAppear:(BOOL)animated{
    
    [self.tableView reloadData];
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [ListOfNotifications count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Notification *noti = [[Notification alloc]init];
    noti = [ListOfNotifications objectAtIndex:[indexPath row]];
    
    static NSString *CellIdentifier = @"NotificationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UIView* bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    bgview.opaque = YES;
    bgview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    [cell setBackgroundView:bgview];
    
    [cell setHighlighted:YES];
    
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:22];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = UITextAlignmentCenter;

    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"EEEE dd-LLL-YYYY H:mm"];
    NSString *fireDateStr = [formatter stringFromDate:noti.fireDate];
    
    cell.textLabel.text = fireDateStr;
    
 //   UILocalNotification* oneEvent = [ListOfNotifications objectAtIndex:[indexPath row]];
 //   NSDictionary *userInfoCurrent = oneEvent.userInfo;
    
    cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:20];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];

    cell.detailTextLabel.text = noti.alertBody;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    
        UILocalNotification *tobeDeletedNorification;
        
        tobeDeletedNorification = [ListOfNotifications objectAtIndex:[indexPath row]];
        
        BlockBasedActionSheet *askSheet =
        [[BlockBasedActionSheet alloc] 
         initWithTitle:@"Delete Reminder?"
         cancelButtonTitle:@"No"
         destructiveButtonTitle:@"Yes"
         cancelAction:^{
             [self.tableView setEditing:YES animated:YES];
         }
         destructiveAction:^{
             [ListOfNotifications removeObjectAtIndex:[indexPath row]];
             
             [[UIApplication sharedApplication] cancelLocalNotification:tobeDeletedNorification];
             
             // Delete the row from the data source
             
             [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
             
             if([ListOfNotifications count]==0){
                 
                 [EmptyView setHidden:NO];
             }

         }];
        
        [askSheet showInView:self.view];
    
    }  
    
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
