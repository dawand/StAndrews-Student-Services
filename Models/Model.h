
#import <Foundation/Foundation.h>

/**
 The superclass of all other models
 */
@interface Model : NSObject <NSCoding, NSCopying, NSMutableCopying> {

}

-(id) initWithDictionary:(NSMutableDictionary*) jsonObject;

@end
