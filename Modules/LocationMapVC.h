//
//  LocationMapVC.h
//  Modules
//
//  Created by Dawand Sulaiman on 17/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapAnnotation.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationMapVC : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>

@property (nonatomic,weak) NSString *location;
@property (retain, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *MapView;
- (IBAction)locateMe:(id)sender;
@end
