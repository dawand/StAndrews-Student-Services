
#import <Foundation/Foundation.h>

@interface Model : NSObject <NSCoding, NSCopying, NSMutableCopying> {

}

-(id) initWithDictionary:(NSMutableDictionary*) jsonObject;

@end
