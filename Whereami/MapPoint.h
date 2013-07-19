//
//  MapPoint.h
//  Whereami
//
//  Created by Marcio Ferreira on 8/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapPoint : NSObject <MKAnnotation>
{
    NSString *title;
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;

-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t;


@end
