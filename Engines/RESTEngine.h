#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "RESTRequest.h"
#import "modules.h"

#define BASE_URL @"https://mms.st-andrews.ac.uk/mms/ws"
#define LOGIN_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"/AssignmentsJSON"]
#define MODULE_ITEMS_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"/AssignmentsJSON"]

/** REST Engine Delegate Protocol
 
 This protocol is used by Modules Table View controller to determine the success or failure of the student login for the MMS server and the success or failure of fetching the modules and assignments from the server
 */
@protocol RESTEngineDelegate <NSObject>
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
 This method will be called if the fetching of modules and assignments is successful
 @param the array of the fetched modules
 */
-(void) moduleFetchSucceeded:(NSMutableArray*) menuItems;

/**
 This method will be called if the fetching of modules and assignment failed
 @param NSerror
 */
-(void) moduleFetchFailed:(NSError*) error;

@end

@interface RESTEngine : NSObject

@property (nonatomic, unsafe_unretained) id<RESTEngineDelegate> delegate;
@property (nonatomic, strong) ASINetworkQueue *networkQueue;


/**
 @name initialize with Login name and password
 
 @param username string
 @param password string
 @return an id reference to the engine
 */
-(id) initWithLoginName:(NSString*) loginName password:(NSString*) password;

/**
 This method fetches the modules and assignments from the MMS server
 */
-(RESTRequest*) fetchModuleItems;

@end
