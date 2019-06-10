
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TimetableModuleDetailsVC.h"
#import "TDBadgedCell.h"

@interface TimetableListTVC : UITableViewController
{
    NSMutableArray *Timetabledata;
    NSMutableArray *StartDateData;
    NSArray *sortedTimetableList;
}

@property (nonatomic, retain) NSMutableArray *Timetabledata;
@property (nonatomic, retain) NSMutableArray *StartDateData;
@property (nonatomic, retain) NSArray *sortedTimetableList;


@end
