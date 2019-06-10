//
//  RSSLoader.h
//  Modules
//
//  Created by Dawand Sulaiman on 26/06/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

#define SchoolRSSUrlNews @"http://www.almasryalyoum.com/news_homepage_feed"
#define SchoolRSSUrlEvents @"http://blogs.cs.st-andrews.ac.uk/csblog/category/event/feed/"
#define UniversityRSSUrlNews @"http://digitalcommunications.wp.st-andrews.ac.uk/feed/"
#define UniversityRSSUrlEvents @"https://www.vacancies.st-andrews.ac.uk/VacanciesFeed.aspx"
#define LibraryRSSUrlNews @"http://www.st-andrews.ac.uk/rss/library/index.xml"
#define NewArrivalsBooks @"http://library.st-andrews.ac.uk/live/feeds/latestaccs.xml"
#define NewArrivalsDVDs @"http://library.st-andrews.ac.uk/live/feeds/recdvds.xml"
#define NewArrivalsEBooks @"http://library.st-andrews.ac.uk/live/feeds/newebooks.xml"
#define NewArrivalsEJournals @"http://library.st-andrews.ac.uk/live/feeds/latestejournals.xml"

/** RSS Loader Delegate
 
 This protocol is conformed by the university, school and library news and events view controllers to update the list of feeds from the RSS feeds for each source accordingly
 */
@protocol RSSLoaderDelegate
@required
/**
 This method will be called if the RSS parsing procedure is successful
 @param an array of the parsed items to be pouplated into the view controllers
 */
-(void)updatedFeedWithRSS:(NSArray*)items;
/**
 This method will be called if the RSS parsing failed
 @param NSError
 */
-(void)failedFeedUpdateWithError:(NSError*)error;
/**
 This method will be called to updated the title of the feed
 */
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

/**
 This method loads the correct URL based on the received parameters
 @param the source which can be either University, school or library
 @param the choice between either news or events
 */
-(void)load:(NSString *)source:(NSString*) SegChoice;

/**
 This method is called from load method above and it creates a network queue for the request
 */
-(void)dispatchLoadingOperation;

/**
 This method gets the fetched XML element and returns an NSDictionary containing all the properties for the entry
 @param an xml element
 @return NSDictionary of properties of the passed xml element
 */
-(NSDictionary*)getItemFromXmlElement:(GDataXMLElement*)xmlItem;

@end
