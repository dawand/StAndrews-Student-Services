//
//  RSSLoader.m
//  Modules
//
//  Created by Dawand Sulaiman on 26/06/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "RSSLoader.h"

@implementation RSSLoader

@synthesize delegate,loaded,segmentedControlChoice,sourceChoice;

-(void)load:(NSString *)source:(NSString*) SegChoice
{
    [self dispatchLoadingOperation];
    self.segmentedControlChoice = SegChoice;
    self.sourceChoice = source;
}

-(void)dispatchLoadingOperation
{
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(fetchRss) object:nil];
    [queue addOperation:operation];
}

-(void)fetchRss
{
    NSData* xmlData = nil;
    
    NSLog(@"fetch rss");
    
    if([sourceChoice isEqualToString:@"school"]&& [segmentedControlChoice isEqualToString:@"News"]){
        xmlData = [[NSMutableData alloc] initWithContentsOfURL:[NSURL URLWithString: SchoolRSSUrlNews] ];
    }
    else if([sourceChoice isEqualToString:@"school"]&& [segmentedControlChoice isEqualToString:@"Events"]) {
        xmlData = [[NSMutableData alloc] initWithContentsOfURL:[NSURL URLWithString: SchoolRSSUrlEvents] ];
    }
    
    else if([sourceChoice isEqualToString:@"university"]&& [segmentedControlChoice isEqualToString:@"News"]){
        xmlData = [[NSMutableData alloc] initWithContentsOfURL:[NSURL URLWithString: UniversityRSSUrlNews] ];
    }
    else if([sourceChoice isEqualToString:@"university"]&& [segmentedControlChoice isEqualToString:@"Events"]) {
        xmlData = [[NSMutableData alloc] initWithContentsOfURL:[NSURL URLWithString: UniversityRSSUrlEvents] ];
    }
    else if([sourceChoice isEqualToString:@"library"]&& [segmentedControlChoice isEqualToString:@"News"]) {
        xmlData = [[NSMutableData alloc] initWithContentsOfURL:[NSURL URLWithString: LibraryRSSUrlNews] ];
    }

    
    NSError *error;
    
    GDataXMLDocument* doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&error];
    
    if (doc != nil) {
        self.loaded = YES;
        
        GDataXMLNode* title = [[[doc rootElement] nodesForXPath:@"channel/title" error:&error] objectAtIndex:0];
        [self.delegate updatedFeedTitle: [title stringValue] ];
        
        NSArray* items = [[doc rootElement] nodesForXPath:@"channel/item" error:&error];
        NSMutableArray* rssItems = [NSMutableArray arrayWithCapacity:[items count] ];
        
        for (GDataXMLElement* xmlItem in items) {
            [rssItems addObject: [self getItemFromXmlElement:xmlItem] ];
        }
        
        [self.delegate performSelectorOnMainThread:@selector(updatedFeedWithRSS:) withObject:rssItems waitUntilDone:YES];
    } else {
        [self.delegate performSelectorOnMainThread:@selector(failedFeedUpdateWithError:) withObject:error waitUntilDone:YES];
    }
}

-(NSDictionary*)getItemFromXmlElement:(GDataXMLElement*)xmlItem
{

    return [NSDictionary dictionaryWithObjectsAndKeys:
            [[[xmlItem elementsForName:@"title"] objectAtIndex:0] stringValue], @"title",
            [[[xmlItem elementsForName:@"link"] objectAtIndex:0] stringValue], @"link",
            [[[xmlItem elementsForName:@"pubDate"] objectAtIndex:0] stringValue], @"pubDate",
            [[[xmlItem elementsForName:@"description"] objectAtIndex:0] stringValue], @"description",
            nil];
}

@end
