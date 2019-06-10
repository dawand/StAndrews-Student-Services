
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Notification.h"
#import "BlockBasedActionSheet.h"

/**
 Notifications Table View Controller
 
 This class lists all the reminders set by the student for the module start dates and assignment deadlines
 */
@interface NotificationsTVC : UITableViewController
{
    NSMutableArray *ListOfNotifications;
}

@property (nonatomic,retain) NSMutableArray *ListOfNotifications;
@property (weak, nonatomic) IBOutlet UIView *EmptyView;

@end
