//
//  MapViewController.h
//  Energy
//
//  Created by Admin on 28/10/14.
//  Copyright (c) 2014 Ewg. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface MapViewController : UIViewController <MKMapViewDelegate,  CLLocationManagerDelegate, UIAlertViewDelegate> {
    
}
@property(nonatomic, retain) IBOutlet MKMapView *mapView;
@property(nonatomic, retain) CLLocationManager *locationManager;

@property(nonatomic) bool recievedZip;

@end
