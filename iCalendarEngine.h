
#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "RESTRequest.h"
#import "modules.h"
#import "TimetableModule.h"
#import "CGICalendar.h"

#define BASE2_URL @"https://moody2.st-andrews.ac.uk/samobile/"
#define LOGIN2_URL [NSString stringWithFormat:@"%@%@", BASE2_URL, @""]
#define MENU_ITEMS2_URL [NSString stringWithFormat:@"%@%@", BASE2_URL, @"/timetable"]

#define kAccessTokenDefaultsKey @"ACCESS_TOKEN"

@protocol iCalendarEngineDelegate <NSObject>
@optional
-(void) loginSucceeded:(NSString*) accessToken;
-(void) loginFailedWithError:(NSError*) error;
-(void) menuFetchSucceeded:(NSMutableArray*) menuItems;
-(void) menuFetchFailed:(NSError*) error;
@end

@interface iCalendarEngine : NSObject {
    
    NSString *accessToken_;
}

@property (nonatomic, unsafe_unretained) id<iCalendarEngineDelegate> delegate;
@property (nonatomic, strong) ASINetworkQueue *networkQueue;
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic, strong) NSMutableArray *StartDateData;

-(id) initWithLoginName:(NSString*) loginName password:(NSString*) password;
-(RESTRequest*) fetchTimetableItems;
@end
