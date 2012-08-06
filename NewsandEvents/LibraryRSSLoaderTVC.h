
#import <UIKit/UIKit.h>
#import "RSSLoader.h"
#import "RSSDetailsVC.h"
#import "TKProgressAlertView.h"
#import "libraryNewsCache.h"

/**
 * This class loads the library news parsed from RSSLoader engine 
 */
@interface LibraryRSSLoaderTVC : UITableViewController<RSSLoaderDelegate>
{
    RSSLoader* rss;
    NSMutableArray* rssItems;
    NSMutableArray* NewsItems;
}

/**
 * @name A cell of each table view
 
 @param the current table view containing the cell
 @param the index path of the cell in the table
 @return the configured cell
 
 */
- (UITableViewCell *)getTextCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic,strong) NSMutableArray *cachedNews;
@property (nonatomic,retain)TKProgressAlertView *AlertProgress;

/**
 @name Refresh button method
 
 */
- (IBAction)RefreshBtnTapped:(id)sender;

/**
  To populate the library news items on the table view
 */
- (void) populateData;

@end
