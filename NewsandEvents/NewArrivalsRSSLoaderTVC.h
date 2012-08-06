
#import <UIKit/UIKit.h>
#import "RSSLoader.h"
#import "RSSDetailsVC.h"
#import "TKProgressAlertView.h"

@interface NewArrivalsRSSLoaderTVC : UITableViewController<RSSLoaderDelegate>
{
    RSSLoader* rss;
    NSMutableArray* rssItems;
}

- (UITableViewCell *)getTextCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@property (weak, nonatomic) NSString *segmentedControlChoice;
@property (weak, nonatomic) IBOutlet UISegmentedControl *NewsAndEventsSegControl;
@property (nonatomic,retain)TKProgressAlertView *AlertProgress;

- (IBAction)SegChanged:(id)sender;

- (IBAction)RefreshBtnTapped:(id)sender;

-(void) populateData;

@end
