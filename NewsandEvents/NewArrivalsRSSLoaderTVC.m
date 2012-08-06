//
//  NewArrivalsRSSLoaderTVC.m
//  Modules
//
//  Created by Dawand Sulaiman on 27/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "NewArrivalsRSSLoaderTVC.h"


@implementation NewArrivalsRSSLoaderTVC

@synthesize NewsAndEventsSegControl,segmentedControlChoice,AlertProgress;

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
    [super viewDidLoad];

    self.navigationItem.title = @"New Arrivals";
    segmentedControlChoice = @"Books"; 
 
    [self populateData];

    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
    
    [self.tableView reloadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) populateData {
    
    AlertProgress = [[TKProgressAlertView alloc] initWithProgressTitle:@"Loading..."];
    [AlertProgress.progressBar setProgress:0.6];
    
        
        [AlertProgress show];
        
        rss = [[RSSLoader alloc] init];
        rss.delegate = self;
        [rss load:@"arrivals":segmentedControlChoice];
        
        if(rss.loaded==YES){
            [AlertProgress hide];
        }
    
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)updatedFeedWithRSS:(NSMutableArray*)items
{
    rssItems = items;
    
    [AlertProgress hide];
    
    [self.tableView reloadData];
}

-(void)failedFeedUpdateWithError:(NSError *)error
{
    [AlertProgress hide];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"error parsing" message:@"Please make sure your device is connected to Internet" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    
}

-(void)updatedFeedTitle:(NSString*)rssTitle
{
    //
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [rssItems count]*2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row % 2 == 1) {
        return [self getTextCellWithTableView:tableView atIndexPath:indexPath];
    }
    
    static NSString *CellIdentifier = @"TitleCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = [UIColor clearColor];
    cell.backgroundView = backView;
    
    NSDictionary* item = [rssItems objectAtIndex: indexPath.row/2];
    cell.textLabel.numberOfLines = 3;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.text = [item objectForKey:@"title"];
//    cell.detailTextLabel.text = [item objectForKey:@"pubDate"];
    
    return cell;
}

- (UITableViewCell *)getTextCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    static NSString *TextCellIdentifier = @"TextCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TextCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TextCellIdentifier];
    }
    
    NSDictionary* item = [rssItems objectAtIndex: (indexPath.row-1)/2];
    
    //article preview
    cell.textLabel.font = [UIFont systemFontOfSize:11];
    cell.textLabel.numberOfLines = 1;
    cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = [UIColor clearColor];
    cell.backgroundView = backView;
    
    CGRect f = cell.textLabel.frame;
    [cell.textLabel setFrame: CGRectMake(f.origin.x+10, f.origin.y, f.size.width-10, f.size.height)];
    cell.textLabel.text = [item objectForKey:@"description"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    RSSDetailsVC *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"rssDetailsVC"];
    
    detailViewController.item = [rssItems objectAtIndex:floor(indexPath.row/2)];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (IBAction)SegChanged:(id)sender {
    
    if(NewsAndEventsSegControl.selectedSegmentIndex==0)
    {
        segmentedControlChoice = @"Books";
        self.navigationItem.title = @"Latest Books";
    }
    else if (NewsAndEventsSegControl.selectedSegmentIndex==1)
    {
        segmentedControlChoice = @"DVDs";
        self.navigationItem.title = @"Latest DVDs";
    }

    else if (NewsAndEventsSegControl.selectedSegmentIndex==2)
    {
        segmentedControlChoice = @"eBooks";
        self.navigationItem.title = @"Latest eBooks";
    }
    else if (NewsAndEventsSegControl.selectedSegmentIndex==3)
    {
        segmentedControlChoice = @"eJournals";
        self.navigationItem.title = @"Latest eJournals";
    }
    
    [self populateData];
    [self.tableView reloadData];
}

- (IBAction)RefreshBtnTapped:(id)sender {
    
    [self populateData];
}


@end
