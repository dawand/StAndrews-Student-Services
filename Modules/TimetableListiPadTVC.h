#import <UIKit/UIKit.h>
#import "TapkuLibrary.h"
#import "iCalendarEngine.h"
#import "AppDelegate.h"
#import "TimetableModule.h"
#import "TimetableModuleDetailsVC.h"
#import "TKProgressAlertView.h"
#import "TimetableCache.h"
#import "TDBadgedCell.h"

@interface TimetableListiPadTVC : UITableViewController<iCalendarEngineDelegate>
{
    NSMutableArray *data;
    NSMutableArray *startDateData;
    NSMutableArray *cachedItems;
    NSString *dateLabelStr;
    NSString *username;
    NSString *password;
    NSArray *sortedTimetableList;

}

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSMutableArray *startDateData;
@property (nonatomic,retain)TKProgressAlertView *AlertProgress;
@property (nonatomic,strong) NSMutableArray *cachedItems;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *dateLabel;
@property (nonatomic,strong) NSString *dateLabelStr;
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSArray *sortedTimetableList;


- (void) fetchFromServer;

- (IBAction)RefreshBtnTapped:(id)sender;

@end
