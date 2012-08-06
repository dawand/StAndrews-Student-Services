//
//  MapAnnotation.m
//  ExploreErbil
//
//  Created by Dawand Sulaiman on 25/01/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

@synthesize coordinate=_coordinate, title=_title, subtitle=_subtitle, cat=_cat;

- (id) initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString*)title subtitle:(NSString*)subtitle:(NSString *)category {
    if ((self = [super init])) {
        _coordinate = coordinate;
        _title = [title copy];
        _subtitle = [subtitle copy];
        _cat = [category copy];
    }
    return self;
}

@end
