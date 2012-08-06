
#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define minutesBefore 10

#import <UIKit/UIKit.h>
#import "AuthenticationEngine.h"
#import "RESTEngine.h"
#import "iCalendarEngine.h"
#import "KeychainItemWrapper.h"
#import "TestFlight.h" 

/** Application Delegate Class
 
 This class is the main delegate class for the application and main window which holds all the views
 
 It holds the engine pointers so they can be accessed in other classes which use the engines by just interacting with this delegate 
 
 */
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    AuthenticationEngine *AuthEngine;
    RESTEngine *engine;
    iCalendarEngine *CalendarEngine;
}

@property (strong, nonatomic) UIWindow *window;
/**
 Authentication Engine used by login view and module web view controllers for authenticating the student
 */
@property (nonatomic, strong) AuthenticationEngine *AuthEngine;
/**
 REST Engine used by modules Table view controller for retrieving the list of modules and assignments
 */
@property (nonatomic, strong) RESTEngine *engine;
/**
 Calendar Engine used by timetable table view controller for retrieving the list of timetable modules and their properties
 */
@property (nonatomic, strong) iCalendarEngine *CalendarEngine;
//@property (nonatomic,assign) int MinutesBefore;

@end
