//
//  AssignmentsTVC.m
//  Modules
//
//  Created by Dawand Sulaiman on 02/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "AssignmentsTVC.h"


@implementation AssignmentsTVC

@synthesize assignmentsArray,courseworkArray,ModuleTitle;

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
    [super viewDidLoad];
    
    self.navigationItem.title = ModuleTitle;
    coursework *cw = [[coursework alloc]init];
    cw = [courseworkArray objectAtIndex:0];
    
    self.assignmentsArray = cw.assignmentsArray;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.assignmentsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    assignments *as = [self.assignmentsArray objectAtIndex:[indexPath row]];
    
    NSString *DeadlineDateStr = as.deadline;
    
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    NSDate *date = [dateFormat dateFromString:DeadlineDateStr];  
    
    // Convert date object to desired output format
    [dateFormat setDateFormat:@"EEEE dd-LLL-YYYY H:mm"];
    DeadlineDateStr = [dateFormat stringFromDate:date]; 
    
    static NSString *CellIdentifier = @"AssignmentCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@",as.title]]; 
    [[cell detailTextLabel]setText:[NSString stringWithFormat:@"%@",DeadlineDateStr]];
    
    if(!as.mark){
        cell.imageView.image = [UIImage imageNamed:@"waiting.png"];
    }
    else if([as.mark doubleValue]>=16.5){
        cell.imageView.image = [UIImage imageNamed:@"distinction.png"];
    }
    else if([as.mark doubleValue]<16.5 && [as.mark doubleValue]>=13.5){
        cell.imageView.image = [UIImage imageNamed:@"pass.png"];
    }
    else if([as.mark doubleValue]<13.5 && [as.mark doubleValue]>=7.5){
        cell.imageView.image = [UIImage imageNamed:@"notpass.png"];
    }
    else if([as.mark doubleValue]<7.5){
        cell.imageView.image = [UIImage imageNamed:@"fail.png"];
    }
   
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    assignments *as = [self.assignmentsArray objectAtIndex:[indexPath row]];
    
    AssignmentDetailsVC *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AssignmentDetailsVC"];
     // ...
     // Pass the selected object to the new view controller.
    
    detailViewController.assignment = as;
    
     [self.navigationController pushViewController:detailViewController animated:YES];
     
}

@end
