#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

#define BASE_URL @"https://mms.st-andrews.ac.uk/mms/ws"
#define LOGIN_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"/AssignmentsJSON"]

/** Authentication Engine Delegate Protocol
 
 This protocol is used by Login View controller to determine the success or failure of the student login attempts
*/
@protocol AuthenticationEngineDelegate <NSObject>

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
 This method will be called if the web view login is succeeded for the current request
 */
-(void) webViewLoginSucceeded:(ASIHTTPRequest*) request;

@end

/**
 This class handles the authentication process of the students
 
    Username and password is required
 
 */
@interface AuthenticationEngine : NSObject
/**
 An instance variable of type ID of the delegate
 */
@property (nonatomic, unsafe_unretained) id<AuthenticationEngineDelegate> delegate;
/**
 a network queue to hold the requests sent to the server
 */
@property (nonatomic, strong) ASINetworkQueue *networkQueue;

/**
 @name initialize with Login name and password
 
 @param username string
 @param password string
 @return an id reference to the engine
 */
- (id) initWithLoginName:(NSString*) loginName password:(NSString*) password;

- (id) WebViewLogin:(NSString*) loginName password:(NSString*) password:(NSString*) WebURL;

@end
