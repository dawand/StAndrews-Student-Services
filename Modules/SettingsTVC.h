
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "KeychainItemWrapper.h"
#import "TimetableCache.h"
#import "ModulesCache.h"
#import "NotificationsTVC.h"
#import "TDBadgedCell.h"

/** Settings Table View Controller Class
 
 This class manages the user settings and preferences
 
 It shows the username and list of notifications set earlier and they can be edited in this section
 
 */
@interface SettingsTVC : UITableViewController

@property (nonatomic, strong) NSMutableArray *settings;
@property(nonatomic) Boolean usernameChecked;

/** -----------------------------
 * @name save changes in settings
 
 @param sender of the Save button
 
 */
- (IBAction)saveBtnTapped:(id)sender;

@end
