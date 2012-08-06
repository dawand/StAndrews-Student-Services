//
//  LocationMapVC.m
//  Modules
//
//  Created by Dawand Sulaiman on 17/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "LocationMapVC.h"

@implementation LocationMapVC
@synthesize location;
@synthesize MapView;
@synthesize locationManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [self.navigationController setToolbarHidden:NO];

    [self.navigationController setTitle:@"Module Location"];
    
    MapView.delegate = self;
    MapView.showsUserLocation = YES;
    MapView.mapType = MKMapTypeStandard;
    MapView.zoomEnabled = YES;
    MapView.scrollEnabled = YES;
    MapView.userInteractionEnabled = YES;
    
    NSLog(@"location is : %@",location);
    
    if([location isEqualToString:@"JC"]){
        
        MKCoordinateRegion name;
        name.center.latitude = 56.34025006110451;
        name.center.longitude =  -2.8087717294692993 ;
        name.span.longitudeDelta = 0.001;
        name.span.latitudeDelta = 0.001;
        [MapView setRegion:name animated:YES];
        
        MapAnnotation *annotation = [[MapAnnotation alloc]init];
        annotation.title = @"Jack Cole Building";
        annotation.subtitle = @"Computer Science Main Building";
        annotation.coordinate = name.center;
        [MapView addAnnotation:annotation];
    }
    
    else if([location isEqualToString:@"JH"]){
        MKCoordinateRegion name;
        name.center.latitude = 56.339934891962564;
        name.center.longitude =  -2.809458374977112 ;
        name.span.longitudeDelta = 0.001;
        name.span.latitudeDelta = 0.001;
        [MapView setRegion:name animated:YES];
        
        MapAnnotation *annotation = [[MapAnnotation alloc]init];
        annotation.title = @"John Honey Building";
        annotation.subtitle = @"Computer Science Labs Building";
        annotation.coordinate = name.center;
        [MapView addAnnotation:annotation];
    }
    
    self.locationManager = [[CLLocationManager alloc]init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    [locationManager startUpdatingLocation];
    [locationManager startUpdatingHeading];
    
    [super viewDidLoad];
}

- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    locationManager.distanceFilter = 500;
    
    [locationManager startUpdatingLocation];
}

- (void)startSignificantChangeUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    [locationManager startMonitoringSignificantLocationChanges];
}

// Delegate method from the CLLocationManagerDelegate protocol.

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    //   location = newLocation.coordinate;
    
    // If it's a relatively recent event, turn off updates to save power
    NSDate* eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0)
    {
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              newLocation.coordinate.latitude,
              newLocation.coordinate.longitude);
    }
    // else skip the event and process the next one.
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)locateMe:(id)sender {
    
    MKCoordinateRegion name;
    name.center.latitude = locationManager.location.coordinate.latitude ;
    name.center.longitude = locationManager.location.coordinate.longitude;
    name.span.longitudeDelta = 0.001;
    name.span.latitudeDelta = 0.001;
    [MapView setRegion:name animated:YES];
    
    MapAnnotation *annotation = [[MapAnnotation alloc]init];
    annotation.title = @"Your Location";
    annotation.coordinate = name.center;
    [MapView addAnnotation:annotation];
    
}
@end
