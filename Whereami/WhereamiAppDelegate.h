//
//  WhereamiAppDelegate.h
//  Whereami
//
//  Created by Marcio Ferreira on 7/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface WhereamiAppDelegate : NSObject <UIApplicationDelegate, MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) CLLocationManager *manager;
@property (nonatomic, retain) IBOutlet UITextField *locationTitleField;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

-(void)findLocation;
-(void)foundLocation;

@end
