
#import <Foundation/Foundation.h>

@interface SchoolEventsCache : NSObject

+(NSString*) cacheDirectory;
+(void) clearCache;
+(NSString*) appVersion;

+(void) cacheItems:(NSMutableArray*) Items;
+(NSMutableArray*) getCachedItems;

@end
