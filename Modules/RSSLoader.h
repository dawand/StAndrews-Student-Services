//
//  RSSLoader.h
//  Modules
//
//  Created by Dawand Sulaiman on 26/06/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

#define SchoolRSSUrlNews @"http://blogs.cs.st-andrews.ac.uk/csblog/category/news/feed/"
#define SchoolRSSUrlEvents @"http://blogs.cs.st-andrews.ac.uk/csblog/category/event/feed/"
#define UniversityRSSUrlNews @"http://www.st-andrews.ac.uk/rss/news/index.xml"
#define UniversityRSSUrlEvents @"http://www.st-andrews.ac.uk/rss/events/index.xml"
#define LibraryRSSUrlNews @"http://www.st-andrews.ac.uk/rss/library/index.xml"

@protocol RSSLoaderDelegate
@required
-(void)updatedFeedWithRSS:(NSArray*)items;
-(void)failedFeedUpdateWithError:(NSError*)error;
-(void)updatedFeedTitle:(NSString*)title;
@end

@interface RSSLoader : NSObject {
UIViewController<RSSLoaderDelegate> * delegate;
BOOL loaded;
}

@property (retain, nonatomic) UIViewController<RSSLoaderDelegate> * delegate;
@property (nonatomic, assign) BOOL loaded;
@property (weak, nonatomic) NSString *segmentedControlChoice;
@property (weak, nonatomic) NSString *sourceChoice;

-(void)load:(NSString *)source:(NSString*) SegChoice;
-(void)dispatchLoadingOperation;
-(NSDictionary*)getItemFromXmlElement:(GDataXMLElement*)xmlItem;

@end
