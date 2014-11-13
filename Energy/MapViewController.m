//
//  MapViewController.m
//  Energy
//
//  Created by Admin on 28/10/14.
//  Copyright (c) 2014 Ewg. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize mapView;
@synthesize recievedZip;



-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    self.locationManager.distanceFilter = 10000; //Whenever we move
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    [self.locationManager startUpdatingLocation];
    //    NSLog(@"%@", [self deviceLocation]);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;
    //self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    recievedZip = NO;
    mapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
#endif
    [self.locationManager startUpdatingLocation];
    
    mapView.showsUserLocation = YES;
    [mapView setMapType:MKMapTypeStandard];
    [mapView setZoomEnabled:YES];
    [mapView setScrollEnabled:YES];
}

- (void)mapView:(MKMapView *)mapV didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (recievedZip)
        return;
    NSLog(@"New location%@",userLocation.location);
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!recievedZip) {
             if (!(error) && placemarks.count > 0) {
                 CLPlacemark *placemark = placemarks[0];
                 
                 MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                 [annotation setCoordinate:userLocation.location.coordinate];
                 [annotation setTitle:placemark.thoroughfare];
                 [self.mapView addAnnotation:annotation];
                 
                 int zip = [placemark.postalCode intValue];
                 
                 NSLog(@"%d", zip);
                 recievedZip = YES;
                 NSString *message = [NSString stringWithFormat:@"Please confirm your zip-code: \n %d", zip];
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:
                                           @"Zip"                              message:message delegate:self
                                                           cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                 [alertView show];
             }
             else {
                 NSLog(@"Geocode failed with error %@", error); // Error handling must required
             }
         }
     }];
}

@end
