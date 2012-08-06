

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

#import "RESTError.h"

/**
 This is the authentication request sent to the sevrer for authentication
 */
@interface RESTRequest : ASIFormDataRequest {
    
}

@property (nonatomic, strong) RESTError *restError;

-(NSMutableDictionary*) responseDictionary;
@end
