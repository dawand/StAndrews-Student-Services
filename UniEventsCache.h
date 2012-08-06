//
//  UniEventsCache.h
//  Modules
//
//  Created by Dawand Sulaiman on 18/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UniEventsCache : NSObject

+(NSString*) cacheDirectory;
+(void) clearCache;
+(NSString*) appVersion;

+(void) cacheItems:(NSMutableArray*) Items;
+(NSMutableArray*) getCachedItems;
+(BOOL) isItemsStale;

@end