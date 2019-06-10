//
//  UniRSSLoaderTVC.m
//  Modules
//
//  Created by Dawand Sulaiman on 13/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "UniRSSLoaderTVC.h"

@implementation UniRSSLoaderTVC

@synthesize NewsAndEventsSegControl,segmentedControlChoice,cachedNews,AlertProgress,cachedEvents;

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
    
    self.navigationItem.title = @"University News";
    segmentedControlChoice = @"News"; 
    
    [self populateData];
    
//     self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
        
    [self.tableView reloadData];

}

-(void) populateData {
    
    AlertProgress = [[TKProgressAlertView alloc] initWithProgressTitle:@"Loading..."];
    [AlertProgress.progressBar setProgress:0.6];
    
//    cachedNews = [UniNewsCache getCachedItems];
//    cachedEvents = [UniEventsCache getCachedItems];
//
//    if(cachedNews == nil || cachedEvents == nil){
    
        [AlertProgress show];
        
        rss = [[RSSLoader alloc] init];
        rss.delegate = self;
        [rss load:@"university":segmentedControlChoice];
        
        if(rss.loaded==YES){
            [AlertProgress hide];
        }
//    }
//
//    else{
//        if([segmentedControlChoice isEqualToString:@"News"])
//            rssItems = cachedNews;
//        else
//            rssItems = cachedEvents;
//    }

    [self.tableView reloadData];
}

#pragma mark -
#pragma mark RSSLoaderDelegate
-(void)updatedFeedWithRSS:(NSMutableArray*)items
{
    if([segmentedControlChoice isEqualToString:@"News"]){
        NewsItems=items;
        rssItems = NewsItems;
    }else{
        EventsItems=items;
        rssItems=EventsItems;
    }
    
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

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

- (void) viewDidDisappear:(BOOL)animated{
    
    [UniNewsCache cacheItems:NewsItems];
    [UniEventsCache cacheItems:EventsItems];
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
    
    cell.textLabel.text = [item objectForKey:@"title"];
    cell.detailTextLabel.text = [item objectForKey:@"pubDate"];
    return cell;
}

//
- (UITableViewCell *)getTextCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    static NSString *TextCellIdentifier = @"TextCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TextCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TextCellIdentifier];
    }
    
    NSDictionary* item = [rssItems objectAtIndex: (indexPath.row-1)/2];
    
    //article preview
    cell.textLabel.font = [UIFont systemFontOfSize:11];
    cell.textLabel.numberOfLines = 3;
    cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = [UIColor clearColor];
    cell.backgroundView = backView;
    
    CGRect f = cell.textLabel.frame;
    [cell.textLabel setFrame: CGRectMake(f.origin.x+40, f.origin.y, f.size.width-40, f.size.height)];
    cell.textLabel.text = [item objectForKey:@"description"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    RSSDetailsVC *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"rssDetailsVC"];
    
    detailViewController.item = [rssItems objectAtIndex:floor(indexPath.row/2)];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (void)viewDidUnload {
    [self setNewsAndEventsSegControl:nil];
    [super viewDidUnload];
}

- (IBAction)SegChanged:(id)sender {
    
    if(NewsAndEventsSegControl.selectedSegmentIndex==0)
    {
        segmentedControlChoice = @"News";
        self.navigationItem.title = @"University News";
    }
    else
    {
        segmentedControlChoice = @"Jobs";
        self.navigationItem.title = @"University Vacancies";
    }
    
    [self populateData];
    [self.tableView reloadData];
}

- (IBAction)RefreshBtnTapped:(id)sender {
    
    [UniNewsCache clearCache];
    [UniEventsCache clearCache];
    [self populateData];
}

@end
