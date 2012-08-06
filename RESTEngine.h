#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "RESTRequest.h"
#import "modules.h"

#define BASE_URL @"https://mms.st-andrews.ac.uk/mms/ws"
#define LOGIN_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"/AssignmentsJSON"]
#define MENU_ITEMS_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"/AssignmentsJSON"]

#define kAccessTokenDefaultsKey @"ACCESS_TOKEN"

@protocol RESTEngineDelegate <NSObject>
@optional
-(void) loginSucceeded:(NSString*) accessToken;
-(void) loginFailedWithError:(NSError*) error;
-(void) menuFetchSucceeded:(NSMutableArray*) menuItems;
-(void) menuFetchFailed:(NSError*) error;
@end

@interface RESTEngine : NSObject {

    NSString *accessToken_;
}

@property (nonatomic, unsafe_unretained) id<RESTEngineDelegate> delegate;
@property (nonatomic, strong) ASINetworkQueue *networkQueue;
@property (nonatomic, strong) NSString *accessToken;

-(id) initWithLoginName:(NSString*) loginName password:(NSString*) password;
-(RESTRequest*) fetchMenuItems;
-(NSMutableArray*) localMenuItems;
-(void) fetchWrongMenu;
- (RESTRequest*) LoginAndFetchModules:(NSString*) loginName password:(NSString*) password;
@end
