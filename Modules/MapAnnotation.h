//
//  MapAnnotation.h
//  ExploreErbil
//
//  Created by Dawand Sulaiman on 25/01/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject <MKAnnotation> {
@private
    CLLocationCoordinate2D _coordinate;
    NSString* _title;
    NSString* _subtitle;
}

@property(nonatomic) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString* title;
@property(nonatomic, copy) NSString* subtitle;
@property(nonatomic, copy) NSString* cat;
//- (id) initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString*)title subtitle:(NSString*)subtitle;
@end
