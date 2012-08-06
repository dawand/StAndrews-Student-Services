
#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "RESTRequest.h"
#import "modules.h"
#import "TimetableModule.h"
#import "CGICalendar.h"

#define TIMETABLE_BASE_URL @"https://moody2.st-andrews.ac.uk/samobile/"
#define TIMETABLE_LOGIN_URL [NSString stringWithFormat:@"%@%@", TIMETABLE_BASE_URL, @"/timetable"]
#define TIMETABLE_ITEMS_URL [NSString stringWithFormat:@"%@%@", TIMETABLE_BASE_URL, @"/timetable"]

/** iCalendar Engine Delegate Protocol
 
 This protocol is used by Timetable Table View controller to determine the success or failure of the student login for the timetable server and the success or failure of fetching the timetable modules from the server
 */
@protocol iCalendarEngineDelegate <NSObject>
@optional
/*
 This method will be called if the response from the server is a successful attempt
 **/
-(void) loginSucceeded;
/**
 This method will be called if the response from the server is negative
 */
-(void) loginFailedWithError:(NSError*) error;
/**
 This method will be called if the fetching of timetable module properties is successful
 @param the array of the fetched timetable modules
 */
-(void) menuFetchSucceeded:(NSMutableArray*) menuItems;
/**
 This method will be called if the fetching of timetable modules failed
 @param NSerror
 */
-(void) menuFetchFailed:(NSError*) error;
@end

@interface iCalendarEngine : NSObject

@property (nonatomic, unsafe_unretained) id<iCalendarEngineDelegate> delegate;
@property (nonatomic, strong) ASINetworkQueue *networkQueue;
@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic, strong) NSMutableArray *StartDateData;

/**
 @name initialize with Login name and password
 
 @param username string
 @param password string
 @return an id reference to the engine
 */
-(id) initWithLoginName:(NSString*) loginName password:(NSString*) password;

/**
 This method fetches the time table modules from the timetable server
 */
-(RESTRequest*) fetchTimetableItems;

@end
