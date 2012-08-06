//
//  LibraryRSSLoaderTVC.h
//  Modules
//
//  Created by Dawand Sulaiman on 13/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSLoader.h"
#import "RSSDetailsVC.h"

@interface LibraryRSSLoaderTVC : UITableViewController<RSSLoaderDelegate>
{
    RSSLoader* rss;
    NSMutableArray* rssItems;
}

- (UITableViewCell *)getLoadingTableCellWithTableView:(UITableView *)tableView;
- (UITableViewCell *)getTextCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@property (weak, nonatomic) NSString *segmentedControlChoice;
@property (weak, nonatomic) IBOutlet UISegmentedControl *NewsAndEventsSegControl;
- (IBAction)SegChanged:(id)sender;

@end
