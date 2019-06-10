

#import <Foundation/Foundation.h>

#define kRequestErrorDomain @"HTTP_ERROR"
#define kBusinessErrorDomain @"BIZ_ERROR" // rename this appropriately

/**
 The REST error class to represent the errors received back from the MMS server
 */
@interface RESTError : NSError {

    NSString *message;
    NSString *errorCode;
}

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *errorCode;

- (NSString*) localizedOption;

-(id) initWithDictionary:(NSMutableDictionary*) jsonObject;

@end
