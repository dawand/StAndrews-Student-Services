

#import <Foundation/Foundation.h>

@interface ModulesCache : NSObject {

}

+(NSString*) cacheDirectory;
+(void) clearCache;
+(NSString*) appVersion;

+(void) cacheMenuItems:(NSMutableArray*) menuItems;
+(NSMutableArray*) getCachedMenuItems;
+(BOOL) isMenuItemsStale;

@end
