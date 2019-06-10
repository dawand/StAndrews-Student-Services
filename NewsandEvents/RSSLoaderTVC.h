//
//  RSSLoaderTVC.h
//  Modules
//
//  Created by Dawand Sulaiman on 26/06/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSLoader.h"
#import "RSSDetailsVC.h"
#import "SchoolNewsCache.h"
#import "SchoolEventsCache.h"
#import "TKProgressAlertView.h"

@interface RSSLoaderTVC : UITableViewController<RSSLoaderDelegate>
{
    RSSLoader* rss;
    NSMutableArray* rssItems;
    NSMutableArray* NewsItems;
    NSMutableArray* EventsItems;
}

- (UITableViewCell *)getTextCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@property (weak, nonatomic) NSString *segmentedControlChoice;
@property (weak, nonatomic) IBOutlet UISegmentedControl *NewsAndEventsSegControl;
@property (nonatomic,retain)TKProgressAlertView *AlertProgress;
@property (nonatomic,strong) NSMutableArray *cachedNews;
@property (nonatomic,strong) NSMutableArray *cachedEvents;

- (IBAction)SegChanged:(id)sender;
- (IBAction)RefreshBtnTapped:(id)sender;
- (void) populateData;

@end
