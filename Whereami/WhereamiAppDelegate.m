//
//  WhereamiAppDelegate.m
//  Whereami
//
//  Created by Marcio Ferreira on 7/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WhereamiAppDelegate.h"
#import "MapPoint.h"

@implementation WhereamiAppDelegate

@synthesize window = _window, mapView, manager, locationTitleField, activityIndicator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    manager = [[CLLocationManager alloc] init];
    
    [manager setDelegate: self];
    [manager setDesiredAccuracy:kCLLocationAccuracyBest];
    [manager setDistanceFilter:kCLDistanceFilterNone];
    
    // [manager startUpdatingLocation]; // Start thread.
    
    [mapView setShowsUserLocation:YES]; // used by MKMapView
    
    
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

-(void)findLocation {
    
    [manager startUpdatingLocation];
    [activityIndicator startAnimating];
    [locationTitleField setHidden: YES];

}

-(void)foundLocation {
    
    [locationTitleField setText:@""];
    [activityIndicator stopAnimating];
    [locationTitleField setHidden: NO];
    [manager stopUpdatingLocation];
    
}


#pragma mark --
#pragma mark CoreLocation Delegate Methods

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    NSLog(@"Location: %@", newLocation);
    
    NSTimeInterval t = [[newLocation timestamp]timeIntervalSinceNow];
    if (t < -180) {
        return;
    }
    MapPoint *mapPoint = [[MapPoint alloc] initWithCoordinate:[newLocation coordinate] title:[locationTitleField text]];
    [mapView addAnnotation: mapPoint];
    
    [mapPoint release];
    
    [self foundLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    
    NSLog(@"Could not find location => %@", [error description]);
    
}

#pragma mark --
#pragma mark MKMapViewDelegate Methods
- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views {
    
    MKAnnotationView *annotationView = [views objectAtIndex:0];
    id <MKAnnotation> mp = [annotationView annotation];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate], 250, 250);
    
    [mv setRegion:region animated:YES];
}

#pragma mark -
#pragma mark TextField Delegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([[textField text] isEqualToString:@""]) {
        return NO;
    }
    
    [self findLocation];
    [textField resignFirstResponder];
    
    return YES;    
}



- (void)dealloc
{
    [manager setDelegate:nil];
    [mapView release];
    [locationTitleField release];
    [activityIndicator release];
    [_window release];
    [super dealloc];
}

@end
